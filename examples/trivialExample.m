rng(1); % Set the seed for reproducibility
N = 5; % Number of rows
data = rand(N, 2); % Generate N rows and 2 columns of random numbers
T = array2table(data, 'VariableNames', {'X', 'Y'}); % Create table with specified column names

% Display the table in the command window
disp(T);

computationCell = {'Sum'     , @(r) r.X + r.Y
                   'Square'  , @(r) r.Sum{1}^2};

result = Pipeline.processTable(T, computationCell);