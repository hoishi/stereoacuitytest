function tm = InitTm(env)
% InitTm    tm �\���̂�����������

tm.timeCurrent    = GetSecs;               % ���ݎ���
tm.timeStart      = tm.timeCurrent;        % �����J�n����
tm.timeInitTrial  = tm.timeCurrent;        % ���s�J�n����
tm.timeFlip       = 0;                     % ��ʂ��t���b�v��������
tm.timePrevFlip   = 0;                     % �O���ʂ��t���b�v��������
tm.timeUpdateStim = zeros(env.stimNum, 1); % �h���X�V����

