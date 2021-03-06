function stimPattern = DrawAttentionPoint(env, tm, prm)
% DrawAttentionPoint    Attention point を描画する

dotsPos_px   = [ env.deg2px_hrz( prm.stimPos(1) );   env.deg2px_vrt( prm.stimPos(2) )   ]; % Attention point の位置
dotSize_px       = env.deg2px_hrz( prm.dotSize );
dot_color = env.blackIndex + env.whiteIndex .* prm.color;
% ドットを描画する
Screen('DrawDots', env.wndPtr, dotsPos_px, dotSize_px, dot_color, env.wndCenter, 1);

stimPattern = NaN;

