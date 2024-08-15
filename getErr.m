function [err] = getErr(act, des, time)

% build final error plot
activation_error = [3 .* (act(:, 1) - des(:, 1)), ...
                    -6 .* (act(:, 2) - des(:, 2)), ... 
                    act(:, 3) - des(:, 3), ...
                    act(:, 4), ... 
                    act(:, 5), ...
                    act(:, 6)];
figure(2)
hold on
grid on

plot(time, activation_error, 'LineWidth', 1.5)
title('Error from Activation Function over time')
xlabel('time')
ylabel('Activation Function Error')
legend('X', 'Y', 'Z', '\phi', '\theta', '\psi')

hold off

% build final reward plot
R_pos = [30 .* (act(:, 1) - des(:, 1)).^2, 50 .* (act(:, 2) - des(:, 2)).^2, 10 .* (act(:, 3) - des(:, 3)).^2];
R_ang = 10 .* [(act(:, 4)).^2, (act(:, 5)).^2, (act(:, 6)).^2];
R = [-R_pos, -R_ang];
figure(3)
hold on
grid on

plot(time, R, 'LineWidth', 1.5)
title('Reward function vs. time')
xlabel('time')
ylabel('Reward')
legend('X', 'Y', 'Z', '\phi', '\theta', '\psi')

hold off

% quantify RMSE
err = zeros(6, 1);
for i = 1:3

    diff = act(:, i) - des(:, i);
    diff_sq = diff .^ 2;
    numerator = sum(diff_sq);
    almost = numerator ./ length(act);
    final = sqrt(almost);
    err(i) = final;

end

for i = 4:6

    diff = act(:, i) - zeros(size(act(:, i)));
    diff_sq = diff .^ 2;
    numerator = sum(diff_sq);
    almost = numerator ./ length(act);
    final = sqrt(almost);
    err(i) = final;

end

end













