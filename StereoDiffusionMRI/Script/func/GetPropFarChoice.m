function dataPfc = GetPropFarChoice(rawData)
%% ���v�I�𗦂��v�Z����֐��ł���
%% ��ԏ��A�������A�e�ʒu�Ǝ������Ƃ̃g���C�A�����A�u���v�I�𗦁A���̕W���΍����o�͂���
%% dataSet�͈���:��ԁA���ځF�����A�O��ځF�� �ł��邱��

%�f�[�^�^�C�v
dataPfc.id          = rawData(1).exp.expID;
dataPfc.subjectID   = rawData(1).exp.subjectID;
dataPfc.date        = rawData(1).date;
dataPfc.description = 'Far Choice';
dataPfc.type        = 'PFC';
if ~isnan( strfind( dataPfc.id, '4pos') ) 
    exp_id_initnamenum = strfind(dataPfc.id,'4pos') + length('4pos') -1 ;
    dataPfc.id = dataPfc.id(1:exp_id_initnamenum);
    dataSet = ExtractPDA( rawData ); 
     
    %���ׂĂ̏��
    for n = 1:length(dataSet)
        a(:,n) =  dataSet{n}(:,1);
    end
    conVar = unique(a);
    clear a;
    %��Ԃɖ��̂�t����
    %��ԏ��: �ʒu���
    for n = 1:length(conVar)
        if conVar(n) == 1 
           dataPfc.condition(1).description = 'Up-Right(1)';%����
        end
        if conVar(n) == 2 
           dataPfc.condition(2).description = 'Up-Left(2)';%����
        end
        if conVar(n) == 3 
           dataPfc.condition(3).description = 'Low-Left(3)';%����
        end
        if conVar(n) == 4 
           dataPfc.condition(4).description = 'Low-Right(4)';%����
        end    
    end
    p =0; q=0; r=0; s=0;
    for n = 1:length(dataSet)
        if dataSet{n}(:,1) == 1
            p = p + 1;
            dataPfc.condition(1).data{p} = dataSet{n};            
        end
        if dataSet{n}(:,1) == 2
            q = q + 1;
            dataPfc.condition(2).data{q} = dataSet{n};            
        end        
        if dataSet{n}(:,1) == 3
            r = r + 1;
            dataPfc.condition(3).data{r} = dataSet{n};
        end
        if dataSet{n}(:,1) == 4
            s = s + 1;
            dataPfc.condition(4).data{s} = dataSet{n}; 
        end        
    end

end
      

    
    
if ~isnan( strfind( dataPfc.id, '3freq') )    
    dataSet = ExtractRDA( rawData );
    %���ׂĂ̏��
    conVar = unique(dataSet{1}(:,1));
    %��ԏ��: ���t���b�V�����[�g
    for n = 1:length(conVar)
        if conVar(n) == 1 
           dataPfc.condition(n).description = '42.5 [Hz](1)';%����
        end
        if conVar(n) == 2 
           dataPfc.condition(n).description = '21.25 [Hz](2)';%����
        end
        if conVar(n) == 3 
           dataPfc.condition(n).description = '10.625 [Hz](3)';%����
        end
    end    
end


%���ׂĂ̎���
dataPfc.x.value = unique(dataSet{1}(:, 2));
%% ��ԂƎ������ƂɁu���v�񓚗����v�Z���� 
if isfield(dataPfc.condition(1),'data') && isfield(dataPfc.condition(2),'data') && isfield(dataPfc.condition(3),'data') && isfield(dataPfc.condition(4),'data')
for c = 1:length(dataPfc.condition) 
    for n = 1:length(dataPfc.condition(c).data)
        for m = 1:length(dataPfc.x.value)
            dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat(m) = 0; % �������ƂɊe������Ԃ̃g���C�A�������J�E���g
            dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat(m) = 0; % �������ƂɁu���v�񓚐����J�E���g
            for d = 1:size(dataPfc.condition(c).data{n},1)
                if dataPfc.condition(c).data{n}(d,1) == c && dataPfc.condition(c).data{n}(d,2) == dataPfc.x.value(m) 
                   dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat(m) = dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat(m) + 1;
                   if dataPfc.condition(c).data{n}(d,3) == 2 % �u���v�񓚂Ȃ��
                      dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat(m) = dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat(m) + 1;
                   end
                end
            end
            dataPfc.condition(c).block{n}.dataDispVsConFarChoicePropMat(m) = dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat(m) ./ dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat(m); % �������ƂɁu���v�I��
            if isnan(dataPfc.condition(c).block{n}.dataDispVsConFarChoicePropMat(m))
                dataPfc.condition(c).block{n}.dataDispVsConFarChoicePropMat(m) = 0;   
            end
        end
        dataDispVsConTrialNumMat(:,c,n) = dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat;
        dataDispVsConFarChoiceMat(:,c,n) = dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat;
        dataDispVsConFarChoicePropMat(:,c,n) = dataPfc.condition(c).block{n}.dataDispVsConFarChoicePropMat;
    end    
end
dataPfc.condition = rmfield( dataPfc.condition,'data' );
dataPfc.condition = rmfield( dataPfc.condition,'block' );

else
for n = 1:length(dataSet)
    for c = 1:length(dataPfc.condition) 
        for m = 1:length(dataPfc.x.value)
            dataDispVsConTrialNumMat(m,c,n) = 0; % �������ƂɊe������Ԃ̃g���C�A�������J�E���g
            dataDispVsConFarChoiceMat(m,c,n) = 0; % �������ƂɁu���v�񓚐����J�E���g
            for d = 1:size(dataSet{n},1)
                if dataSet{n}(d,1) == c && dataSet{n}(d,2) == dataPfc.x.value(m) 
                   dataDispVsConTrialNumMat(m,c,n) = dataDispVsConTrialNumMat(m,c,n) + 1;
                   if dataSet{n}(d,3) == 2 % �u���v�񓚂Ȃ��
                      dataDispVsConFarChoiceMat(m,c,n) = dataDispVsConFarChoiceMat(m,c,n) + 1;
                   end
                end
            end
            dataDispVsConFarChoicePropMat(m,c,n) = dataDispVsConFarChoiceMat(m,c,n) ./ dataDispVsConTrialNumMat(m,c,n); % �������ƂɁu���v�I��
        end
    end
end
end
%  dataDispVsConTrialNumMat
%  dataDispVsConFarChoiceMat
%  dataDispVsConFarChoicePropMat
% for c = 1:length(dataPfc.condition)
%     for n = 1:length(dataPfc.condition(c).data)
%         dataDispVsConTrialNumMat(:,c,n) = dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat;
%         dataDispVsConFarChoiceMat(:,c,n) = dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat;
%         dataDispVsConFarChoicePropMat(:,c,n) = dataPfc.condition(c).block{n}.dataDispVsConFarChoicePropMat;
%     end    
% end




%dataPcc�Ŏg���̂Ŋi�[����

dataPfc.dataUsedinPcc.dataDispVsConTrialNumMat = dataDispVsConTrialNumMat;
dataPfc.dataUsedinPcc.dataDispVsConFarChoiceMat = dataDispVsConFarChoiceMat;
dataPfc.dataUsedinPcc.dataDispVsConFarChoicePropMat = dataDispVsConFarChoicePropMat;

dataPfc.all.dataUsedinPcc.dataDispVsConFarChoicePropMat = mean(dataPfc.dataUsedinPcc.dataDispVsConFarChoicePropMat,2);

%%
% dataAlldpMat = repmat(dataPfc.x.value,1,length(dataPfc.condition)); 
%�S�����̊e������Ԃ́E�E�E
dataTrialMat = sum(dataDispVsConTrialNumMat,3); % �g���C�A����
dataFarChoicePropMat = mean(dataDispVsConFarChoicePropMat,3); % ���ρu���v�I��
dataFarChoiceSDMat = std(dataDispVsConFarChoicePropMat, [],3); % �W���΍� 
%��Ԃ��ƂɁE�E�E
for n = 1:length(dataPfc.condition)
    dataPfc.condition(n).rawTrialNum = dataTrialMat(:,n);% �g���C�A����
    dataPfc.condition(n).rawDataValue = dataFarChoicePropMat(:,n);% ���ρu���v�I��
    dataPfc.condition(n).rawDataEbar = dataFarChoiceSDMat(:,n); % �W���΍� 
end
%��Ԃ𕽋ς��� %�R�R�K�A�E�g�I�I�I�I�I�I�I�I�I�I�I�I���ς̕��ς͂���
dataPfc.all.rawTrialNum = sum(dataTrialMat,2);
dataPfc.all.rawDataValue = mean(dataFarChoicePropMat,2);
dataPfc.all.rawDataEbar = mean(dataFarChoiceSDMat,2);
%������(MakePlot�Ō���W�������߂�Ƃ��Ɏg�p)
dataPfc.ExpNum = size(dataPfc.dataUsedinPcc.dataDispVsConFarChoicePropMat,3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subfunction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dataPDA = ExtractPDA( rawData )
%% ExtractPDA �f�[�^����ʒu(Position)�Ǝ���(Disparity)�Ɖ�(Answer)�𒊏o���e�������Ƃɍs��𐶐�
%   ����:�ʒu(�ԍ�)�A���ځF�����A�O��ځF��

for n = 1:length(rawData)
%�ʒu

    for m = 1:length(rawData(n).data)
        dataPosLR(m,1) = rawData(n).data(m).trial.stim(2).parameters.stimPos(1);
        dataPosUD(m,1) = rawData(n).data(m).trial.stim(2).parameters.stimPos(2);
    end

%����

    for m = 1:length(rawData(n).data)
        dataDisp(m,1) = rawData(n).data(m).trial.stim(2).parameters.disparity(1);
    end

%��

    for m = 1:length(rawData(n).data)
        dataAns(m,1) = rawData(n).data(m).response;
    end

%�܂Ƃ�

    dataSet{n} = horzcat( dataPosLR, dataPosUD, dataDisp, dataAns );
    dataSetTemp = isnan(dataSet{n}(:,4));
    dataPDA{n}= dataSet{n}(dataSetTemp ~= 1,:);%�ʒu(���E)�A�ʒu(�㉺)�A�����A��
    if dataPDA{n}(:,1) <0
    
        for m = 1:length(dataPDA{n})
            if dataPDA{n}(m,1) > -2*atan(596.7400/10/2/2/160/2)*180/pi && dataPDA{n}(m,2) < 0
                dataPosName(m,1) = 1;
            end
            if dataPDA{n}(m,1) < -2*atan(596.7400/10/2/2/160/2)*180/pi && dataPDA{n}(m,2) < 0
                dataPosName(m,1) = 2;
            end
            if dataPDA{n}(m,1) < -2*atan(596.7400/10/2/2/160/2)*180/pi && dataPDA{n}(m,2) > 0
                dataPosName(m,1) = 3;
            end
            if dataPDA{n}(m,1) > -2*atan(596.7400/10/2/2/160/2)*180/pi && dataPDA{n}(m,2) > 0
                dataPosName(m,1) = 4;
            end
        end
    else
        for m = 1:length(dataPDA{n})
            if dataPDA{n}(m,1) > 0 && dataPDA{n}(m,2) < 0
                dataPosName(m,1) = 1;
            end
            if dataPDA{n}(m,1) < 0 && dataPDA{n}(m,2) < 0
                dataPosName(m,1) = 2;
            end
            if dataPDA{n}(m,1) < 0 && dataPDA{n}(m,2) > 0
                dataPosName(m,1) = 3;
            end
            if dataPDA{n}(m,1) > 0 && dataPDA{n}(m,2) > 0
                dataPosName(m,1) = 4;
            end
        end        
        
    end
    
    dataPDA{n} = horzcat(dataPosName,dataPDA{n}(:,3), dataPDA{n}(:,4));%�ʒu(���O�Â�)�A�����A��
   
    clear dataPosName dataPosLR dataPosUD dataDisp dataAns dataSetTemp;
end
clear dataSet



function dataRDA = ExtractRDA( rawData )
%% ExtractRDA �f�[�^����h���̃��t���b�V�����[�g(Refresh Rate)�Ǝ���(Disparity)�Ɖ�(Answer)�𒊏o���e�������Ƃɍs��𐶐�
%   ����:�ʒu(�ԍ�)�A���ځF�����A�O��ځF��

for n = 1:length(rawData)
%�h���̃��t���b�V�����[�g

    for m = 1:length(rawData(n).data)
        dataRef(m,1) = rawData(n).data(m).trial.stim(2).parameters.stimFreq;
    end

%����

    for m = 1:length(rawData(n).data)
        dataDisp(m,1) = rawData(n).data(m).trial.stim(2).parameters.disparity(1);
    end

%��

    for m = 1:length(rawData(n).data)
        dataAns(m,1) = rawData(n).data(m).response; 
    end

%�܂Ƃ�

    dataSet{n} = horzcat( dataRef, dataDisp, dataAns );
    dataSetTemp = isnan(dataSet{n}(:, 3));
    dataRDA{n}= dataSet{n}(dataSetTemp ~= 1,:);%�h���̃��t���b�V�����[�g�A�����A��
    for m = 1:length(dataRDA{n})
        if dataRDA{n}(m,1) == 42.5000
            dataRefName(m,1) = 1;
        end
        if dataRDA{n}(m,1) == 21.2500
            dataRefName(m,1) = 2;
        end
        if dataRDA{n}(m,1) == 10.6250
            dataRefName(m,1) = 3;
        end
    end
    dataRDA{n} = horzcat(dataRefName,dataRDA{n}(:,2), dataRDA{n}(:,3));%�h���̃��t���b�V�����[�g(���O�Â�)�A�����A��
   
    clear dataRefName dataRef dataDisp dataAns dataSetTemp;
end


