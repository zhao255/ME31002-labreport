%Q1
fprintf('Q1\n')
% Define the given Sudoku grid (using 0 for empty cells)
sudoku = [
    4 9 6 1 5 7 8 3 2;
    7 5 3 2 8 4 1 9 6;
    2 1 8 3 9 6 7 4 5;
    9 6 2 4 1 5 3 7 8;
    1 8 5 7 6 3 4 2 9;
    3 7 4 9 2 8 5 6 1;
    5 3 1 6 7 2 9 8 4;
    0 0 9 8 3 1 2 5 7;
    0 0 7 5 4 9 6 1 3
];

% Identifying the empty cells in the lower left 3x3 grid
empty_cells = [];
for i = 7:9
    for j = 1:3
        if sudoku(i, j) == 0
            empty_cells = [empty_cells; i, j];
        end
    end
end

% Finding which numbers are missing in the lower-left 3x3 grid
used_numbers = [];
for i = 7:9
    for j = 1:3
        if sudoku(i, j) ~= 0
            used_numbers = [used_numbers, sudoku(i, j)];
        end
    end
end

all_numbers = 1:9;
missing_numbers = setdiff(all_numbers, used_numbers);
fprintf('Missing numbers: %s\n', mat2str(missing_numbers));

% Try to solve the puzzle using Sudoku rules
solved = false;
while ~solved
    changes = false;
    for k = 1:size(empty_cells, 1)
        i = empty_cells(k, 1);
        j = empty_cells(k, 2);
        
        if sudoku(i, j) == 0
            % Check which numbers are possible for this cell
            possible = missing_numbers;
            for num = possible
                % Check row
                if any(sudoku(i, :) == num)
                    possible = setdiff(possible, num);
                    continue;
                end
                
                % Check column
                if any(sudoku(:, j) == num)
                    possible = setdiff(possible, num);
                    continue;
                end
            end
            
            if length(possible) == 1
                sudoku(i, j) = possible;
                changes = true;
            end
        end
    end
    
    if ~changes
        % If no changes were made, we need more advanced techniques
        % For this simple case, we'll just try the remaining options
        break;
    end
end

% Fill in the remaining cells through logical deduction
% Based on Sudoku rules and the information we have:
% Using the row, column, and 3x3 grid constraints

% Let's compute all possible valid configurations for the 4 empty cells
% and choose the one that satisfies Sudoku rules

possible_configs = perms(missing_numbers);
valid_config = [];

for p = 1:size(possible_configs, 1)
    config = possible_configs(p, :);
    test_sudoku = sudoku;
    
    % Fill in the empty cells with this configuration
    test_sudoku(empty_cells(1,1), empty_cells(1,2)) = config(1);
    test_sudoku(empty_cells(2,1), empty_cells(2,2)) = config(2);
    test_sudoku(empty_cells(3,1), empty_cells(3,2)) = config(3);
    test_sudoku(empty_cells(4,1), empty_cells(4,2)) = config(4);
    
    % Check if this configuration is valid
    valid = true;
    
    % Check rows 8-9
    for i = 8:9
        if length(unique(test_sudoku(i, :))) ~= 9
            valid = false;
            break;
        end
    end
    
    if ~valid
        continue;
    end
    
    % Check columns 1-2
    for j = 1:2
        if length(unique(test_sudoku(:, j))) ~= 9
            valid = false;
            break;
        end
    end
    
    if valid
        valid_config = config;
        break;
    end
end

% Fill in the valid configuration
if ~isempty(valid_config)
    sudoku(empty_cells(1,1), empty_cells(1,2)) = valid_config(1);
    sudoku(empty_cells(2,1), empty_cells(2,2)) = valid_config(2);
    sudoku(empty_cells(3,1), empty_cells(3,2)) = valid_config(3);
    sudoku(empty_cells(4,1), empty_cells(4,2)) = valid_config(4);
end

