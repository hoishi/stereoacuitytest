function stimPattern = DrawRandomDotStereogram(env, tm, prm)
% DrawRandomDotStereogram    �����_���h�b�g�X�e���I�O������`�悷��

if prm.updateStim
    stimPattern = GenRdsPattern(env, tm, prm);
else
    stimPattern = prm.stimPattern;
end

% �h�b�g��`�悷��
Screen('SelectStereoDrawBuffer', env.wndPtr, 0);
if ~isempty(stimPattern.left_pos)
    Screen('DrawDots', env.wndPtr, stimPattern.left_pos, stimPattern.left_size, stimPattern.left_color, env.wndCenter, 1);
end

Screen('SelectStereoDrawBuffer', env.wndPtr, 1);
if ~isempty(stimPattern.right_pos)
    Screen('DrawDots', env.wndPtr, stimPattern.right_pos, stimPattern.right_size, stimPattern.right_color, env.wndCenter, 1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rds = GenRdsPattern(env, tm, prm)

radius     = [prm.patchSize(1) / 2, prm.patchSize(2) / 2];
dot_radius = prm.dotSize / 2;

% �����_���h�b�g�̐������߂�
numDots = [round((2 * prm.patchSize(1)) ^ 2 * prm.dotDensity / (pi * dot_radius * dot_radius)) , ...
           round((2 * prm.patchSize(2)) ^ 2 * prm.dotDensity / (pi * dot_radius * dot_radius))];

% �h�b�g�̏������W�����߂�
dots     = radius(1) * ( 4 .* rand(2, numDots(1)) - 2);
dots_all = radius(2) * ( 4 .* rand(2, numDots(2)) - 2);

% ����������
dots_L     = dots - [ prm(1).disparity(1) / 2 .* ones(1,numDots(1)); zeros(1,numDots(1)) ];
dots_R     = dots + [ prm(1).disparity(1) / 2 .* ones(1,numDots(1)); zeros(1,numDots(1)) ];
dots_L_all = dots_all - [ prm(1).disparity(2) / 2 .* ones(1,numDots(2)); zeros(1,numDots(2)) ];
dots_R_all = dots_all + [ prm(1).disparity(2) / 2 .* ones(1,numDots(2)); zeros(1,numDots(2)) ];

% �h�b�g�̐F��ݒ肷��
dotColorPair   = [ env.blackIndex' + env.whiteIndex' .* prm.darkDotColor', ...
                   env.blackIndex' + env.whiteIndex' .* prm.brightDotColor' ];
dots_color_L   = repmat(dotColorPair, 1, numDots(1));
dots_color_R   = repmat(dotColorPair, 1, numDots(1));
dots_color_L_S = repmat(dotColorPair, 1, numDots(2));
dots_color_R_S = repmat(dotColorPair, 1, numDots(2));

% �`��͈͂Ɋ܂܂��h�b�g�����o��
idxDrawDots_L   = dots_L(1, :) .^ 2 + dots_L(2, :) .^ 2 <= radius(1) .^ 2;
idxDrawDots_R   = dots_R(1, :) .^ 2 + dots_R(2, :) .^ 2 <= radius(1) .^ 2;
idxDrawDots_L_S = dots_L_all(1, :) .^ 2 + dots_L_all(2, :) .^ 2 <= radius(2) .^ 2 & dots_L_all(1, :) .^ 2 + dots_L_all(2, :) .^ 2 >= radius(1) .^ 2;
idxDrawDots_R_S = dots_R_all(1, :) .^ 2 + dots_R_all(2, :) .^ 2 <= radius(2) .^ 2 & dots_R_all(1, :) .^ 2 + dots_R_all(2, :) .^ 2 >= radius(1) .^ 2;

dots_draw_L  = dots_L(:, idxDrawDots_L);
dots_draw_R  = dots_R(:, idxDrawDots_R);
dots_color_L = dots_color_L(:, idxDrawDots_L);
dots_color_R = dots_color_R(:, idxDrawDots_R);

dots_draw_L_S  = dots_L_all(:, idxDrawDots_L_S);
dots_draw_R_S  = dots_R_all(:, idxDrawDots_R_S);
dots_color_L_S = dots_color_L_S(:, idxDrawDots_L_S);
dots_color_R_S = dots_color_R_S(:, idxDrawDots_R_S);

numDotsDraw_L   = size(dots_draw_L, 2);
numDotsDraw_R   = size(dots_draw_R, 2);
numDotsDraw_L_S = size(dots_draw_L_S, 2);
numDotsDraw_R_S = size(dots_draw_R_S, 2);

% �h�b�g�̈ʒu��ݒ肷��
dots_draw_L   = dots_draw_L + repmat(prm.stimPos', 1, numDotsDraw_L);
dots_draw_R   = dots_draw_R + repmat(prm.stimPos', 1, numDotsDraw_R);
dots_draw_L_S = dots_draw_L_S + repmat(prm.stimPos', 1, numDotsDraw_L_S);
dots_draw_R_S = dots_draw_R_S + repmat(prm.stimPos', 1, numDotsDraw_R_S);

dotSize_px       = env.deg2px_hrz( prm.dotSize );
dots_draw_L_px   = [ env.deg2px_hrz( dots_draw_L(1,:) );   env.deg2px_vrt( dots_draw_L(2,:) )   ];
dots_draw_L_S_px = [ env.deg2px_hrz( dots_draw_L_S(1,:) ); env.deg2px_vrt( dots_draw_L_S(2,:) ) ];
dots_draw_R_px   = [ env.deg2px_hrz( dots_draw_R(1,:) );   env.deg2px_vrt( dots_draw_R(2,:) )   ];
dots_draw_R_S_px = [ env.deg2px_hrz( dots_draw_R_S(1,:) ); env.deg2px_vrt( dots_draw_R_S(2,:) ) ];

rds.left_pos   = [ dots_draw_L_px dots_draw_L_S_px ];
rds.left_size  = [ dotSize_px ];
rds.left_color = [ dots_color_L dots_color_L_S ];

rds.right_pos   = [ dots_draw_R_px dots_draw_R_S_px ];
rds.right_size  = [ dotSize_px ];
rds.right_color = [ dots_color_R dots_color_R_S ];

