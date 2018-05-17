function s_stereoacuityfrommanycorrectrates_addoption
saveDir = '\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345/stereoacuity_correctrates_withcondition';
% load all subjects results data
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

% correctrates = [60,90];
correctrates = [84,84];
for i = correctrates(1):correctrates(2)
    description = sprintf('threshold_%d%%correctrate_withcondition.mat',i);
    for j = 1:length(subj)      
        value(j) = GetThreshold(i*0.01, subj{j}.dataPcc.all.fitdata.func, subj{j}.dataPcc.all.fitdata.prm);
        
        if value(j) < 0.002 || value(j) > 0.128
            value(j) = GetThreshold2(i*0.01, subj{j}.dataPcc.all.fitdata.func, subj{j}.dataPcc.all.fitdata.prm);
        end
        if value(j) < 0.002 || value(j) > 0.128
            value(j) = GetThreshold3(i*0.01, subj{j}.dataPcc.all.fitdata.func, subj{j}.dataPcc.all.fitdata.prm);
        end
        condition{j} = 'ok';
        if value(j) < 0.002 
            value(j) = NaN;
            condition{j} = 'smaller';
        elseif value(j) > 0.128
           value(j) = NaN;
           condition{j} = 'larger';
        end
        if min(subj{j}.dataPcc.all.rawDataValue) > i*0.01
            value(j) = NaN;
            condition{j} = 'smaller';
        elseif max(subj{j}.dataPcc.all.rawDataValue) < i*0.01
            value(j) = NaN;
            condition{j} = 'larger';
        end
    end
    saveName = fullfile(saveDir,description);
    save(saveName,'value','condition')
    clear value condition
end




%% Subfunction
%‹tŠÖ”
function x = GetThreshold(y, f, p)
objectFunc = @(t) (f(t, p) - y) ^ 2;
x = fminsearch(objectFunc, p(1),[]);%p(1)‹}s‚È‚Æ‚±‚ë‚ð‰Šú’l‚É‚·‚é

%‹tŠÖ”
function x = GetThreshold2(y, f, p)
objectFunc = @(t) (f(t, p) - y) ^ 2;
x = fminsearch(objectFunc, 0,[]);%p(1)‹}s‚È‚Æ‚±‚ë‚ð‰Šú’l‚É‚·‚é

%‹tŠÖ”
function x = GetThreshold3(y, f, p)
objectFunc = @(t) (f(t, p) - y) ^ 2;
x = fminsearch(objectFunc, 1,[]);%p(1)‹}s‚È‚Æ‚±‚ë‚ð‰Šú’l‚É‚·‚é

