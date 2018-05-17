function MakePFPlot_4many_test_2017_12_18
% MakeFigure    データをプロットする

% if ~isnan( strfind( data.id, '4pos') ) || ~isnan( strfind( data.id, '3freq') )
%     % Color and Marker types 
%     b = [0 0 1];%青
%     v = [0.85 0 0.502];%紫
%     y = [0.753 0.753 0];%黄緑
%     % c = [0 0.8 0.8];%シアン
%     % Raw data のプロットに使用
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
%         c = [0 0.8 0.8];%シアン
%         data.all(4).color = c;
%         data.all(4).marker = '+';
%     end
% end
 b = [0 0 1];%青
 v = [0.85 0 0.502];%紫
 y = [0.753 0.753 0];%黄緑
 c = [0 0.8 0.8];%シアン
 g = [0.2 1 0.5];%緑
 r  = [1 0.6 0.2];%オレンジ
 data.all.disp2nd.color{1} = b;
 data.all.disp2nd.color{2} = v;
 data.all.disp2nd.color{3} = y;
 data.all.disp2nd.color{4} = c;
 data.all.disp2nd.color{5} = g;
 data.all.disp2nd.color{6} = r;
 
addpath('./StereoDiffusionMRI/Script');
addpath('./StereoDiffusionMRI/Script/lib');
addpath('./StereoDiffusionMRI/Script/func');
addpath('./lib');
addpath('./func');
 
%% データの読み込み
% PCCdata = '\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345'
load('\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345\stereoacuity_correctrates_withcondition/threshold_84%correctrate_withcondition.mat');
% load('\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345\Result_session12345_StereoTestHaplo151201-4pos_HO_2016-01-05.mat');
% stereoacuity = value(4);
% load('\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345\Result_session12345_StereoTestHaplo151201-4pos_MY_2016-01-07.mat');
% stereoacuity = value(13);
load('\\133.243.177.247\homes\oishi\stereo_experiment\Analysis_2017_02_24\StereoDiffusionMRI\Script\Session12345\Result_session12345_StereoTestHaplo151201-4pos_MOn_2015-12-28.mat');


data = dataPcc;
 
hf = figure;
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
% type = sprintf(data.type,'FontSize','18');
% title(type);
saveName = ['Result_session12345', '_',data(1).subjectID, '_',data(1).type, '_', data(1).id, '_','.fig'];
saveName_png = ['Result_session12345', '_',data(1).subjectID, '_',data(1).type, '_', data(1).id, '_','.png'];


    X = data.x.value*60;%arcmin unit
%     X = [0.1 0.5 1 5]
    Y = data.all.rawDataValue;
    ER = data.all.rawDataEbar;
%     if ~isnan(ER)
%         errorbar(X, Y, ER, ...
%                   'Color', data.all.color,'Marker',data.all.marker,'LineStyle','none');
%     else
%         plot(X, Y, 'Color', data.all.color, 'Marker', data.all.marker,'LineStyle','none');        
%     end
%     semilogx(X, Y, 'Marker', 's','MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k','LineStyle','none');
    plot(X, Y, 'Marker', 's','MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k','MarkerSize',10,'LineStyle','none','Marker','o');


% プロットの整形
box off;




%正答率    
if strcmp(data.type , 'PCC') 
%     data.x.label = 'Disparity magnitude';
%     data.y.label = 'Proportion of correct';
%     xlabel(data.x.label);
%     ylabel(data.y.label);
%     xlim([ min( X ) - 0.001, max( X ) + 0.001 ]); ylim([ 0, 1 + 0.01 ]);
%     xlim([  min( X ) - 0.02, max( X ) + 0.4 ]); ylim([ 0, 1 + 0.01 ]);
    xlim([  min( X ) - 0.02, max( X ) + 0.4 ]); ylim([ 0.4, 1 + 0.01 ]);
%     % Legend
%     legend({ data.all(:).description }, 'Location', 'southeast');
    % Title
%     type = sprintf(data.type,'FontSize','18');
%     title(type);
    
    for n = 1:length(data.all)
        if ~isnan(data.all.fitdata.isFit) %正答率のフィッティングの描画
            %フィッティング関数のデータ点
            
                xPlotIndexCorrect{n} = ((min( X ) - 0.02)/60 :0.001:(max( X ) + 0.4)/60)';
                yPlotIndexCorrect{n} = data.all.fitdata.func( xPlotIndexCorrect{n}, data.all.fitdata.prm );        
                xPlotIndexCorrect{n} = xPlotIndexCorrect{n}*60;
            %フィッティング関数を描画
            
                plot(xPlotIndexCorrect{n}, yPlotIndexCorrect{n},'Color','k','LineWidth',2.5,'LineStyle','-');
