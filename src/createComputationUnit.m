function compUnit = createComputationUnit(cellArray)
    % Convert cell array to struct with defined field names
    compUnit = cell2struct(cellArray, {'name', 'pass', 'fail'}, 2);
end