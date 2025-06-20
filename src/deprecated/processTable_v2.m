function completeTable = processTable_v2(inputTable, computationTableOrCell, logger)
arguments
    inputTable table
    computationTableOrCell {mustBeTableOrCell(computationTableOrCell)}
    logger function_handle = @noop
end

% STEP 1: Preserve original and create valid variable names
originalNames = inputTable.Properties.VariableNames;
validNames = matlab.lang.makeValidName(originalNames);

% Build a map from original → valid names
nameMap = containers.Map(originalNames, validNames);

% Apply the valid names to the table for struct conversion
inputTable.Properties.VariableNames = validNames;

% STEP 2: Prepare pipeline
computationTable = tableOrCellToTable(computationTableOrCell);
outputVariableNames = computationTable.Properties.VariableNames;
completeTable = augmentInputTableWithOutputs(inputTable, outputVariableNames);
executePipeline = createComputationPipeline(computationTable);

% STEP 3: Convert to struct array
inputStruct = table2struct(completeTable);

% STEP 4: Inject __nameMap field into each struct row
for i = 1:numel(inputStruct)
    inputStruct(i).__nameMap = nameMap;
end

% STEP 5: Run the pipeline
allRows = numel(inputStruct);
for iCurrentRow = 1:allRows
    logger(iCurrentRow, allRows, inputStruct(iCurrentRow));
    row = inputStruct(iCurrentRow);
    row = executePipeline(row);
    inputStruct(iCurrentRow) = row;
end

% STEP 6: Convert back to table and restore original names
completeTable = struct2table(inputStruct);
completeTable.__nameMap = [];  % Optional: remove __nameMap column
completeTable.Properties.VariableNames = [originalNames, outputVariableNames];

end

function noop(~,~,~)
end

function mustBeTableOrCell(input)
    if ~(istable(input) || iscell(input))
        error("Input must be a table or cell array.");
    end
end

function outputTable = tableOrCellToTable(cellOrTable)
    if istable(cellOrTable)
        outputTable = cellOrTable;
    else
        outputTable = createComputationTableFromCell(cellOrTable);
    end
end