%             %disp2ndのデータ点
%             for m = 7:12
%                 data.all.disp2nd.array_y(m) = data.all.fitdata.func( data.all.disp2nd.array(m), data.all.fitdata.prm );
%             end
%             %disp2ndをプロット
%             for m = 7:12
%                 plot(data.all.disp2nd.array(m), data.all.disp2nd.array_y(m), 'Marker', 'o', 'MarkerSize', 4,'MarkerEdgeColor', data.all.disp2nd.color{m-6}, 'MarkerFaceColor', data.all.disp2nd.color{m-6}, 'LineStyle', 'none');
%             end
                

            %閾値をプロット
            
%                plot([ min( X ) - 0.02 max( X ) + 0.4 ], [0.84 0.84], 'Color','k','LineStyle' ,':','LineWidth',2);
%                plot([ stereoacuity*60 stereoacuity*60 ], [ 0 1 ], 'Color', 'k' ,'LineStyle' ,':','LineWidth',2);
%             %disp2ndを通る垂直線をプロット
%             
%                 plot([ data.all.disp2nd.array(7) data.all.disp2nd.array(7) ], [ 0 1 ], 'Color', data.all.disp2nd.color{1},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(8) data.all.disp2nd.array(8) ], [ 0 1 ], 'Color', data.all.disp2nd.color{2},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(9) data.all.disp2nd.array(9) ], [ 0 1 ], 'Color', data.all.disp2nd.color{3},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(10) data.all.disp2nd.array(10) ], [ 0 1 ], 'Color', data.all.disp2nd.color{4},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(11) data.all.disp2nd.array(11) ], [ 0 1 ], 'Color', data.all.disp2nd.color{5},'LineStyle' ,'-');
%                 plot([ data.all.disp2nd.array(12) data.all.disp2nd.array(12) ], [ 0 1 ], 'Color', data.all.disp2nd.color{6},'LineStyle' ,'-');
                
     
                
            
%             % 閾値の視差の値をfigure中に記載
%                 if data.all.sppData(1).value > 0.32
%                     ThresholdText(n) = text( 0.08 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( 'Threshold(%d): %s\n', n, 'bigger' ));
%                 elseif data.all.sppData(1).value < 0.01
%                     ThresholdText(n) = text( 0.08 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( 'Threshold(%d): %s\n', n, 'smaller' ));
%                 else                
%                     ThresholdText(n) = text( 0.08 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( 'Threshold(%d): %f\n', n, data.all.sppData(1).value ));
%                     set( ThresholdText(n), 'FontSize', 9 );
%                 end
%             % 正答率 60 %にあたる視差強度の値をfigure中に記載
%                 if data.all.sppData(2).value > 0.32
%                     LowCorrectText(n) = text( 0.12 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '60per Correct(%d): %s\n', n, 'bigger' ));
%                 elseif data.all.sppData(2).value < 0.01
%                     LowCorrectText(n) = text( 0.12 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '60per Correct(%d): %s\n', n, 'smaller' ));
%                 else            
%                     LowCorrectText(n) = text( 0.12 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '60per Correct(%d): %f\n', n, data.all.sppData(2).value ));
%                     set( LowCorrectText, 'FontSize', 9 );
%                 end
                
%             % 正答率 90 %にあたる視差強度の値をfigure中に記載
%                 if data.all.sppData(3).value > 0.32
%                     HighCorrectText(n) = text( 0.16 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '90per Correct(%d): %s\n', n, 'bigger' ));
%                 elseif data.all.sppData(3).value < 0.01
%                     HighCorrectText(n) = text( 0.16 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '90per Correct(%d): %s\n', n, 'smaller' ));
%                 else            
%                     HighCorrectText(n) = text( 0.16 / max( data.x.value ) * max( data.x.value ), 0.5 - 0.1*n, sprintf( '90per Correct(%d): %f\n', n, data.all.sppData(3).value ));
%                     set( HighCorrectText(n), 'FontSize', 9 );               
%                 end
            
%             % 決定係数の値をfigure中に記載
%             
%                 R_SQText(n) =text( 0.20 / max( data.x.value ) * max( data.x.value ),0.5 - 0.1*n, sprintf('R^2(%d): %f\n', n, data.all.fitdata.r_sq ));
%                 set( R_SQText(n), 'FontSize', 9 );
   
             
        end
    end
end
            
            Xlabel = [0.1 0.4 1.6 6.4];
            xlim([0 8])
            ax = gca;
            set(ax,'XScale','log');
            percent = [0 0.5 0.84 1];
            set(ax,'XTick',Xlabel,'XTickLabel',Xlabel,'XMinorTick','off','YTick',percent,'YTickLabel',percent*100,'TickDir','out')
            
%Save figure
set(hf, 'Name', saveName);
set(hf, 'NumberTitle', ' off');
% saveas( hf, saveName);
% saveas( hf, saveName_png);


