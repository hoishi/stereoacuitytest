function Result1stSession_test

addpath('./lib');
addpath('./func');

dataFiles = GetFilesUI('mat');
rawData = LoadData(dataFiles);

%% session 1,2,3,4,5
dataPfc = GetPropFarChoice(rawData);
dataPcc = GetPropCorrect(rawData);

dataPfc = FitData4test(dataPfc);
dataPcc = FitData4test(dataPcc);
%% ?½f?½[?½^?½Û‘ï¿½
save(['Result_session12345_test' '_' dataPcc.id '_' dataPcc.subjectID '_' dataPcc.date '.mat' ], 'dataPfc', 'dataPcc');

clearvars -except dataFiles rawData
