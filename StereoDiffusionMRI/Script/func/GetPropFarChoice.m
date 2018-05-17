function dataPfc = GetPropFarChoice(rawData)
%% 奥」選択率を計算する関数である
%% 状態情報、視差情報、各位置と視差ごとのトライアル数、「奥」選択率、その標準偏差を出力する
%% dataSetは一列目:状態、二列目：視差、三列目：回答 であること

%データタイプ
dataPfc.id          = rawData(1).exp.expID;
dataPfc.subjectID   = rawData(1).exp.subjectID;
dataPfc.date        = rawData(1).date;
dataPfc.description = 'Far Choice';
dataPfc.type        = 'PFC';
if ~isnan( strfind( dataPfc.id, '4pos') ) 
    exp_id_initnamenum = strfind(dataPfc.id,'4pos') + length('4pos') -1 ;
    dataPfc.id = dataPfc.id(1:exp_id_initnamenum);
    dataSet = ExtractPDA( rawData ); 
     
    %すべての状態
    for n = 1:length(dataSet)
        a(:,n) =  dataSet{n}(:,1);
    end
    conVar = unique(a);
    clear a;
    %状態に名称を付ける
    %状態情報: 位置情報
    for n = 1:length(conVar)
        if conVar(n) == 1 
           dataPfc.condition(1).description = 'Up-Right(1)';%名称
        end
        if conVar(n) == 2 
           dataPfc.condition(2).description = 'Up-Left(2)';%名称
        end
        if conVar(n) == 3 
           dataPfc.condition(3).description = 'Low-Left(3)';%名称
        end
        if conVar(n) == 4 
           dataPfc.condition(4).description = 'Low-Right(4)';%名称
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
    %すべての状態
    conVar = unique(dataSet{1}(:,1));
    %状態情報: リフレッシュレート
    for n = 1:length(conVar)
        if conVar(n) == 1 
           dataPfc.condition(n).description = '42.5 [Hz](1)';%名称
        end
        if conVar(n) == 2 
           dataPfc.condition(n).description = '21.25 [Hz](2)';%名称
        end
        if conVar(n) == 3 
           dataPfc.condition(n).description = '10.625 [Hz](3)';%名称
        end
    end    
end


%すべての視差
dataPfc.x.value = unique(dataSet{1}(:, 2));
%% 状態と視差ごとに「奥」回答率を計算する 
if isfield(dataPfc.condition(1),'data') && isfield(dataPfc.condition(2),'data') && isfield(dataPfc.condition(3),'data') && isfield(dataPfc.condition(4),'data')
for c = 1:length(dataPfc.condition) 
    for n = 1:length(dataPfc.condition(c).data)
        for m = 1:length(dataPfc.x.value)
            dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat(m) = 0; % 実験ごとに各視差状態のトライアル数をカウント
            dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat(m) = 0; % 実験ごとに「奥」回答数をカウント
            for d = 1:size(dataPfc.condition(c).data{n},1)
                if dataPfc.condition(c).data{n}(d,1) == c && dataPfc.condition(c).data{n}(d,2) == dataPfc.x.value(m) 
                   dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat(m) = dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat(m) + 1;
                   if dataPfc.condition(c).data{n}(d,3) == 2 % 「奥」回答ならば
                      dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat(m) = dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat(m) + 1;
                   end
                end
            end
            dataPfc.condition(c).block{n}.dataDispVsConFarChoicePropMat(m) = dataPfc.condition(c).block{n}.dataDispVsConFarChoiceMat(m) ./ dataPfc.condition(c).block{n}.dataDispVsConTrialNumMat(m); % 実験ごとに「奥」選択率
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
            dataDispVsConTrialNumMat(m,c,n) = 0; % 実験ごとに各視差状態のトライアル数をカウント
            dataDispVsConFarChoiceMat(m,c,n) = 0; % 実験ごとに「奥」回答数をカウント
            for d = 1:size(dataSet{n},1)
                if dataSet{n}(d,1) == c && dataSet{n}(d,2) == dataPfc.x.value(m) 
                   dataDispVsConTrialNumMat(m,c,n) = dataDispVsConTrialNumMat(m,c,n) + 1;
                   if dataSet{n}(d,3) == 2 % 「奥」回答ならば
                      dataDispVsConFarChoiceMat(m,c,n) = dataDispVsConFarChoiceMat(m,c,n) + 1;
                   end
                end
            end
            dataDispVsConFarChoicePropMat(m,c,n) = dataDispVsConFarChoiceMat(m,c,n) ./ dataDispVsConTrialNumMat(m,c,n); % 実験ごとに「奥」選択率
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




%dataPccで使うので格納する

