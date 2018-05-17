function Result1stSession_500ms()

%4posのデータをまとめて解析し、Pfc( Propotion of far choice ), Pcc( Proportion of coorect choice )の結果を描画する
addpath('./StereoDiffusionMRI/Script');
addpath('./StereoDiffusionMRI/Script/lib');
addpath('./StereoDiffusionMRI/Script/func');
addpath('./lib');
addpath('./func');
%% データの読み込み
dataFiles = GetFilesUI('mat');
rawData = LoadData(dataFiles);

%% 「奥」選択率と正答率の計算
dataPfc = GetPropFarChoice(rawData);
dataPcc = GetPropCorrect(rawData);

%% フィッティング
dataPfc = FitData(dataPfc);
dataPcc = FitData(dataPcc);
% %% 2nd Sessionの視差
% dataPcc = GetAll2ndDisp(dataPcc);
%% データ保存
save(['Result_500ms' '_' dataPcc.id '_' dataPcc.subjectID '_' dataPcc.date '.mat' ], 'dataPfc', 'dataPcc');

% hf_far       = figure;
% MakeFarPlot_500ms(dataPfc, hf_far);
hf_correct       = figure;
MakePFPlot_500ms(dataPcc, hf_correct);
