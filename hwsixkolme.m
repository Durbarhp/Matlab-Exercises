% Load the provided data from the "t096.mat" file
load('t096.mat');

% Define the set of k values to test
k_values_to_test = [1, 3, 5];

% Initialize variables to store KL divergence for each k value
kl_divergences = zeros(length(k_values_to_test), 1);

% Estimate parameters of a normal distribution from the data
mu_est = mean(x1);  % Estimated mean
sigma_est = std(x1);  % Estimated standard deviation

% Define the true normal distribution using estimated parameters
true_normal_dist = @(x) normpdf(x, mu_est, sigma_est);

% Loop through different k values to test
for i = 1:length(k_values_to_test)
    k = k_values_to_test(i);  % Current k value
    
    % Initialize density estimate vector
    p_hat = zeros(size(x1));
    
    % Nearest-neighbor density estimation for each data point
    for j = 1:length(x1)
        % Calculate distances from x1(j) to all other points
        distances = abs(x1 - x1(j));
        
        % Sort distances in ascending order
        sorted_distances = sort(distances);
        
        % Calculate the local volume V containing k nearest neighbors
        V = sorted_distances(k);
        
        % Nearest-neighbor density estimate
        p_hat(j) = k / (length(x1) * V);
    end
    
    % Calculate KL divergence between p_hat and the true normal distribution
    kl_divergence = sum(p_hat .* log(p_hat ./ true_normal_dist(x1)));
    
    % Store the KL divergence for the current k
    kl_divergences(i) = kl_divergence;
end

% Find the index of the minimum KL divergence
[~, best_k_index] = min(kl_divergences);

% Get the best value of k from the specified set
best_k = k_values_to_test(best_k_index);

% Display results
disp(['Best k-value from {1, 3, 5}: ', num2str(best_k)]);
disp(['Minimum KL Divergence for Best k: ', num2str(kl_divergences(best_k_index))]);

% Plot the density estimate using the best k-value
figure;
plot(x1, p_hat);
title(['Nearest-Neighbor Density Estimation (k = ', num2str(best_k), ')']);
xlabel('Data Points');
ylabel('Density Estimate');
