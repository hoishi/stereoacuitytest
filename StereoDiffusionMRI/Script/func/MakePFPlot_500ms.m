function MakePFPlot_500ms(data, hf)
% MakeFigure    �f�[�^���v���b�g����

% if ~isnan( strfind( data.id, '4pos') ) || ~isnan( strfind( data.id, '3freq') )
%     % Color and Marker types 
%     b = [0 0 1];%��
%     v = [0.85 0 0.502];%��
%     y = [0.753 0.753 0];%����
%     % c = [0 0.8 0.8];%�V�A��
%     % Raw data �̃v���b�g�Ɏg�p
%     data.all(1).color = b;
%     data.all(2).color = v;
%     data.all(3).color = y;
%     % data.all(4).color = c;
% 
%     data.all(1).marker = 'o';
%     data.all(2).marker = 's';
%     data.all(3).marker = 'p';
%     % data.all(4).marker = 'h';
%     if ~isnan( strfind( data.id, '4pos') )
%         c = [0 0.8 0.8];%�V�A��
%         data.all(4).color = c;
%         data.all(4).marker = '+';
%     end
% end
 b = [0 0 1];%��
 v = [0.85 0 0.502];%��
 y = [0.753 0.753 0];%����
 c = [0 0.8 0.8];%�V�A��
 g = [0.2 1 0.5];%��
 r  = [1 0.6 0.2];%�I�����W
 data.all.disp2nd.color{1} = b;
 data.all.disp2nd.color{2} = v;
 data.all.disp2nd.color{3} = y;
 data.all.disp2nd.color{4} = c;
 data.all.disp2nd.color{5} = g;
 data.all.disp2nd.color{6} = r;

 

 

axes('Position',[0 0 1 1],'Visible','off');
hold on;
expID = [ 'expID: ', data.id] ;
expID = text( .75, .98, expID );
set( expID, 'FontSize', 9 );
subjectID = [ 'subjectID: ', data.subjectID ];
subjectID = text( .75, .96, subjectID );
set( subjectID, 'FontSize', 9 );
date = [ 'date: ', data.date ];
date = text( .75, .94, date );
set( date, 'FontSize', 9 );

axes('Position',[0.1300 0.1100 0.7750 0.8150]);
hold on;
% Title
type = sprintf(data.type,'FontSize','18');
title(type);
saveName = [ '500ms_','All','_' data.type, '_', data.id, '_', data.subjectID, '_', data.date, '.fig'];

for n = 1:length(data.all)
    X = data.x.value;
    Y = data.all.rawDataValue;
    ER = data.all.rawDataEbar;
%     if ~isnan(ER)
%         errorbar(X, Y, ER, ...
%                   'Color', data.all.color,'Marker',data.all.marker,'LineStyle','none');
%     else
%         plot(X, Y, 'Color', data.all.color, 'Marker', data.all.marker,'LineStyle','none');        
%     end
    semilogx(X, Y, 'Marker', 's','MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k','LineStyle','none');
end

% �v���b�g�̐��`
box off;




%������    
if strcmp(data.type , 'PCC') 
    data.x.label = 'Disparity magnitude';
    data.y.label = 'Proportion of correct';
    xlabel(data.x.label);
    ylabel(data.y.label);
    xlim([ 0, max( data.x.value ) + 0.001 ]); ylim([ 0, 1 + 0.01 ]);
%     % Legend
%     legend({ data.all(:).description }, 'Location', 'southeast');
    % Title
    type = sprintf(data.type,'FontSize','18');
    title(type);
    
    for n = 1:length(data.all)
        if ~isnan(data.all.fitdata.isFit) %�������̃t�B�b�e�B���O�̕`��
            %�t�B�b�e�B���O�֐��̃f�[�^�_
            
                xPlotIndexCorrect{n} = (0:0.001:max( data.x.value ))';
                yPlotIndexCorrect{n} = data.all.fitdata.func( xPlotIndexCorrect{n}, data.all.fitdata.prm );        

            %�t�B�b�e�B���O�֐���`��
            
                plot(xPlotIndexCorrect{n}, yPlotIndexCorrect{n},'Color','k','LineWidth',2.5,'LineStyle','--');
%             %disp2nd�̃f�[�^�_
%             for m = 7:12
%                 data.all.disp2nd.array_y(m) = data.all.fitdata.func( data.all.disp2nd.array(m), data.all.fitdata.prm );
%             end
%             %disp2nd���v���b�g
%             for m = 7:12
%                 plot(data.all.disp2nd.array(m), data.all.disp2nd.array_y(m), 'Marker', 'o', 'MarkerSize', 4,'MarkerEdgeColor', data.all.disp2nd.color{m-6}, 'MarkerFaceColor', data.all.disp2nd.color{m-6}, 'LineStyle', 'none');
%             end
                

            %臒l���v���b�g
            
                plot([ 0 max( data.x.value ) ], [0.75 0.75], 'Color','k','LineStyle' ,':');
                plot([ data.all.sppData(1).value data.all.sppData(1).value ], [ 0 1 ], 'Color', 'k' ,'LineStyle' ,':');
%             %disp2nd��ʂ鐂�������v���b�g
%             
%                 plot([ data.all.disp2nd.array(7) data.all.disp2nd.array(7) ], [ 0 1 ], 'Color', data.all.disp2nd.color{1},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(8) data.all.disp2nd.array(8) ], [ 0 1 ], 'Color', data.all.disp2nd.color{2},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(9) data.all.disp2nd.array(9) ], [ 0 1 ], 'Color', data.all.disp2nd.color{3},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(10) data.all.disp2nd.array(10) ], [ 0 1 ], 'Color', data.all.disp2nd.color{4},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(11) data.all.disp2nd.array(11) ], [ 0 1 ], 'Color', data.all.disp2nd.color{5},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(12) data.all.disp2nd.array(12) ], [ 0 1 ], 'Color', data.all.disp2nd.color{6},'LineStyle' ,'-');
                
     
                
            
%             % 臒l�̎����̒l��figure���ɋL��
%                 if data.all.sppData(1).value > 0.32
%                     ThresholdText(n) = text( 0.08 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( 'Threshold(%d): %s\n', n, 'bigger' ));
%                 elseif data.all.sppData(1).value < 0.01
%                     ThresholdText(n) = text( 0.08 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( 'Threshold(%d): %s\n', n, 'smaller' ));
%                 else                
%                     ThresholdText(n) = text( 0.08 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( 'Threshold(%d): %f\n', n, data.all.sppData(1).value ));
%                     set( ThresholdText(n), 'FontSize', 9 );
%                 end
%             % ������ 60 %�ɂ����鎋�����x�̒l��figure���ɋL��
%                 if data.all.sppData(2).value > 0.32
%                     LowCorrectText(n) = text( 0.12 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '60per Correct(%d): %s\n', n, 'bigger' ));
%                 elseif data.all.sppData(2).value < 0.01
%                     LowCorrectText(n) = text( 0.12 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '60per Correct(%d): %s\n', n, 'smaller' ));
%                 else            
%                     LowCorrectText(n) = text( 0.12 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '60per Correct(%d): %f\n', n, data.all.sppData(2).value ));
%                     set( LowCorrectText, 'FontSize', 9 );
%                 end
                
%             % ������ 90 %�ɂ����鎋�����x�̒l��figure���ɋL��
%                 if data.all.sppData(3).value > 0.32
%                     HighCorrectText(n) = text( 0.16 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '90per Correct(%d): %s\n', n, 'bigger' ));
%                 elseif data.all.sppData(3).value < 0.01
%                     HighCorrectText(n) = text( 0.16 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '90per Correct(%d): %s\n', n, 'smaller' ));
%                 else            
%                     HighCorrectText(n) = text( 0.16 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '90per Correct(%d): %f\n', n, data.all.sppData(3).value ));
%                     set( HighCorrectText(n), 'FontSize', 9 );               
%                 end
            
%             % ����W���̒l��figure���ɋL��
%             
%                 R_SQText(n) =text( 0.20 / max( data.x.value ) * max( data.x.value ),0.5 - 0.1*n, sprintf('R^2(%d): %f\n', n, data.all.fitdata.r_sq ));
%                 set( R_SQText(n), 'FontSize', 9 );
   
             
        end
    end
end
            ax = gca;
            set(ax,'XScale','log');
%Save figure
set(hf, 'Name', saveName);
set(hf, 'NumberTitle', ' off');
saveas( hf, saveName);

