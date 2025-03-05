%% ================================================================
% This is the demo code for 
% A Novel Nonconvex Rank Approximation with Application to Matrix Completion
% Jin-Liang Xiao, Ting-Zhu Huang, Zhong-Cheng Wu， and Liang-Jian Deng, 
% East Asian Journal on Applied Mathematics (EAJAM)
% Contact email: jinliang_xiao@163.com
% Created by Jin-Liang Xiao 
% Date：2024.12.21
%% ================================================================
% If you use this code, please cite the following paper:
% A Novel Nonconvex Rank Approximation with Application to Matrix Completion
% Jin-Liang Xiao, Ting-Zhu Huang, Zhong-Cheng Wu， and Liang-Jian Deng, 
% East Asian Journal on Applied Mathematics (EAJAM)
% =========================================================================
%% parameters adjustment scope
% Please adjust the following parameters for better results
% Please adjust alpha at [1e-3,1]
% Please adjust b at [1e2,1e5]
% Please adjust p at [1.1,1.3]
% Please adjust mu at [1,1e4]

clear;clc
close all;
addpath(genpath(pwd));

DataName = 'Monarch';
X = double(imread('Monarch.png'));
X = X/255;   
[n1,n2,n3] = size(X);
sr = 0.6; % sampling rate
omega = find(rand(n1*n2*n3,1)<sr);
M = zeros(n1,n2,n3);
M(omega) = X(omega);
%% Hyperparameters
opts.alpha=0.15;
opts.b=3000;
opts.p=1.05;
opts.mu=900;

%% Model
t0 = tic;
X_pro=TFR_pam(M,omega,opts);
time = toc(t0);
time_pro=roundn(time,-3);
[out] = quality_access(X.*255, X_pro.*255);
psnr_pro=out(1);
ssim_pro=out(2);
ssim_pro=roundn(ssim_pro,-3);

%% Show result
figure(1)
subplot(1,3,1)
imshow(M)
title('Observed')
subplot(1,3,2)
imshow(X_pro)
title('Estimated')
subplot(1,3,3)
imshow(X)
title('GT')
fprintf('Data: % 2s ||SR : %5.2f   \n',DataName, sr);
fprintf('================== Result =====================\n');
fprintf(' %8.8s    %5.4s    %5.4s  %5.4s     \n','method','PSNR', 'SSIM', 'TIME');
fprintf(' %8.8s    %5.3f    %5.3f    %5.3f      \n',...
        'Proposed',psnr_pro, ssim_pro, time_pro);
fprintf('================== Result =====================\n');

