function respCode = GetResp(resp, keyCode)
% GetResp    response �\���� (resp) ���� keyCode �ɑΉ����锽���R�[�h���������Ԃ�

respCode = NaN;
for n = 1:length(resp)
    if keyCode(KbName(resp(n).key))
        respCode = resp(n).code;
    end
end

