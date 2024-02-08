% Load the .mat file 
loaded_data = load('ws1_data.mat');
X = loaded_data.X;
y = loaded_data.y;
% Get the number of samples, features, and classes
[num_samples, num_features] = size(X);
num_classes = length(unique(y));

fprintf('Number of samples: %d\n', num_samples);
fprintf('Number of features: %d\n', num_features);
fprintf('Number of classes: %d\n', num_classes);

% Define the proportion of data for training (e.g., 80%)
train_ratio = 0.8;

% Split the data into training and testing sets
rng('default'); % For reproducibility
cv = cvpartition(y, 'HoldOut', 1 - train_ratio);

% Separate data into training and testing sets
X_train = X(cv.training,:);
y_train = y(cv.training,:);
X_test = X(cv.test,:);
y_test = y(cv.test,:);
% Plot the training data
figure;
scatter(X_train(y_train == 1, 1), X_train(y_train == 1, 2), 'r', 'filled', 'DisplayName', 'Class 1');
hold on;
scatter(X_train(y_train == 2, 1), X_train(y_train == 2, 2), 'b', 'filled', 'DisplayName', 'Class 2');
xlabel('Feature 1');
ylabel('Feature 2');
title('Training Data');
legend('Location', 'best');
grid on;
hold off;

% Plot the testing data
figure;
scatter(X_test(y_test == 1, 1), X_test(y_test == 1, 2), 'r', 'filled', 'DisplayName', 'Class 1');
hold on;
scatter(X_test(y_test == 2, 1), X_test(y_test == 2, 2), 'b', 'filled', 'DisplayName', 'Class 2');
xlabel('Feature 1');
ylabel('Feature 2');
title('Testing Data');
legend('Location', 'best');
grid on;
hold off;


% Define the pairs of features (indices)
pair1 = [1, 2];  % Replace with the indices of the first feature pair
pair2 = [3, 4];  % Replace with the indices of the second feature pair
% Initialize an empty cell array to store combinations
combinations = cell(0);

% Generate combinations of two features from both pairs (excluding self-combinations)
for i = 1:2
    for j = 1:2
        if i ~= j
            combination = [pair1(i), pair1(j)];
            combinations = [combinations; {combination}];
        end
    end
end

for i = 1:2
    for j = 1:2
        if i ~= j
            combination = [pair2(i), pair2(j)];
            combinations = [combinations; {combination}];
        end
    end
end

% Display the enumerated feature combinations
fprintf('Enumerated feature combinations of two features from two pairs (excluding self-combinations):\n');
for i = 1:numel(combinations)
    fprintf('%d. %s\n', i, mat2str(combinations{i}));
end

% Calculate FDRn for the first feature pair (pair1)
X_pair1 = X(:, pair1);
mu1_pair1 = mean(X_pair1(y == 1, :));  % Mean of class 1 for pair1
mu2_pair1 = mean(X_pair1(y == 2, :));  % Mean of class 2 for pair1
C1_pair1 = cov(X_pair1(y == 1, :));    % Covariance matrix of class 1 for pair1
C2_pair1 = cov(X_pair1(y == 2, :));    % Covariance matrix of class 2 for pair1

fdrn_pair1 = (mu1_pair1 - mu2_pair1) * inv(C1_pair1 + C2_pair1) * (mu1_pair1 - mu2_pair1)';

% Calculate FDRn for the second feature pair (pair2)
X_pair2 = X(:, pair2);
mu1_pair2 = mean(X_pair2(y == 1, :));  % Mean of class 1 for pair2
mu2_pair2 = mean(X_pair2(y == 2, :));  % Mean of class 2 for pair2
C1_pair2 = cov(X_pair2(y == 1, :));    % Covariance matrix of class 1 for pair2
C2_pair2 = cov(X_pair2(y == 2, :));    % Covariance matrix of class 2 for pair2

fdrn_pair2 = (mu1_pair2 - mu2_pair2) * inv(C1_pair2 + C2_pair2) * (mu1_pair2 - mu2_pair2)';

% Display FDRn for both pairs
fprintf('FDRn for pair 1: %.4f\n', fdrn_pair1);
fprintf('FDRn for pair 2: %.4f\n', fdrn_pair2);
% BEST FDR 
if fdrn_pair1 > fdrn_pair2
    fprintf('Best combination is pair1');
else
    fprintf('Best combination is pair2');
end
% Calculate Bayes' rule using the normal distribution 

normal_pdf = (mu1_pair2+mu2_pair2)/2;

% Define prior probabilities)
prior_1 = sum(y_train == 1) / length(y_train);
prior_2 = sum(y_train == 2) / length(y_train);

% Initialize an array to store predicted class labels
predicted_labels = zeros(size(X_test, 1), 1);
