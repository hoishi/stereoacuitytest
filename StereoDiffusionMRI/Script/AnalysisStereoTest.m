function AnalysisStereoTest()
% AnalysisStereoTest    心理実験データの解析プログラム
%
% Usage:
%
% - 実行すると，ファイル選択ダイアログが表示される．解析対象のファイルを選択する．
% - 中心の絶対視差に対する Prop far choice と，中心の絶対視差強度に対する正答率を計算する．
% - 中心の絶対視差に対する Prop far choice と，中心の絶対視差強度に対する正答率のそれぞれに対して，心理測定関数をフィッティングする．
% - Figure を作成し，中心の絶対視差に対する Prop far choice と，中心の絶対視差強度に対する正答率を，フィットした心理測定関数とともに，表示する．
%
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
save([dataPcc.subjectID '_' dataPcc.id '_' dataPcc.date '.mat' ], 'dataPfc', 'dataPcc');