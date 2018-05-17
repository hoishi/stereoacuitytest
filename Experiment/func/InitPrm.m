function prm = InitPrm(stimType)
% InitPrm    �h���p�����^�\���̂�����������
%

switch  stimType
  case 'RandomDot'
    prm(1).dotSize        = 0.16;         % VA [deg]
    prm(1).dotDensity     = 0.5;         % [%]
    prm(1).brightDotColor = [ 1, 1, 1 ]; % [1, 1, 1] --> White
    prm(1).darkDotColor   = [ 0, 0, 0 ]; % [0, 0, 0] --> Black
    prm(1).patchShape     = 'Circle';
    prm(1).patchSize      = 4;           % VA [deg]
    prm(1).stimPos        = [ 0, 4 ];   % VA [deg], Relative to the window center
    prm(1).stimFreq       = 10;          % [Hz]

  case 'RandomDotStereogram'
    prm(1).dotSize        = 0.16;               % VA [deg]
    prm(1).dotDensity     = 0.25;               % [%]
    prm(1).brightDotColor = [ 1, 1, 1 ];        % [1, 1, 1] --> White
    prm(1).darkDotColor   = [ 0, 0, 0 ];        % [0, 0, 0] --> Black
    prm(1).patchShape     = 'Bipartite_Circle';
    prm(1).patchSize      = [ 4, 6 ];           % VA [deg], [ ���S�̒��a�A���S + ���ӂ̒��a ]
    prm(1).stimPos        = [ 0, 4 ];          % VA [deg], Relative to the window center
    prm(1).stimFreq       = 10;                 % [Hz]

    prm(1).disparity      = [ 0.1, 0 ];         % VA [deg], [ ���S�̎����A���ӂ̎��� ]

    prm(1).correlation    = [ 1, 1 ]; % [ ���S�̑��ցC���ӂ̑��� ]
    prm(1).coherence      = [ 1, 1 ]; % [ ���S�̃R�q�[�����X�C���ӂ̃R�q�[�����X ] (signal dot �̊���)
    prm(1).position       = [ -4, 0 ];
    
  otherwise
    error([ 'Unknown stimType: ' stimType ]);
end
