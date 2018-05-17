% collect R-squared, stereoaucity of all participants

load('\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345\stereoacuity_correctrates_withcondition/threshold_84%correctrate_withcondition.mat');
subj{1} = load('Result_session12345_StereoTestHaplo151201-4pos_EM_2015-12-25.mat');
subj{2} = load('Result_session12345_StereoTestHaplo151201-4pos_GH_2015-12-24.mat');
subj{3} = load('Result_session12345_StereoTestHaplo151201-4pos_HB_2016-01-06.mat');
subj{4} = load('Result_session12345_StereoTestHaplo151201-4pos_HO_2016-01-05.mat');
subj{5} = load('Result_session12345_StereoTestHaplo151201-4pos_HT_2015-12-28.mat');
subj{6} = load('Result_session12345_StereoTestHaplo151201-4pos_KH_2015-12-28.mat');
subj{7} = load('Result_session12345_StereoTestHaplo151201-4pos_KW_2016-01-09.mat');
subj{8} = load('Result_session12345_StereoTestHaplo151201-4pos_MF_2015-12-24.mat');
subj{9} = load('Result_session12345_StereoTestHaplo151201-4pos_MH_2016-01-06.mat');
subj{10} = load('Result_session12345_StereoTestHaplo151201-4pos_MN_2016-01-04.mat');
subj{11} = load('Result_session12345_StereoTestHaplo151201-4pos_MOm_2015-12-25.mat');
subj{12} = load('Result_session12345_StereoTestHaplo151201-4pos_MOn_2015-12-28.mat');
subj{13} = load('Result_session12345_StereoTestHaplo151201-4pos_MY_2016-01-07.mat');
subj{14} = load('Result_session12345_StereoTestHaplo151201-4pos_RT_2016-01-06.mat');
subj{15} = load('Result_session12345_StereoTestHaplo151201-4pos_SF_2015-12-18.mat');
subj{16} = load('Result_session12345_StereoTestHaplo151201-4pos_SoM_2015-12-25.mat');
subj{17} = load('Result_session12345_StereoTestHaplo151201-4pos_TF_2016-01-04.mat');
subj{18} = load('Result_session12345_StereoTestHaplo151201-4pos_TO_2016-01-12.mat');
subj{19} = load('Result_session12345_StereoTestHaplo151201-4pos_YM_2016-01-08.mat');
for i = 1: length(subj)
   r_sq_mat(i) = subj{i}.dataPcc.all.fitdata.r_sq; 
end
vertmat = vertcat(value,r_sq_mat);
usesjb = find(~isnan(value));
r_sq_mean = mean(r_sq_mat);
r_sq_std = std(r_sq_mat);
save('Subject_stereoacuity_r_sq.mat','value','r_sq_mat','vertmat','r_sq_mean','r_sq_std');
% usesjb = find(~isnan(value));
% [r,p,ci,stats] = corrcoef(value(usesjb),r_sq_mat(usesjb));
% [r,p] = corr(horzcat(value(usesjb)',r_sq_mat(usesjb)'),'type','Spearman');
% keyboard;
