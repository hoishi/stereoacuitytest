function DispFrameRate(tm)
% DispFrameRate    �t���[�����[�g��\������

if tm.timeFlip ~= tm.timePrevFlip
    elapsedTime = tm.timeFlip - tm.timePrevFlip;
    disp([ num2str(tm.timeFlip) ...
           ' (flip interval: ' num2str(elapsedTime) '; ' ...
           ' fps: ' num2str(1 / elapsedTime) ')' ]);
end
