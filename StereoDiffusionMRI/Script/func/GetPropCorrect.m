function dataPcc = GetPropCorrect(rawData)
%% ��ԏ��A�������A�e�ʒu�Ǝ����̐�Βl���Ƃ̃g���C�A�����A�������A���̕W���΍����o�͂���

%dataPfc�̃f�[�^���g��
dataPfc = GetPropFarChoice(rawData);
%�f�[�^�^�C�v
dataPcc.id          = dataPfc.id;
dataPcc.subjectID   = rawData(1).exp.subjectID;
dataPcc.date        = rawData(1).date;
dataPcc.description = 'Correct Choice';
dataPcc.type        = 'PCC';
%���ׂĂ̏�Ԃɖ��̂�t����
for n = 1:length(dataPfc.condition)
    dataPcc.condition(n).description = dataPfc.condition(n).description; 
end
%���ׂĂ̎���
dataPcc.x.value = dataPfc.x.value( dataPfc.x.value > 0);
%% ��ԂƎ������x���Ƃɐ����������߂�
for n = 1:dataPfc.ExpNum
    dataMagDispVsConTrialNumMat(:,:,n) = flipud( dataPfc.dataUsedinPcc.dataDispVsConTrialNumMat(dataPfc.x.value<0,:,n) ) + dataPfc.dataUsedinPcc.dataDispVsConTrialNumMat(dataPfc.x.value>0,:,n); % �������Ƃ̊e������Ԃ̃g���C�A����
    dataMagDispVsConCorrectChoiceMat(:,:,n) = flipud( dataPfc.dataUsedinPcc.dataDispVsConTrialNumMat(dataPfc.x.value<0,:,n) - dataPfc.dataUsedinPcc.dataDispVsConFarChoiceMat(dataPfc.x.value<0,:,n) ) ...
                                              + dataPfc.dataUsedinPcc.dataDispVsConFarChoiceMat(dataPfc.x.value>0,:,n); % �������Ƃ́u���v�񓚐�
    dataMagDispVsConCorrectChoicePropMat(:,:,n) = dataMagDispVsConCorrectChoiceMat(:,:,n) ./ dataMagDispVsConTrialNumMat(:,:,n); % �������Ƃ́u���v�I��

end
%FitData�Ŏg���̂Ŋi�[
dataPcc.dataUsedinFitData.dataMagDispVsConCorrectChoicePropMat = dataMagDispVsConCorrectChoicePropMat;
dataPcc.all.dataUsedinFitData.dataMagDispVsConCorrectChoicePropMat =  mean(dataPcc.dataUsedinFitData.dataMagDispVsConCorrectChoicePropMat,2);
dataPcc.left.dataUsedinFitData.dataMagDispVsConCorrectChoicePropMat = ( dataMagDispVsConCorrectChoicePropMat(:,2,:) + dataMagDispVsConCorrectChoicePropMat(:,3,:) ) /2;
dataPcc.right.dataUsedinFitData.dataMagDispVsConCorrectChoicePropMat = ( dataMagDispVsConCorrectChoicePropMat(:,1,:) + dataMagDispVsConCorrectChoicePropMat(:,4,:) ) /2;

% datadpMagMat = repmat(dataPfc.x.value(dataPfc.x.value>0),1,length(dataPfc.condition));
%�S�����̊e������Ԃ́E�E�E
dataTrialMagMat = sum( dataMagDispVsConTrialNumMat,3); % �g���C�A����
dataCorrectChoicePropMat = mean(dataMagDispVsConCorrectChoicePropMat,3); % ���ρu���v�I��
dataCorrectChoiceSDMat = std(dataMagDispVsConCorrectChoicePropMat, [],3); % �W���΍�
%��Ԃ��ƂɁE�E�E
for n = 1:length(dataPfc.condition)
    dataPcc.condition(n).rawTrialNum = dataTrialMagMat(:,n); % �g���C�A����
    dataPcc.condition(n).rawDataValue = dataCorrectChoicePropMat(:,n); % ���ρu���v�I��
    dataPcc.condition(n).rawDataEbar = dataCorrectChoiceSDMat(:,n); % �W���΍�    
end
%������(MakePlot�Ō���W�������߂�Ƃ��Ɏg�p)
dataPcc.ExpNum = dataPfc.ExpNum;

%��Ԃ𕽋ς���
dataPcc.all.rawTrialNum = sum(dataTrialMagMat,2);
dataPcc.all.rawDataValue = mean(dataCorrectChoicePropMat,2);
dataPcc.all.rawDataEbar = mean(dataCorrectChoiceSDMat,2);

%���E�ŕ��ς���
dataPcc.left.rawTrialNum = ( dataPcc.condition(2).rawTrialNum + dataPcc.condition(3).rawTrialNum ) ;
dataPcc.left.rawDataValue = ( dataPcc.condition(2).rawDataValue + dataPcc.condition(3).rawDataValue ) / 2;
dataPcc.left.rawDataEbar = ( dataPcc.condition(2).rawDataEbar + dataPcc.condition(3).rawDataEbar ) / 2;
dataPcc.right.rawTrialNum = ( dataPcc.condition(1).rawTrialNum + dataPcc.condition(4).rawTrialNum ) ;
dataPcc.right.rawDataValue = ( dataPcc.condition(1).rawDataValue + dataPcc.condition(4).rawDataValue ) / 2;
dataPcc.right.rawDataEbar = ( dataPcc.condition(1).rawDataEbar + dataPcc.condition(4).rawDataEbar ) / 2;


%�]��
dataPcc.all.correctchoice = mean(dataPcc.all.rawDataValue);


    






