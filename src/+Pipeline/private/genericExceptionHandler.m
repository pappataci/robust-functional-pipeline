function output = genericExceptionHandler(outputField )
% outputField is a char array specifying the name of the table column where 
% the output (exception) will be stored.

% This helper function captures potential exceptions from previous 
% computations and stores the exception in the specified table column.

arguments
    outputField char
end
    
% Define a closure with the outputField, to be invoked 
% if an exception is thrown.
    function row = computation(row, ME)
        row.(outputField) = {ME};
    end

output = @computation;

end