% Display the completed grid
fprintf('Completed Sudoku grid:\n');
disp(sudoku);




%Q2
% Define the coordinates of the path
x = [1, 1, 2, 2, 2, 3, 3, 2, 1, 1, 2, 3, 4, 4, 4, 4, 3, 3, 4, 5, 5, 5, 5, 5, 5];
y = [6, 5, 5, 4, 3, 3, 2, 2, 2, 1, 1, 1, 1, 2, 3, 4, 4, 5, 5, 5, 4, 3, 2, 1, 0];

% Create a figure
figure('Position', [100, 100, 800, 600]);

% Plot the path
plot(x, y, 'k-', 'LineWidth', 2);
hold on;

% Mark the starting point with a blue circle
scatter(x(1), y(1), 100, 'b', 'filled');
text(x(1)+20, y(1), 'Start', 'FontSize', 12);

% Mark the ending point with a red circle
scatter(x(end), y(end), 100, 'r', 'filled');
text(x(end)-20, y(end), 'Finish', 'FontSize', 12);
legend('Path', 'Start Point', 'End Point', 'Location', 'best');

% Set axis properties
axis equal;
axis([0, 6, -1, 7]);
set(gca, 'XTick', [], 'YTick', []);
box on;

% Set title
title('ANS for Q2 solution of the maze from Start to End', 'FontSize', 14);



%Q3
fprintf('\nQ3\n')
% Program to identify numbers that need to be passed in the "Every 7 must pass" game
% Numbers to be passed: contains 7 or divisible by 7

% Initialize an array to store the numbers to be passed
pass_numbers = [];
pass_count = 0;

% Loop through numbers 1 to 150
for num = 1:150
    % Check if number is divisible by 7
    is_divisible_by_7 = (mod(num, 7) == 0);
    
    % Check if number contains digit 7
    contains_7 = false;
    temp_num = num;
    
    % Extract each digit and check if it's 7
    for digit_position = 1:floor(log10(num)) + 1
        digit = mod(temp_num, 10);
        if digit == 7
            contains_7 = true;
        end
        temp_num = floor(temp_num / 10);
    end
    
    % If either condition is true, this number should be passed
    if is_divisible_by_7 || contains_7
        pass_count = pass_count + 1;
        pass_numbers(pass_count) = num;
    end
end

% Display the result
disp('Numbers that need to be passed:');
disp(pass_numbers);
disp(['Total count: ', num2str(pass_count)]);



%Q4
fprintf('\nQ4\n')
function total_score = calculate_final_score(E, A, S, C)
    % Calculate the raw score using the formula
    T = E * (70/100) + A * (15/100) + S * (5/100) + C;
    
    % Apply the rules for total score calculation
    if C >= 5
        total_score = min(100, T);
    else
        total_score = min(75, T);
    end
end

% Test case 1: E = 80, A = 92, S = 80, C = 4
E1 = 80;
A1 = 92;
S1 = 80;
C1 = 4;
score1 = calculate_final_score(E1, A1, S1, C1);
fprintf('Final score with E=%d, A=%d, S=%d, C=%d: %.2f\n', E1, A1, S1, C1, score1);

% Test case 2: Determine C needed to pass with E = 22, A = 30, S = 0
E2 = 22;
A2 = 30;
S2 = 0;
% Start with C = 0 and increase until passing score is reached
C_needed = 0;
passing_score = 60; % Assuming 60 is the passing threshold
score = 0;

while score < passing_score && C_needed <= 100
    C_needed = C_needed + 1;
    score = calculate_final_score(E2, A2, S2, C_needed);
end

if C_needed <= 100
    fprintf('With E=%d, A=%d, S=%d, you need C=%d award bonus points to pass.\n', E2, A2, S2, C_needed);
else
    fprintf('It is not possible to pass with E=%d, A=%d, S=%d, even with maximum bonus points.\n', E2, A2, S2);
end