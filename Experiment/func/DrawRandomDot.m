function stimPattern  =DrawRandomDot(env, tm, prm)
% DrawRandomDot    �����_���h�b�g�h����`�悷��

radius = prm.patchSize / 2;
dot_radius = prm.dotSize / 2;

% �����_���h�b�g�̐������߂�
numDots = round(prm.patchSize * prm.patchSize * prm.dotDensity / (pi * dot_radius * dot_radius));

%�h�b�g�̏������W�����߂�
dots = radius * ( 2 .* rand(2, numDots) - 1);

% �`��͈͂Ɋ܂܂��h�b�g�����o��
%m = 1;
%for n = 1:numDots
%    if dots(1,n) * dots(1,n) + dots(2,n)* dots(2,n) <= radius * radius
%       dots_draw(1:2, m) = dots(1:2, n);
%       m = m + 1;
%    end
%end
dots_draw   = dots(:, dots(1, :) .^ 2 + dots(2, :) .^ 2 <= radius .^ 2);
numDotsDraw = size(dots_draw, 2);

% �h�b�g�̈ʒu��ݒ肷��
dots_draw = dots_draw + repmat(prm.stimPos', 1, numDotsDraw);

% Deg --> Pixel �ϊ�
%env.deg2px_hrz = @(x) 2 * env.viewDistance * env.wndSize(1) / ( env.scrnSize(1) * 0.1 ) * tan( (x / 180) * pi / 2 );
%env.deg2px_vrt = @(x) 2 * env.viewDistance * env.wndSize(2) / ( env.scrnSize(2) * 0.1 ) * tan( (x / 180) * pi / 2 );

dotSize_px       = env.deg2px_hrz( prm.dotSize ); %stim ���� dot Size �ύX�������Ă����Ȃ��̂�
dots_draw_px   = [ env.deg2px_hrz( dots_draw(1,:) );   env.deg2px_vrt( dots_draw(2,:) )   ];

% �h�b�g�̐F��ݒ肷��
dotColorPair = [ env.blackIndex + env.whiteIndex .* prm.darkDotColor', ...
                 env.blackIndex + env.whiteIndex .* prm.brightDotColor' ];
dots_color = repmat(dotColorPair, 1, numDotsDraw);
dots_color = dots_color(:, 1:numDotsDraw);

% �h�b�g��`�悷��
Screen('DrawDots', env.wndPtr, dots_draw_px, dotSize_px, dots_color, env.wndCenter, 1);

stimPattern = NaN;

