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
    dataPDA{n} = horzcat(dataPosName,dataPDA{n}(:,3), dataPDA{n}(:,4));%�ʒu(���O�Â�)�A�����A��
   
    clear dataPosName dataPosLR dataPosUD dataDisp dataAns dataSetTemp;
end



