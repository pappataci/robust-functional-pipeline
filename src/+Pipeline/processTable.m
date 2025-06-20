function completeTable = processTable(inputTable, computationTableOrCell, logger)
arguments
    inputTable table
    computationTableOrCell  {mustBeTableOrCell(computationTableOrCell)}
    logger function_handle = @noop
end

% processTable: Processes the input table by applying a computation pipeline to each row.
%
% This function augments the input table with new output columns based on the
% computation table, then processes each row of the table using the created pipeline.
%
% Inputs:
%   inputTable: A table with the original input data.
%   computationTable: A table containing the pass/fail functions for each computation.
%
% Outputs:
%   completeTable: The augmented table after applying the computations to each row.
%

computationTable = tableOrCellToTable(computationTableOrCell);

% Extract the output variable names from the computation table.
outputVariableNames = computationTable.Properties.VariableNames;

% Augment the input table with additional columns for the outputs.
completeTable = augmentInputTableWithOutputs(inputTable, outputVariableNames);

% Create the computation pipeline using the computation table.
executePipeline = createComputationPipeline(computationTable);

% Convert the table to a struct array for faster row-wise iteration.
inputStruct = table2struct(completeTable);

% Get the number of rows to process.
allRows = numel(inputStruct);

% Loop through each row and apply the computation pipeline.
for iCurrentRow = 1 : allRows
    logger(iCurrentRow, allRows, inputStruct(iCurrentRow));  % Log the current row
    row = inputStruct(iCurrentRow);
    row = executePipeline(row);  % Apply the pipeline to each row
    inputStruct(iCurrentRow) = row;  % Store the processed row back
end

% Convert the struct array back to a table.
completeTable = struct2table(inputStruct);
end

function noop(~,~,~)
end

% Validation function to check if input is a table or cell array
function mustBeTableOrCell(input)
    if ~(istable(input) || iscell(input))
        error("Input must be a table or cell array.");
    end
end

function outputTable = tableOrCellToTable(cellOrTable)
if istable(cellOrTable)
    processingFcn = @(x) x; % identity, already a table
else
    processingFcn = @createComputationTableFromCell; 
end
    outputTable = processingFcn(cellOrTable);
end
