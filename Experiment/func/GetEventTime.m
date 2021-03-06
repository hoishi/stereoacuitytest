function rt = GetEventTime(tt, event)
% GetEventTime    tt (timetable 構造体) から event に対応した時間を返す．

rt = NaN;

for n = 1:length(tt)
    if strcmp(tt(n).event, event)
        rt = tt(n).trialTime;
    end
end

