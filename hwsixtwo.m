% Load the data
load('t096.mat');

% Standardiz the variables 
x1_std = (x1 - mean(x1)) / std(x1);
x2_std = (x2 - mean(x2)) / std(x2);

% Perform Kolmogorov-Smirnov for standardized x1
[h1, p1, ks1] = kstest(x1_std, 'Alpha', 0.05); %0.05 given

% Perform Kolmogorov-Smirnov for standardized x2
[h2, p2, ks2] = kstest(x2_std, 'Alpha', 0.05);

% Display the results for standardized x1
disp('standardized x1:');
if h1 == 0
    disp('Null Hypothesis H0: standardized x1 is normally distributed is not rejected.');
else
    disp('Null Hypothesis H0: standardized x1 is normally distributed is rejected.');
end
disp(['P-Value: ', num2str(p1)]);
disp(['Kolmogorov-Smirnov test: ', num2str(ks1)]);

% Display the results for standardized x2
disp(' standardized x2:');
if h2 == 0
    disp('Null Hypothesis H0: standardized x2 is normally distributed is not rejected.');
else
    disp('Null Hypothesis H0: standardized x2 is normally distributed is rejected.');
end
disp(['P-Value: ', num2str(p2)]);
disp(['Kolmogorov-Smirnov test: ', num2str(ks2)]);
