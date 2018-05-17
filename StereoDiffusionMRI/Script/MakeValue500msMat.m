function MakeValue500msMat()
% MakeValueMat    �S�������f�[�^�̉�̓v���O����
%
% Usage: �e�팱�҂�臒l�A�������̃f�[�^���܂Ƃ߂�mat�t�@�C���Ƃ��Đ�������
%

addpath('./StereoDiffusionMRI/Script');
addpath('./StereoDiffusionMRI/Script/lib');
addpath('./StereoDiffusionMRI/Script/func');
addpath('./lib');
addpath('./func');
%% �f�[�^�̓ǂݍ���
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
%����
for n = 1:length(dataFiles)
    if data.threshold(n) < 0.002 || data.threshold(n) > 0.128
        data.threshold(n) = NaN;
    end
end
%%���ʂÂ�
data.correctchoice(2,:) = tiedrank(data.correctchoice);



%% �f�[�^�ۑ�
save([ 'Value500ms' '_' dataPcc.id '.mat' ], 'data');