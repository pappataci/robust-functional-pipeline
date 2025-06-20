function computationTable = createComputationTableFromCell(cellArray)
% createComputationTableFromCell: Creates a computation table from a cell array input.
%
% This function converts a cell array into a computation table by ensuring
% the cell array has three columns (adding a third column if missing), then
% processing it into computation units and building the computation table.
%
% Inputs:
%   cellArray: A cell array where each row corresponds to a computation,
%              with two or three columns (name, pass function, and optionally fail function).
%
% Outputs:
%   computationTable: A table representing the computation pipeline, generated from the cell array.
%
% Ensure the cell array has three columns; if only two columns are provided, 
% assign an empty array as the third column.
if size(cellArray, 2) == 2
    cellArray(:,3) = {[]};  % Assign empty array to the third column if missing.
end

% Convert the cell array into computation units.
computationUnit = createComputationUnit(cellArray);

% Build the computation table using the computation units.
computationTable = createComputationTable(computationUnit);
end
