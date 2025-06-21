function computationTable = createComputationTable(computationList)
% createComputationTable: Constructs a table that represents a computation pipeline.
%
% This function creates a table with two rows ('Pass' and 'Fail') and as many
% columns as there are computations in the computationList. Each column corresponds
% to a computation, and the table stores the pass and fail functions for each computation.
%
% Inputs:
%   computationList: A structure array where each element contains:
%       - name: The name of the computation (char array)
%       - pass: The function to execute if the computation succeeds (function handle)
%       - fail: The function to execute if the computation fails (function handle or empty)
%
% Outputs:
%   computationTable: A table containing the 'Pass' and 'Fail' functions for each computation.
%       - RowNames: 'Pass' and 'Fail'
%       - VariableNames: Computation names from the computationList
%       - Each entry is a cell containing a function handle (either pass or fail)

% Get the number of computations in the list
numComputations = numel(computationList);

originalVariableNames = {computationList.name};
cleanedNames = cellfun(@(name) regexprep(name, '^__', ''),...
    originalVariableNames, 'Uni', 0);


% Initialize an empty table with 2 rows ('Pass', 'Fail') and one column for each computation.
% The 'VariableTypes' specifies each column will hold a 'cell' type (to store function handles).
computationTable = table('Size', [2, numComputations], ...
    'VariableTypes', repmat({'cell'}, 1, numComputations), ...
    'VariableNames', cleanedNames, ...
    'RowNames', {'Pass', 'Fail'});

% Iterate over each computation in the list
for iComputation = 1:numComputations
    % Assign the 'Pass' function from computationList to the 'Pass' row of the table
    originalVariableName = originalVariableNames{iComputation};
    cleanedName = cleanedNames{iComputation};

    passingFcn = getPassingFcn( computationList(iComputation).pass, ...
        originalVariableName, cleanedName);

    computationTable{'Pass', cleanedName} = {passingFcn};

    % If no 'Fail' function is provided, use a default exception handler for failures
    failFunction = getFailingFunction( computationList(iComputation).fail, cleanedName);
    % if isempty(computationList(iComputation).fail)
    %     failFunction = genericExceptionHandler(cleanedName);  % Create a default fail function
    % else
    %     failFunction = computationList(iComputation).fail;  % Use the provided fail function
    % end

    % Assign the 'Fail' function to the 'Fail' row of the table
    computationTable{'Fail', cleanedName} = {failFunction};
end
end

function failFunction = getFailingFunction(scheduledFailingFunction, cleanedName)

if isempty(scheduledFailingFunction)
    failFunction = genericExceptionHandler(cleanedName);  % Create a default fail function
else
    failFunction = scheduledFailingFunction;  % Use the provided fail function
end

end

function computation = getPassingFcn(passFunction, originalName, cleanedName)

if isequal(originalName, cleanedName) % use the automatic computation
    computation = assignFcnOutputToField(cleanedName, passFunction);
else
    computation = passFunction;
end
end