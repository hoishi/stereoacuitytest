function Result1stSession_500ms()

%4pos�̃f�[�^���܂Ƃ߂ĉ�͂��APfc( Propotion of far choice ), Pcc( Proportion of coorect choice )�̌��ʂ�`�悷��
addpath('./StereoDiffusionMRI/Script');
addpath('./StereoDiffusionMRI/Script/lib');
addpath('./StereoDiffusionMRI/Script/func');
addpath('./lib');
addpath('./func');
%% �f�[�^�̓ǂݍ���
dataFiles = GetFilesUI('mat');
rawData = LoadData(dataFiles);

%% �u���v�I�𗦂Ɛ������̌v�Z
dataPfc = GetPropFarChoice(rawData);
dataPcc = GetPropCorrect(rawData);

%% �t�B�b�e�B���O
dataPfc = FitData(dataPfc);
dataPcc = FitData(dataPcc);
% %% 2nd Session�̎���
% dataPcc = GetAll2ndDisp(dataPcc);
%% �f�[�^�ۑ�
save(['Result_500ms' '_' dataPcc.id '_' dataPcc.subjectID '_' dataPcc.date '.mat' ], 'dataPfc', 'dataPcc');

% hf_far       = figure;
% MakeFarPlot_500ms(dataPfc, hf_far);
hf_correct       = figure;
MakePFPlot_500ms(dataPcc, hf_correct);