dataPfc.dataUsedinPcc.dataDispVsConTrialNumMat = dataDispVsConTrialNumMat;
dataPfc.dataUsedinPcc.dataDispVsConFarChoiceMat = dataDispVsConFarChoiceMat;
dataPfc.dataUsedinPcc.dataDispVsConFarChoicePropMat = dataDispVsConFarChoicePropMat;

dataPfc.all.dataUsedinPcc.dataDispVsConFarChoicePropMat = mean(dataPfc.dataUsedinPcc.dataDispVsConFarChoicePropMat,2);

%%
% dataAlldpMat = repmat(dataPfc.x.value,1,length(dataPfc.condition)); 
%全実験の各視差状態の・・・
dataTrialMat = sum(dataDispVsConTrialNumMat,3); % トライアル数
dataFarChoicePropMat = mean(dataDispVsConFarChoicePropMat,3); % 平均「奥」選択率
dataFarChoiceSDMat = std(dataDispVsConFarChoicePropMat, [],3); % 標準偏差 
%状態ごとに・・・
for n = 1:length(dataPfc.condition)
    dataPfc.condition(n).rawTrialNum = dataTrialMat(:,n);% トライアル数
    dataPfc.condition(n).rawDataValue = dataFarChoicePropMat(:,n);% 平均「奥」選択率
    dataPfc.condition(n).rawDataEbar = dataFarChoiceSDMat(:,n); % 標準偏差 
end
%状態を平均して %ココガアウト！！！！！！！！！！！！平均の平均はだめ
dataPfc.all.rawTrialNum = sum(dataTrialMat,2);
dataPfc.all.rawDataValue = mean(dataFarChoicePropMat,2);
dataPfc.all.rawDataEbar = mean(dataFarChoiceSDMat,2);
%実験数(MakePlotで決定係数を求めるときに使用)
dataPfc.ExpNum = size(dataPfc.dataUsedinPcc.dataDispVsConFarChoicePropMat,3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subfunction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dataPDA = ExtractPDA( rawData )
%% ExtractPDA データから位置(Position)と視差(Disparity)と回答(Answer)を抽出し各実験ごとに行列を生成
%   一列目:位置(番号)、二列目：視差、三列目：回答

for n = 1:length(rawData)
%位置

    for m = 1:length(rawData(n).data)
        dataPosLR(m,1) = rawData(n).data(m).trial.stim(2).parameters.stimPos(1);
        dataPosUD(m,1) = rawData(n).data(m).trial.stim(2).parameters.stimPos(2);
    end

%視差

    for m = 1:length(rawData(n).data)
        dataDisp(m,1) = rawData(n).data(m).trial.stim(2).parameters.disparity(1);
    end

%回答

    for m = 1:length(rawData(n).data)
        dataAns(m,1) = rawData(n).data(m).response;
    end

%まとめ

    dataSet{n} = horzcat( dataPosLR, dataPosUD, dataDisp, dataAns );
    dataSetTemp = isnan(dataSet{n}(:,4));
    dataPDA{n}= dataSet{n}(dataSetTemp ~= 1,:);%位置(左右)、位置(上下)、視差、回答
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
    
    dataPDA{n} = horzcat(dataPosName,dataPDA{n}(:,3), dataPDA{n}(:,4));%位置(名前づけ)、視差、回答
   
    clear dataPosName dataPosLR dataPosUD dataDisp dataAns dataSetTemp;
end
clear dataSet



function dataRDA = ExtractRDA( rawData )
%% ExtractRDA データから刺激のリフレッシュレート(Refresh Rate)と視差(Disparity)と回答(Answer)を抽出し各実験ごとに行列を生成
%   一列目:位置(番号)、二列目：視差、三列目：回答

for n = 1:length(rawData)
%刺激のリフレッシュレート

    for m = 1:length(rawData(n).data)
        dataRef(m,1) = rawData(n).data(m).trial.stim(2).parameters.stimFreq;
    end

%視差

    for m = 1:length(rawData(n).data)
        dataDisp(m,1) = rawData(n).data(m).trial.stim(2).parameters.disparity(1);
    end

%回答

    for m = 1:length(rawData(n).data)
        dataAns(m,1) = rawData(n).data(m).response; 
    end

%まとめ

    dataSet{n} = horzcat( dataRef, dataDisp, dataAns );
    dataSetTemp = isnan(dataSet{n}(:, 3));
    dataRDA{n}= dataSet{n}(dataSetTemp ~= 1,:);%刺激のリフレッシュレート、視差、回答
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
    dataRDA{n} = horzcat(dataRefName,dataRDA{n}(:,2), dataRDA{n}(:,3));%刺激のリフレッシュレート(名前づけ)、視差、回答
   
    clear dataRefName dataRef dataDisp dataAns dataSetTemp;
end


