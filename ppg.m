%% Loading data
clear; clc; close all;
load('roshni/Valsalva_1_rawB.txt');
x1 = Valsalva_1_rawB; % Normal breathing
load('roshni/Valsalva_2_rawC.txt'); % Hand-grip isometric compression
x2 = Valsalva_2_rawC;
%%
t1 = 0:length(x1)-1; t1 = t1*0.00328; %Sampling (3.28ms)
t2 = 0:length(x2)-1; t2 = t2*0.00328; %Sampling (3.28ms)

[b,a] = butter(6, 0.16);
y1 = filter(b,a, x1);
y2 = filter(b,a, x2);

ind2 = find(t2<12); %noisy data after 12 seconds

[pks1,locs1] = findpeaks(y1,'MinPeakDistance',130,'MinPeakHeight',7);
locs1 = locs1*0.00328;

[pks2,locs2] = findpeaks(y2(ind2),'MinPeakDistance',130,'MinPeakHeight',7);
locs2 = locs2*0.00328;


figure(1);
subplot(2,1,1); hold on; plot(t1,y1, Linewidth=1); stem(locs1,pks1); xlim([0 17]); ylim([-5 35]);
xline([3 15],'-r'); title('PPG signal during normal breathing');
subplot(2,1,2); hold on; plot(t2(ind2),y2(ind2), Linewidth=1); stem(locs2,pks2); xlim([0 17]); ylim([-5 35]);
xline([3 10],'-r'); title('PPG signal during isometric (static) compression (hand-grip)');

RRint1 = diff(locs1); HR1 = 60./RRint1; HR1 = [0;HR1];
RRint2 = diff(locs2); HR2 = 60./RRint2; HR2 = [0;HR2];

figure(2);
subplot(2,1,1); hold on; plot(t1,y1, Linewidth=1); stem(locs1, HR1); xlim([0 17]); ylim([-20 100]); 
xline([3 15],'-r'); legend('PPG', 'Instantaeous HR'); title('PPG signal during normal breathing');
subplot(2,1,2); hold on; plot(t2(ind2),y2(ind2), Linewidth=1); stem(locs2, HR2); xlim([0 17]); ylim([-20 100]);
xline([3 10],'-r'); title('PPG signal during isometric (static) compression (hand-grip)');

%% Time Domain Analysis

meanHR1 = mean(HR1(2:end));
meanHR2 = mean(HR2(2:end));

meanRR1 = mean(RRint1);
meanRR2 = mean(RRint2);

SDRR1 = std(RRint1)*1000;
SDRR2 = std(RRint2)*1000;

SDHR1 = std(HR1(2:end));
SDHR2 = std(HR2(2:end));

RMS_RR1 = rms(RRint1)*1000;
RMS_RR2 = rms(RRint2)*1000;

RMS_HR1 = rms(HR1(2:end));
RMS_HR2 = rms(HR2(2:end));

Range_HR1 = max(HR1(2:end)) - min(HR1(2:end));
Range_HR2 = max(HR2(2:end)) - min(HR2(2:end));

%%


