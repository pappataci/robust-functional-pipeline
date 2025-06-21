% EXAMPLE: Custom Fail Function
% This shows how to handle exceptions with your own logic
subFolderName = 'data';

getCompleteFileName = @(f) fullfile(...
    fileparts(mfilename('fullpath')), ...
    subFolderName);

tableOfFiles = table(["data1"; "data2" ; "nameIsNotCompliant";  "dataIsNotThere";  "dataIsCorrupted"] , ...
    'VariableNames', {'LocalFileName' });


pipelineExample = {'identity', @(r) r.LocalFileName};

out = Pipeline.processTable(tableOfFiles, pipelineExample);


% numComputations = height(tableOfFiles);
% cleanedNames = tableOfFiles.LocalFileName;


% computationTable = table('Size', [2, numComputations], ...
%     'VariableTypes', repmat({'cell'}, 1, numComputations), ...
%     'VariableNames', cleanedNames, ...
%     'RowNames', {'Pass', 'Fail'});
% 
