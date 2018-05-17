function dataFile = GetFilesUI(ext)
% GetFilesUI    GUI �őI�����ꂽ�t�@�C�����Z���z��ŕԂ�
%

if exist('ext', 'var')
    extspec = [ './*.' ext ];
else
    extspec = [ './*' ];
end

[ files pathToFile ] = uigetfile(extspec, 'Select file(s)', 'MultiSelect', 'on');

if iscell(files)
    for n = 1:length(files)
        dataFile{n} = [ pathToFile files{n} ];
    end
else
    dataFile{1} = [ pathToFile files ];
end

