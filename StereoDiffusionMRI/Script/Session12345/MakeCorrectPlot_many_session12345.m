function MakeCorrectPlot_many_session12345
% MakeFigure    データをプロットする
addpath('\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345');

PCCdata{1} = 'Result_session12345_StereoTestHaplo151201-4pos_EM_2015-12-25.mat';
PCCdata{2} = 'Result_session12345_StereoTestHaplo151201-4pos_GH_2015-12-24.mat';
PCCdata{3} = 'Result_session12345_StereoTestHaplo151201-4pos_HB_2016-01-06.mat';
PCCdata{4} = 'Result_session12345_StereoTestHaplo151201-4pos_HO_2016-01-05.mat';
PCCdata{5} = 'Result_session12345_StereoTestHaplo151201-4pos_HT_2015-12-28.mat';
PCCdata{6} = 'Result_session12345_StereoTestHaplo151201-4pos_KH_2015-12-28.mat';
PCCdata{7} = 'Result_session12345_StereoTestHaplo151201-4pos_KW_2016-01-09.mat';
PCCdata{8} = 'Result_session12345_StereoTestHaplo151201-4pos_MF_2015-12-24.mat';
PCCdata{9} = 'Result_session12345_StereoTestHaplo151201-4pos_MH_2016-01-06.mat';
PCCdata{10} = 'Result_session12345_StereoTestHaplo151201-4pos_MN_2016-01-04.mat';
PCCdata{11} = 'Result_session12345_StereoTestHaplo151201-4pos_MOm_2015-12-25.mat';
PCCdata{12} = 'Result_session12345_StereoTestHaplo151201-4pos_MOn_2015-12-28.mat';
PCCdata{13} = 'Result_session12345_StereoTestHaplo151201-4pos_MY_2016-01-07.mat';
PCCdata{14} = 'Result_session12345_StereoTestHaplo151201-4pos_RT_2016-01-06.mat';
PCCdata{15} = 'Result_session12345_StereoTestHaplo151201-4pos_SF_2015-12-18.mat';
PCCdata{16} = 'Result_session12345_StereoTestHaplo151201-4pos_SoM_2015-12-25.mat';
PCCdata{17} = 'Result_session12345_StereoTestHaplo151201-4pos_TF_2016-01-04.mat';
PCCdata{18} = 'Result_session12345_StereoTestHaplo151201-4pos_TO_2016-01-12.mat';
PCCdata{19} = 'Result_session12345_StereoTestHaplo151201-4pos_YM_2016-01-08.mat';

for n = 1:length(PCCdata)
    MakePFPlot_4many(PCCdata{n});
    close all
    clearvars -except PCCdata
end
