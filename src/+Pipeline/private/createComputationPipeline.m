function executablePipeline = createComputationPipeline(computationTable)
% createComputationPipeline: Builds an executable pipeline from a computation table.
%
% This function takes a table of computations (with pass and fail functions)
% and constructs a processing pipeline. Each computation is wrapped in a robust
% computation handler, and the pipeline processes each row of a table sequentially.
%
% Inputs:
%   computationTable: A table with 'Pass' and 'Fail' function handles for each computation.
%
% Outputs:
%   executablePipeline: A function handle that processes a single row of a table using the pipeline.

% Get the number of computations (functions) to process.
nFcns = width(computationTable);

% Initialize a cell array to hold the pipeline processors.
pipelineProcessor = cell(nFcns,1);

% Iterate through each computation to create the robust computation functions.
for iFcn = 1 : nFcns % Could use cellfun, but a for-loop is easier to debug.
    
    % Extract the pass and fail functions from the computation table.
    passFcn = computationTable{'Pass', iFcn}{1};
    failFcn = computationTable{'Fail', iFcn}{1};
    
    % Create a robust computation that handles success and failure.
    pipelineProcessor{iFcn} = createRobustComputation(passFcn, failFcn);
    
end

    % Local function to process a single row using the pipeline processors.
    function currentRow = processRow(currentRow)
        for iProcessor = 1 : nFcns
            currentRow = pipelineProcessor{iProcessor}(currentRow); % Apply each processor to the row.
        end
    end

% Return the function handle for processing a row through the entire pipeline.
executablePipeline = @processRow;

end
