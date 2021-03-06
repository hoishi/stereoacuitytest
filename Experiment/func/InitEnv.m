function env = InitEnv()
% InitEnv    env 構造体を初期化する

env.stimNum = 64;

try
    load 'env.mat';
catch
    disp('Cannot load env.mat! Use default values instead.');
    env.stereoMode = 4;
    env.bgColor    = [ 0.75, 0.75, 0.75 ];
    env.viewDistance = 100; %[cm]
end

env.description = '';

