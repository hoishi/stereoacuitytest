function MakeValue500msMat()
% MakeValueMat    心理実験データの解析プログラム
%
% Usage: 各被験者の閾値、正答率のデータをまとめてmatファイルとして生成する
%

addpath('./StereoDiffusionMRI/Script');
addpath('./StereoDiffusionMRI/Script/lib');
addpath('./StereoDiffusionMRI/Script/func');
addpath('./lib');
addpath('./func');
%% データの読み込み
dataFiles = GetFilesUI('mat');

for n = 1:length(dataFiles)
    load(dataFiles{n});
    data.subjectID{n} = dataPcc.subjectID;
    data.threshold(n) = dataPcc.all.sppData(1).value;
    data.PSE(n) = dataPfc.all.sppData(1).value;
%     data.nearthreshold(n) = dataPfc.all.sppData(4).value;
%     data.farthreshold(n) = dataPfc.all.sppData(5).value;
    data.correctchoice(n) = dataPcc.all.correctchoice;
end
%条件
for n = 1:length(dataFiles)
    if data.threshold(n) < 0.002 || data.threshold(n) > 0.128
        data.threshold(n) = NaN;
    end
end
%%順位づけ
data.correctchoice(2,:) = tiedrank(data.correctchoice);



%% データ保存
save([ 'Value500ms' '_' dataPcc.id '.mat' ], 'data');