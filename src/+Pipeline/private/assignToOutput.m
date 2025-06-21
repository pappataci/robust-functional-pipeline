function row = assignToOutput(row, outputField, value)
% assignToOutput: Safely assigns a value to a specific column of a row struct/table
%
% Inputs:
%   row         - The row (struct or table row) to modify
%   outputField - Name of the field to assign to (char or string)
%   value       - The value to assign (wrapped in a cell, if needed)
%
% Returns:
%   row - The modified row with the output assigned

    row.(outputField) = {value};
end