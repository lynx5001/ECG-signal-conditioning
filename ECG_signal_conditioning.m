%% Exam Project - Biomedical Signal Processing

% ECG signal conditioning 
% by morphological filtering (Paper 4)
%
% By Louis ****** ****

clc; clear;

%% Load and read in the signal
load('rec_2m.mat');
f0 = val;

% Sampling Frequency of the ECG in Hz
fsample = 500;

%% Estimate Baseline drift and substract from Signal
% Create length of structure elements
lo = 0.2*fsample;
lc = 1.5*lo;

% Create two horizontal line segments as structure elements Bo and Bc
bo = strel('line', lo, 0);
bc = strel('line', lc, 0);

% Detect Baseline drift by 
% 1. opening the original Signal with structure element b0
f0opened = imopen(f0, bo);

% 2. then closing the signal with structure element bc
fb = imclose(f0opened, bo);

% The correction of the baseline is done
% by subtracting the estimate of the baseline drift fb from the original signal f0
fbc = f0 - fb;

%% Noise Suppression
% create pair of triangle shaped structure elements for noise supression
% bpair = [b1 b2];
b1 = offsetstrel([0 1 5 1 0]);
b2 = offsetstrel([0 0 0 0 0]);

% Dilate and erode for noise supression following paper 4
f = 0.5 * (imerode(imdilate(fbc, b1), b2) + imdilate(imerode(fbc, b1), b2));

%% plotting all steps and final results
figure(1)
% first plot window
subplot(2,2,1)
plot(f0);
title('Original noisy ECG signal')

%{
% second plot window
subplot(2,2,2)
plot(fbc);
title('Signal with baseline corrected')

% third plot window
subplot(2,2,3)
plot(0);
title('Nothing for now')
%}

% fourth plot window
subplot(2,2,4)
plot(f);
title('Conditioned ECG signal')
