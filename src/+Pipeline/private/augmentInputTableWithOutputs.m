function completeTable = augmentInputTableWithOutputs(inputTable, listOfAddedColumns)
% augmentInputTableWithOutputs: Adds new columns to the input table.
%
% This function takes an existing input table and a list of column names to be added.
% It creates a table of the same height as the input table, with the specified columns
% initialized to empty cells. The function then concatenates the input table with
% the new columns and returns the complete table.
%
% Inputs:
%   inputTable: The original table with existing data.
%   listOfAddedColumns: A cell array of names for the new columns to be added.
%
% Outputs:
%   completeTable: The augmented table with the new output columns.
%
% Determine the number of rows in the input table.
numRows = height(inputTable);

% Determine the number of new columns to add.
numCols = numel(listOfAddedColumns);

% Create an empty table for the new columns, with the same number of rows as the input table.
outputTable = array2table(cell(numRows, numCols), ...
    'VariableNames', listOfAddedColumns);

% Concatenate the input table with the new output table.
completeTable = [inputTable, outputTable];

end