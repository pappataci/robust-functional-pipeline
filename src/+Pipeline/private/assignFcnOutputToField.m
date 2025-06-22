function outerFcn = assignFcnOutputToField(fieldName, processingFcn)

    function row = assigner(row)
        try
            result = processingFcn(row);
            row.(fieldName) = {result};
        catch ME
            newME = MException('Pipeline:ProcessingFailed', ...
                sprintf('Assignment to field "%s" failed. Cause: %s', fieldName, ME.message));
            newME = addCause(newME, ME);
            throw(newME);  %
        end
    end

outerFcn = @assigner;
end