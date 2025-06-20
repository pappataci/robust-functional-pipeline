% EXAMPLE: Default Exception Handling (divide by zero)
% Demonstrates how a computation failure is gracefully caught by the pipeline
% using the default fail handler (result is replaced with the error object)

clear; clc;

% Create test table with some values of y = 0
N = 5;
T = table((10:10+N-1)', (0:N-1)', 'VariableNames', {'x', 'y'});

% Define a computation that fails when y == 0
cellPipeline = {
    'result', @(row) divideByNumber(row.x, row.y)
};

% Process the table with default exception-safe pipeline
out = Pipeline.processTable(T, cellPipeline);

% Display full result table
disp(out);

% Inspect the captured exception for the first failing row
disp(out.result{1});

% Function will fail on y == 0, triggering fallback
function out = divideByNumber(x, y)
    assert(y ~= 0, 'Error: divide by zero');
    out = x / y;
end