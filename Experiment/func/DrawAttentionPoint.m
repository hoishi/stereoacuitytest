function stimPattern = DrawAttentionPoint(env, tm, prm)
% DrawAttentionPoint    Attention point ��`�悷��

dotsPos_px   = [ env.deg2px_hrz( prm.stimPos(1) );   env.deg2px_vrt( prm.stimPos(2) )   ]; % Attention point �̈ʒu
dotSize_px       = env.deg2px_hrz( prm.dotSize );
dot_color = env.blackIndex + env.whiteIndex .* prm.color;
% �h�b�g��`�悷��
Screen('DrawDots', env.wndPtr, dotsPos_px, dotSize_px, dot_color, env.wndCenter, 1);

stimPattern = NaN;

