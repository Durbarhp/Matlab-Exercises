% Load file given data
load('t096.mat');

% Perform Kolmogorov-Smirnov goodness-of-fit test for x1
[h1, p1, ks1] = kstest(x1, 'Alpha', 0.05); %0.05 is given

% Perform Kolmogorov-Smirnov goodness-of-fit test for x2
[h2, p2, ks2] = kstest(x2, 'Alpha', 0.05);

% Display the null hypothesis for x1
disp('Results for x1:');
if h1 == 0
    disp('Null Hypothesis x1 is normally distributed is not rejected.');
else
    disp('Null Hypothesis x1 is normally distributed is rejected.');
end
disp(['P-Value: ', num2str(p1)]);
disp(['Kolmogorov-Smirnov: ', num2str(ks1)]);

% Display the null hypothesis for x2
disp('Results for x2:');
if h2 == 0
    disp('Null Hypothesis x2 is normally distributed is not rejected.');
else
    disp('Null Hypothesis for x2 is normally distributed is rejected.');
end
disp(['P-Value: ', num2str(p2)]);
disp(['Kolmogorov-Smirnov Statistic: ', num2str(ks2)]);
