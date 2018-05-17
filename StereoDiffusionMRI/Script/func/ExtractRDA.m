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



