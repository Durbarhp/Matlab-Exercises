% Load the data 
load('t096.mat');

% Perform Lilliefors'composite goodness test for x1
[h1, p1] = lillietest(x1);

% Perform Lilliefors'composite goodness test for x2
[h2, p2] = lillietest(x2);

% Display the results for x1
disp('Results for x1:');
if h1 == 0
    disp('Null Hypothesis H0: x1 normally distributed is not rejected.');
else
    disp('Null Hypothesis H0: x1  normally distributed is rejected.');
end
disp(['P-Value: ', num2str(p1)]);

% Display the results for x2
disp('Results for x2:');
if h2 == 0
    disp('Null Hypothesis H0: x2  normally distributed is not rejected.');
else
    disp('Null Hypothesis H0: x2 normally distributed is rejected.');
end
disp(['P-Value: ', num2str(p2)]);
