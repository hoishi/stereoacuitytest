function st = InitSt(env)
% InitSt    st �\���̂�����������

st.initExp        = false;                 % �����J�n�t���O
st.trialCount     = 1;                     % ���s�J�E���^
st.dataCount      = 1;                     % �f�[�^�J�E���^
st.initTrial      = true;                  % ���s�������t���O
st.terminateTrial = false;                 % ���s�I���t���O
st.showStim       = zeros(env.stimNum, 1); % �h���񎦃t���O
st.acceptResp     = false;                 % �����󂯕t���t���O
st.currentResp    = NaN;                   % ���݂̎��s�ɂ�����팱�҂̔������i�[����o�b�t�@
st.doFlipForced   = false;                 % �����t���b�v�̃t���O
