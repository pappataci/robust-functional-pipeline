% Minimal pipeline using custom fail function

% pipeline = {
%     'feature1', @(row) error('Oops'),  [] 
%     'feature2', @(row) row.feature1 , @(row,E) 'hallelujah'
% };


doubleIt = @(x) 2*x ;

pipeline2 = {'x2', @(~) error('hello')
             'x3', @(row) doubleIt(row.x2{1})};

T = table((1:3)', 'VariableNames', {'x'});

out = Pipeline.processTable(T, pipeline2);
disp(out)

