import * as ts from 'typescript';
import * as fs from 'fs';
import * as path from 'path';

/**
 * Traverses the AST to find an exported variable declaration by name.
 * @param {ts.SourceFile} node - The source file's AST node.
 * @param {string} varName - The name of the exported variable to find.
 * @returns {ts.ObjectLiteralExpression | undefined} The object literal AST node or undefined if not found.
 */
function findExportedObjectLiteral(node: ts.SourceFile, varName: string): ts.ObjectLiteralExpression | undefined {
    let result: ts.ObjectLiteralExpression | undefined;

    function find(node: ts.Node) {
        if (ts.isVariableStatement(node) && node.modifiers?.some(m => m.kind === ts.SyntaxKind.ExportKeyword)) {
            for (const decl of node.declarationList.declarations) {
                if (ts.isIdentifier(decl.name) && decl.name.text === varName && decl.initializer && ts.isObjectLiteralExpression(decl.initializer)) {
                    result = decl.initializer;
                    return;
                }
            }
        }
        if (!result) {
            ts.forEachChild(node, find);
        }
    }

    find(node);
    return result;
}

/**
 * Deep merges two TypeScript AST ObjectLiteralExpression nodes.
 * @param {ts.ObjectLiteralExpression} baseObj - The base object node.
 * @param {ts.ObjectLiteralExpression} overrideObj - The object with properties to override.
 * @returns {ts.ObjectLiteralExpression} A new, merged AST node.
 */
function deepMergeAstObjects(baseObj: ts.ObjectLiteralExpression, overrideObj: ts.ObjectLiteralExpression): ts.ObjectLiteralExpression {
    const baseProperties = new Map<string, ts.PropertyAssignment>();
    baseObj.properties.forEach(prop => {
        if (ts.isPropertyAssignment(prop) && ts.isIdentifier(prop.name)) {
            baseProperties.set(prop.name.text, prop);
        }
    });

    overrideObj.properties.forEach(overrideProp => {
        if (ts.isPropertyAssignment(overrideProp) && ts.isIdentifier(overrideProp.name)) {
            const propName = overrideProp.name.text;
            const baseProp = baseProperties.get(propName);

            if (baseProp && ts.isObjectLiteralExpression(baseProp.initializer) && ts.isObjectLiteralExpression(overrideProp.initializer)) {
                // Recursive merge for nested objects
                const mergedInitializer = deepMergeAstObjects(baseProp.initializer, overrideProp.initializer);
                const updatedProp = ts.factory.updatePropertyAssignment(baseProp, baseProp.name, mergedInitializer);
                baseProperties.set(propName, updatedProp);
            } else {
                // Overwrite or add the property
                baseProperties.set(propName, overrideProp);
            }
        }
    });

    return ts.factory.createObjectLiteralExpression(Array.from(baseProperties.values()), true);
}

/**
 * Collects all import declarations from a list of source files, ensuring uniqueness.
 * @param {ts.SourceFile[]} sourceFiles - An array of source file ASTs.
 * @returns {ts.ImportDeclaration[]} An array of unique import declarations.
 */
function collectImports(sourceFiles: ts.SourceFile[]): ts.ImportDeclaration[] {
    const imports = new Map<string, ts.ImportDeclaration>();
    for (const sourceFile of sourceFiles) {
        ts.forEachChild(sourceFile, node => {
            if (ts.isImportDeclaration(node)) {
                imports.set(node.getText(sourceFile), node);
            }
        });
    }
    return Array.from(imports.values());
}

// --- Main Execution Logic ---
function runMerge(outputFile: string, mergedExportName: string, exportName: string, configFiles: string[]) {
    // Create a TypeScript program to analyze our files
    const program = ts.createProgram(configFiles, {
        target: ts.ScriptTarget.ESNext,
        module: ts.ModuleKind.CommonJS
    });

    const sourceFiles = configFiles.map(file => program.getSourceFile(file)!);
    if (sourceFiles.some(sf => !sf)) {
        console.error("Could not find one or more source files.");
        return;
    }

    // 1. Extract the config objects from the AST of each file
    const configObjects = sourceFiles
        .map(sf => findExportedObjectLiteral(sf, exportName))
        .filter((obj): obj is ts.ObjectLiteralExpression => obj !== undefined);

    if (configObjects.length < 1) {
        console.error(`Could not find exported variable '${exportName}' in any file.`);
        return;
    }

    // 2. Deep merge the AST nodes, starting with the first object.
    const mergedAst = configObjects.reduce((merged, current) => deepMergeAstObjects(merged, current));

    // 3. Create the new export statement
    const newExportStatement = ts.factory.createVariableStatement(
        [ts.factory.createModifier(ts.SyntaxKind.ExportKeyword)],
        ts.factory.createVariableDeclarationList(
            [ts.factory.createVariableDeclaration(
                mergedExportName,
                undefined,
                undefined,
                mergedAst
            )],
            ts.NodeFlags.Const
        )
    );

    // 4. Collect all unique imports
    const allImports = collectImports(sourceFiles);

    // 5. Create a printer to convert AST back to string
    const printer = ts.createPrinter({ newLine: ts.NewLineKind.LineFeed });
    const resultFile = ts.createSourceFile(outputFile, "", ts.ScriptTarget.Latest, false, ts.ScriptKind.TS);

    // 6. Generate the content for the new file
    const importStatementsStr = allImports.map(imp => printer.printNode(ts.EmitHint.Unspecified, imp, resultFile)).join('\n');
    const exportStatementStr = printer.printNode(ts.EmitHint.Unspecified, newExportStatement, resultFile);

    const fileContent = `// This file is auto-generated by the merge-configs.ts script.\n// Do not edit this file directly.\n\n${importStatementsStr}\n\n${exportStatementStr}\n`;

    // 7. Write the merged config to a new file
    fs.writeFileSync(outputFile, fileContent);

    console.log(`Successfully merged configs into '${outputFile}'!`);
}

// --- Script Entry Point ---
function main() {
    // process.argv contains the full command-line invocation.
    // e.g., ['/usr/bin/node', '/path/to/ts-node', 'merge-configs.ts', 'arg1', 'arg2', ...]
    // We slice(2) to get just the script arguments.
    const args = process.argv.slice(2);

    if (args.length < 4) {
        console.error("Error: Not enough arguments.");
        console.log("Usage: ts-node merge-configs.ts <outputFile> <mergedExportName> <sourceExportName> <inputFile1> [inputFile2] ...");
        process.exit(1);
    }

    const [outputFile, mergedExportName, exportName, ...configFiles] = args;

    runMerge(outputFile, mergedExportName, exportName, configFiles);
}

// Run the script
main();
