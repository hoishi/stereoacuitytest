load('threshold_84%correctrate_withcondition.mat')
stereoacuity = value(find(~isnan(value)))';
T = table(stereoacuity);
filename = 'stereo_2017_12_11.xlsx';
writetable(T,filename,'Sheet',1,'Range','D1')