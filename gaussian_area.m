
% 高斯变量面积分解动画
% 1/2 (左) + (1/2)erf (中) + (1/2)erfc (右) = 1
clear; clc; close all;

% ===== 参数 =====
a = 2;
sigma = 1;
x0 = 3.5;

% ===== x 轴 =====
x = linspace(a - 4*sigma, a + 4*sigma, 2000);
f = (1/(sqrt(2*pi)*sigma)) * exp(-(x-a).^2 / (2*sigma^2));
peak = 1/(sqrt(2*pi)*sigma);

% ===== 分区索引 =====
idx_left  = (x <= a);
idx_mid   = (x >= a) & (x <= x0);
idx_right = (x >= x0);

% ===== 绘图初始化 =====
figure('Position', [50 50 1400 1100], 'Color', 'w', ...
       'MenuBar', 'figure');
hold on; grid on; box on;

axis([a-4*sigma a+4*sigma 0 peak*1.2]);
set(gca, 'XTick', -2:1:6);
set(gca, 'YTick', 0:0.1:0.5);

ylabel('f(x)');
view(0, 90);

% x 标签放最右边
text(a+4*sigma, -0.02, 'x', 'HorizontalAlignment', 'center', ...
     'FontSize', 14, 'FontWeight', 'bold');

% ===== 标题：高斯变量 =====
main_title = '高斯变量 f(x) = 1/(\surd{2\pi}\sigma) exp(-(x-a)^2/(2\sigma^2))';
text(0.5, 1.02, main_title, 'Units', 'normalized', ...
     'HorizontalAlignment', 'center', ...
     'FontSize', 12, 'FontWeight', 'bold');

% ===== GIF 保存 =====
gif_filename = 'gaussian_area.gif';
gif_delay = 1.0;
frame_count = 0;

% =========================================================
% 第 0 帧：空白
% =========================================================
drawnow;
frame_count = frame_count + 1;
frame = getframe(gcf);
im = frame2im(frame);
[A, map] = rgb2ind(im, 256);
imwrite(A, map, gif_filename, 'gif', ...
        'LoopCount', Inf, 'DelayTime', gif_delay);

% =========================================================
% 第 1 帧：高斯曲线 + 峰值点
% =========================================================
plot(x, f, 'b', 'LineWidth', 2);
plot(a, peak, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
text(a, peak + 0.02, 'f(a)', 'HorizontalAlignment', 'center', ...
     'FontSize', 11);

drawnow;
frame_count = frame_count + 1;
frame = getframe(gcf);
im = frame2im(frame);
[A, map] = rgb2ind(im, 256);
imwrite(A, map, gif_filename, 'gif', ...
        'WriteMode', 'append', 'DelayTime', gif_delay);
pause(1.0);

% =========================================================
% 第 2 帧：x = a 虚线 + 左侧面积 = 1/2
% =========================================================
plot([a a], [0 peak*1.1], 'k--', 'LineWidth', 1.2);

fill([x(idx_left) fliplr(x(idx_left))], ...
     [f(idx_left) zeros(1,sum(idx_left))], ...
     [0.6 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.6);

text(a - 1.5*sigma, peak*0.5, '面积 = 1/2', ...
     'HorizontalAlignment', 'center', 'FontSize', 12, ...
     'Color', [0 0.3 0.7], 'FontWeight', 'bold');
text(a, -0.03, 'a', 'HorizontalAlignment', 'center', ...
     'FontSize', 12, 'FontWeight', 'bold');

drawnow;
frame_count = frame_count + 1;
frame = getframe(gcf);
im = frame2im(frame);
[A, map] = rgb2ind(im, 256);
imwrite(A, map, gif_filename, 'gif', ...
        'WriteMode', 'append', 'DelayTime', gif_delay);
pause(1.2);

% =========================================================
% 第 3 帧：x = x0 虚线 + 中间面积 = (1/2)erf
% =========================================================
plot([x0 x0], [0 peak*1.1], 'k--', 'LineWidth', 1.2);

fill([x(idx_mid) fliplr(x(idx_mid))], ...
     [f(idx_mid) zeros(1,sum(idx_mid))], ...
     [0.6 1 0.6], 'EdgeColor', 'none', 'FaceAlpha', 0.6);

text((a+x0)/2, peak*0.5, ...
     'S = (1/2) erf((x_0-a)/(\surd{2}\sigma))', ...
     'HorizontalAlignment', 'center', 'FontSize', 11, ...
     'Color', [0 0.5 0], 'FontWeight', 'bold');
text(x0, -0.03, 'x_0', 'HorizontalAlignment', 'center', ...
     'FontSize', 12, 'FontWeight', 'bold');

drawnow;
frame_count = frame_count + 1;
frame = getframe(gcf);
im = frame2im(frame);
[A, map] = rgb2ind(im, 256);
imwrite(A, map, gif_filename, 'gif', ...
        'WriteMode', 'append', 'DelayTime', gif_delay);
pause(1.2);

% =========================================================
% 第 4 帧：右侧面积 = (1/2)erfc
% =========================================================
fill([x(idx_right) fliplr(x(idx_right))], ...
     [f(idx_right) zeros(1,sum(idx_right))], ...
     [1 0.7 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.6);

text(x0 + 1.3*sigma, peak*0.5, ...
     'S = (1/2) erfc((x_0-a)/(\surd{2}\sigma))', ...
     'HorizontalAlignment', 'center', 'FontSize', 11, ...
     'Color', [0.7 0 0], 'FontWeight', 'bold');

drawnow;
frame_count = frame_count + 1;
frame = getframe(gcf);
im = frame2im(frame);
[A, map] = rgb2ind(im, 256);
imwrite(A, map, gif_filename, 'gif', ...
        'WriteMode', 'append', 'DelayTime', gif_delay);
pause(1.2);

% =========================================================
% 第 5 帧：显示三者关系 = 1
% =========================================================
text(a, peak*1.15, ...
     '1/2 + (1/2)erf + (1/2)erfc = 1', ...
     'HorizontalAlignment', 'center', 'FontSize', 13, ...
     'Color', [0.8 0 0.8], 'FontWeight', 'bold');

drawnow;
frame_count = frame_count + 1;
frame = getframe(gcf);
im = frame2im(frame);
[A, map] = rgb2ind(im, 256);
imwrite(A, map, gif_filename, 'gif', ...
        'WriteMode', 'append', 'DelayTime', 2.0);

hold off;

