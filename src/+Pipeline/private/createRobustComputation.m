function fcn = createRobustComputation(passFunction, failFunction)
% createRobustComputation: Creates a robust computation that applies the pass function and
% catches exceptions, using the fail function to handle failures.
%
% This function generates a higher-order function that attempts to apply 'passFunction'
% to the input. If an exception occurs, it handles the error using 'failFunction'.
%
% Inputs:
%   passFunction: A function handle that performs the main computation.
%   failFunction: A function handle that handles the error (takes input and exception).
%
% Outputs:
%   fcn: A higher-order function that applies 'passFunction' and 'failFunction' on failure.

% Create a function handle that applies 'passFunction' and catches exceptions with 'failFunction'.
fcn = @(input) tryApply(passFunction, input, failFunction);
end

function output = tryApply(passFunction, input, failFunction)
% tryApply: Attempts to apply 'passFunction', falling back to 'failFunction' on error.
%
% This helper function wraps the application of the pass function in a try-catch block.
% If the pass function succeeds, it returns the result. If it fails, it applies the
% fail function, passing the input and the exception object.
%
% Inputs:
%   passFunction: The main function to apply.
%   input: The input to the function.
%   failFunction: The function to apply in case of an error, taking the input and exception.
%
% Outputs:
%   output: The result of either the pass or fail function.

try
    
    % Optimization: Check if input is already an exception
    if isa(input, 'MException')
        % If it's an MException, directly apply the fail function
        output = failFunction(input, input);
        return;
    end
    
    % Attempt to apply the pass function to the input.
    output = passFunction(input);
catch ME
    % If an error occurs, apply the fail function, passing the input and the exception.
    output = failFunction(input, ME);
end
end
