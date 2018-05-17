function MakeFarPlot_many_session12345
% MakeFigure    データをプロットする
addpath('\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345');

PFCdata{1} = 'Result_session12345_StereoTestHaplo151201-4pos_EM_2015-12-25.mat';
PFCdata{2} = 'Result_session12345_StereoTestHaplo151201-4pos_GH_2015-12-24.mat';
PFCdata{3} = 'Result_session12345_StereoTestHaplo151201-4pos_HB_2016-01-06.mat';
PFCdata{4} = 'Result_session12345_StereoTestHaplo151201-4pos_HO_2016-01-05.mat';
PFCdata{5} = 'Result_session12345_StereoTestHaplo151201-4pos_HT_2015-12-28.mat';
PFCdata{6} = 'Result_session12345_StereoTestHaplo151201-4pos_KH_2015-12-28.mat';
PFCdata{7} = 'Result_session12345_StereoTestHaplo151201-4pos_KW_2016-01-09.mat';
PFCdata{8} = 'Result_session12345_StereoTestHaplo151201-4pos_MF_2015-12-24.mat';
PFCdata{9} = 'Result_session12345_StereoTestHaplo151201-4pos_MH_2016-01-06.mat';
PFCdata{10} = 'Result_session12345_StereoTestHaplo151201-4pos_MN_2016-01-04.mat';
PFCdata{11} = 'Result_session12345_StereoTestHaplo151201-4pos_MOm_2015-12-25.mat';
PFCdata{12} = 'Result_session12345_StereoTestHaplo151201-4pos_MOn_2015-12-28.mat';
PFCdata{13} = 'Result_session12345_StereoTestHaplo151201-4pos_MY_2016-01-07.mat';
PFCdata{14} = 'Result_session12345_StereoTestHaplo151201-4pos_RT_2016-01-06.mat';
PFCdata{15} = 'Result_session12345_StereoTestHaplo151201-4pos_SF_2015-12-18.mat';
PFCdata{16} = 'Result_session12345_StereoTestHaplo151201-4pos_SoM_2015-12-25.mat';
PFCdata{17} = 'Result_session12345_StereoTestHaplo151201-4pos_TF_2016-01-04.mat';
PFCdata{18} = 'Result_session12345_StereoTestHaplo151201-4pos_TO_2016-01-12.mat';
PFCdata{19} = 'Result_session12345_StereoTestHaplo151201-4pos_YM_2016-01-08.mat';

for n = 1:length(PFCdata)
    MakeFarPlot_4many(PFCdata{n});
    close all
    clearvars -except PFCdata
end
