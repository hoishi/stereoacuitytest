function rt = GetEventTime(tt, event)
% GetEventTime    tt (timetable �\����) ���� event �ɑΉ��������Ԃ�Ԃ��D

rt = NaN;

for n = 1:length(tt)
    if strcmp(tt(n).event, event)
        rt = tt(n).trialTime;
    end
end

