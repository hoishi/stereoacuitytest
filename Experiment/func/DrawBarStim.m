function stimPattern = DrawBarStim(env, tm, prm)
% DrawFixationPoint    Fixation point を描画する

pos    = [ env.deg2px_hrz(prm.position(1)) env.deg2px_vrt(prm.position(2)) ]; % Nonius lines の位置
width  = env.deg2px_hrz(prm.width);    % Nonius lines の幅
length = env.deg2px_vrt(prm.length);   % Nonius lines の長さ

lcolor = env.blackIndex + env.whiteIndex .* prm.color;

left_lines  = [ length, -length, 0, 0;
                    0, 0, 0, 0];
right_lines = [ length, -length, 0, 0;
                    0, 0, 0, 0];

% Left
Screen('SelectStereoDrawBuffer', env.wndPtr, 0);
Screen('DrawLines', env.wndPtr, left_lines, width, lcolor, env.wndCenter + [ pos(1), pos(2) ], 1);

% Right
Screen('SelectStereoDrawBuffer', env.wndPtr, 1);
Screen('DrawLines', env.wndPtr, right_lines, width, lcolor, env.wndCenter + [ pos(1), pos(2) ] , 1);

stimPattern = NaN;

