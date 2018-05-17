function AnalysisStereoTest()
% AnalysisStereoTest    �S�������f�[�^�̉�̓v���O����
%
% Usage:
%
% - ���s����ƁC�t�@�C���I���_�C�A���O���\�������D��͑Ώۂ̃t�@�C����I������D
% - ���S�̐�Ύ����ɑ΂��� Prop far choice �ƁC���S�̐�Ύ������x�ɑ΂��鐳�������v�Z����D
% - ���S�̐�Ύ����ɑ΂��� Prop far choice �ƁC���S�̐�Ύ������x�ɑ΂��鐳�����̂��ꂼ��ɑ΂��āC�S������֐����t�B�b�e�B���O����D
% - Figure ���쐬���C���S�̐�Ύ����ɑ΂��� Prop far choice �ƁC���S�̐�Ύ������x�ɑ΂��鐳�������C�t�B�b�g�����S������֐��ƂƂ��ɁC�\������D
%
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
save([dataPcc.subjectID '_' dataPcc.id '_' dataPcc.date '.mat' ], 'dataPfc', 'dataPcc');