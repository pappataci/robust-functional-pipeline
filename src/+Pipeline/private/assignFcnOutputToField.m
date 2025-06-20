function outerFcn = assignFcnOutputToField(fieldName, processingFcn)
outerFcn = @(row) executer(fieldName, processingFcn, row);
end

function row = executer(fieldName, processingFcn, row)
result = processingFcn(row);
row.(fieldName) = {result};
end