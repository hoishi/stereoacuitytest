function data = FitData_evcdf(data)

%% �v���b�g�ɐS������֐��𓖂Ă͂߁A�ٕ�臒l�����߂�

if strcmp(data.type ,'PFC')
    for n =1:length(data.condition)
        %�t�B�b�e�B���O����
        data.condition(n).fitdata.isFit = true;
        % �S������֐��̒�`
        data.condition(n).fitdata.func  = @(t, p) p(4) + (1 - p(4) - p(3)) .* evcdf(t,p(1),p(2)); 
    end
    
    LoopNum_Far = 0;
    for n =1:length(data.condition)
        % �ړI�֐��̒�`
        objfunc = @(p) -mlefunc(p, data.x.value, data.condition(n).rawDataValue, data.condition(n).rawTrialNum, data.condition(n).fitdata.func);

        % �T���̏����l
        c = 1;
        for P = 0:0.25:0.5
        for Q = 0:0.5:0.5   
        for R = 0:0.25:0.50
        for S = 0:0.25:0.50    
            initVal{c} = [ P, Q, R, S]; %����,���U,��,���̒T�������l
            c = c + 1;
        end
        end
        end
        end

        % ����̒�`
        lb = [ 0, 1e-6,   0,  0 ];
        ub = [  Inf,  Inf,  1,  1 ];
        fvalPFMin = Inf;
        for c = 1:length(initVal)
            [ prmPF, fvalPF, exitflagPF ] = fmincon( objfunc, initVal{c}, [], [], [], [], lb, ub, [], optimset('Display', 'notify' ) );

            if fvalPF < fvalPFMin
                fvalMinNum = c; 
                fvalPFMin = fvalPF;
                prmPFMin = prmPF;
                initValPFMinMat = initVal{c};
            end
            LoopNum_Far = LoopNum_Far +1

        end
        %�œK�ȒT���̏����l
        data.condition(n).fitdata.initVal = initValPFMinMat;
        %����,���U,��,��
        data.condition(n).fitdata.prm = prmPFMin;
        %��`�����}�C�i�X�ޓx�֐��̍ŏ��l
        data.condition(n).fitdata.fval = fvalPFMin;
        %��ϓI�����_
        data.condition(n).sppData(1).description = 'PSE';
        data.condition(n).sppData(1).value = GetThreshold(0.5, data.condition(n).fitdata.func, data.condition(n).fitdata.prm);
        %�u���v�I�𗦂� 25 %�̎����̒l
        data.condition(n).sppData(2).description = '25% far choice';
        data.condition(n).sppData(2).value = GetThreshold(0.25, data.condition(n).fitdata.func, data.condition(n).fitdata.prm);
        %�u���v�I�𗦂� 75 %�̎����̒l
        data.condition(n).sppData(3).description = '75% far choice';
        data.condition(n).sppData(3).value = GetThreshold(0.75, data.condition(n).fitdata.func, data.condition(n).fitdata.prm);
        %Near 臒l
        data.condition(n).sppData(4).description = 'Near threshold';
        data.condition(n).sppData(4).value = data.condition(n).sppData(1).value - data.condition(n).sppData(2).value;
        %Far 臒l
        data.condition(n).sppData(5).description = 'Far threshold';
        data.condition(n).sppData(5).value = data.condition(n).sppData(3).value - data.condition(n).sppData(1).value;
        
        %�u���v�I�𗦂� 16 %�̎����̒l
        data.condition(n).sppData(6).description = '16% far choice';
        data.condition(n).sppData(6).value = GetThreshold(0.16, data.condition(n).fitdata.func, data.condition(n).fitdata.prm);
        %�u���v�I�𗦂� 84 %�̎����̒l
        data.condition(n).sppData(7).description = '84% far choice';
        data.condition(n).sppData(7).value = GetThreshold(0.84, data.condition(n).fitdata.func, data.condition(n).fitdata.prm);
        %Near 臒l
        data.condition(n).sppData(8).description = 'Near threshold 16';
        data.condition(n).sppData(8).value = data.condition(n).sppData(1).value - data.condition(n).sppData(6).value;
        %Far 臒l
        data.condition(n).sppData(9).description = 'Far threshold 84';
        data.condition(n).sppData(9).value = data.condition(n).sppData(7).value - data.condition(n).sppData(1).value;
        % 25% 75%�̎����̕���
        data.condition(n).sppData(10).description = 'Far threshold 2575';
        data.condition(n).sppData(10).value = (data.condition(n).sppData(3).value - data.condition(n).sppData(2).value)/2;
        % 16% 84%�̎����̕���
        data.condition(n).sppData(11).description = 'Far threshold 1684';%%must edit!!
        data.condition(n).sppData(11).value = (data.condition(n).sppData(7).value - data.condition(n).sppData(6).value)/2;
        
        
        
        clear objfunc initVal;
        clear fvalMinNum fvalPFMin prmPFMin initValPFMin;

    disp('AllFarOK');
    end


    % ����W��(�S�������֐��̓��Ă͂܂�̂悳) �����߂� SSE:�c�������a SST:�S���U�̘a CoD:����W��

    for n = 1:length(data.condition)
        SSE_Correct(n) = sum(( data.condition(n).rawDataValue - data.condition(n).fitdata.func( data.x.value, data.condition(n).fitdata.prm) ).^2);
        meanrawDataValue = mean(data.condition(n).rawDataValue);
        SST_Correct(n) = sum(( data.condition(n).rawDataValue - meanrawDataValue).^2);
        data.condition(n).fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
    end  
%     clear Ytemp;
end




if strcmp(data.type , 'PCC')
   
    for n =1:length(data.condition)
        %�t�B�b�e�B���O����
        data.condition(n).fitdata.isFit = true;
        % �S������֐��̒�`
        data.condition(n).fitdata.func  = @(t, p) p(4) + (1 - p(4) - p(3)) .* evcdf(t,p(1),p(2)); 
    end
    
    LoopNum_Correct = 0;
    for n =1:length(data.condition)
        % �ړI�֐��̒�`
        objfunc = @(p) -mlefunc(p, data.x.value, data.condition(n).rawDataValue, data.condition(n).rawTrialNum, data.condition(n).fitdata.func);

        % �T���̏����l
        c = 1;
        for P = 0:0.5:0.5
        for Q = 0:0.5:0.5 
        for R = 0:0.25:0.50
        for S = 0:0.375:0.75    
            initVal{c} = [ P, Q, R, S]; %����,���U,��,���̒T�������l
            c = c + 1;
        end
        end
        end
        end

        % ����̒�`
        lb = [ 0, 1e-6,   0,  0 ];
        ub = [  Inf,  Inf,  1,  1 ];
        fvalMin = Inf;
        for c = 1:length(initVal)
            [ prm, fval, exitflag ] = fmincon( objfunc, initVal{c}, [], [], [], [], lb, ub, [], optimset('Display', 'notify' ) );

            if fval < fvalMin
                fvalMinNum = c; 
                fvalMin = fval;
                prmMin = prm;
                initValMinMat = initVal{c};
            end
            LoopNum_Correct = LoopNum_Correct +1

        end
        %�œK�ȒT���̏����l
        data.condition(n).fitdata.initVal = initValMinMat;
        %����,���U,��,��
%         prmMin(1) = 0; 
        data.condition(n).fitdata.prm = prmMin;
        %��`�����}�C�i�X�ޓx�֐��̍ŏ��l
        data.condition(n).fitdata.fval = fvalMin;
        % �ٕ�臒l (������ 75% �ɂ����鎋�����x) �����߂�
        data.condition(n).sppData(1).description = 'Threshold';
        data.condition(n).sppData(1).value = GetThreshold(0.75, data.condition(n).fitdata.func, data.condition(n).fitdata.prm);
        % ������ 60 %�ɂ����鎋�����x �����߂�
        data.condition(n).sppData(2).description = '60% correct choice';
        data.condition(n).sppData(2).value = GetThreshold(0.60, data.condition(n).fitdata.func, data.condition(n).fitdata.prm);
        % ������ 90 %�ɂ����鎋�����x �����߂�
        data.condition(n).sppData(3).description = '90% correct choice';
        data.condition(n).sppData(3).value = GetThreshold(0.90, data.condition(n).fitdata.func, data.condition(n).fitdata.prm); 
  
        clear objfunc initVal;
        clear fvalMinNum fvalMin prmMin initValMin;

  
    end

    % ����W��(�S�������֐��̓��Ă͂܂�̂悳) �����߂� SSE:�c�������a SST:�S���U�̘a CoD:����W��
    
    for n = 1:length(data.condition)
        SSE_Correct(n) = sum(( data.condition(n).rawDataValue - data.condition(n).fitdata.func( data.x.value, data.condition(n).fitdata.prm) ).^2);
        meanrawDataValue = mean(data.condition(n).rawDataValue);
        SST_Correct(n) = sum(( data.condition(n).rawDataValue - meanrawDataValue).^2);
        data.condition(n).fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
    end    
end


if strcmp(data.type ,'PFC')
    for n =1:length(data.all)
        %�t�B�b�e�B���O����
        data.all.fitdata.isFit = true;
        % �S������֐��̒�`
        data.all.fitdata.func  = @(t, p) p(4) + (1 - p(4) - p(3)) .* evcdf(t,p(1),p(2)); 
    end
    
    LoopNum_Far = 0;
    for n =1:length(data.all)
        % �ړI�֐��̒�`
        objfunc = @(p) -mlefunc(p, data.x.value, data.all.rawDataValue, data.all.rawTrialNum, data.all.fitdata.func);

        % �T���̏����l
        c = 1;
        for P = 0:0.25:0.5
        for Q = 0:0.5:0.5   
        for R = 0:0.25:0.50
        for S = 0:0.25:0.50    
            initVal{c} = [ P, Q, R, S]; %����,���U,��,���̒T�������l
            c = c + 1;
        end
        end
        end
        end

        % ����̒�`
        lb = [ 0, 1e-6,   0,  0 ];
        ub = [  Inf,  Inf,  1,  1 ];
        fvalPFMin = Inf;
        for c = 1:length(initVal)
            [ prmPF, fvalPF, exitflagPF ] = fmincon( objfunc, initVal{c}, [], [], [], [], lb, ub, [], optimset('Display', 'notify' ) );

            if fvalPF < fvalPFMin
                fvalMinNum = c; 
                fvalPFMin = fvalPF;
                prmPFMin = prmPF;
                initValPFMinMat = initVal{c};
            end
            LoopNum_Far = LoopNum_Far +1

        end
        %�œK�ȒT���̏����l
        data.all.fitdata.initVal = initValPFMinMat;
        %����,���U,��,��
        data.all.fitdata.prm = prmPFMin;
        %��`�����}�C�i�X�ޓx�֐��̍ŏ��l
        data.all.fitdata.fval = fvalPFMin;
        %��ϓI�����_
        data.all.sppData(1).description = 'PSE';
        data.all.sppData(1).value = GetThreshold(0.5, data.all.fitdata.func, data.all.fitdata.prm);
        %�u���v�I�𗦂� 25 %�̎����̒l
        data.all.sppData(2).description = '25% far choice';
        data.all.sppData(2).value = GetThreshold(0.25, data.all.fitdata.func, data.all.fitdata.prm);
        %�u���v�I�𗦂� 75 %�̎����̒l
        data.all.sppData(3).description = '75% far choice';
        data.all.sppData(3).value = GetThreshold(0.75, data.all.fitdata.func, data.all.fitdata.prm);
        %Near 臒l
        data.all.sppData(4).description = 'Near threshold';
        data.all.sppData(4).value = data.all.sppData(1).value - data.all.sppData(2).value;
        %Far 臒l
        data.all.sppData(5).description = 'Far threshold';
        data.all.sppData(5).value = data.all.sppData(3).value - data.all.sppData(1).value;
        %�u���v�I�𗦂� 16 %�̎����̒l
        data.all.sppData(6).description = '16% far choice';
        data.all.sppData(6).value = GetThreshold(0.16, data.all.fitdata.func, data.all.fitdata.prm);
        %�u���v�I�𗦂� 84 %�̎����̒l
        data.all.sppData(7).description = '84% far choice';
        data.all.sppData(7).value = GetThreshold(0.84, data.all.fitdata.func, data.all.fitdata.prm);
        %Near 臒l
        data.all.sppData(8).description = 'Near threshold 16';
        data.all.sppData(8).value = data.all.sppData(1).value - data.all.sppData(6).value;
        %Far 臒l
        data.all.sppData(9).description = 'Far threshold 84';
        data.all.sppData(9).value = data.all.sppData(7).value - data.all.sppData(1).value;
        % 25% 75%�̎����̕���
        data.all.sppData(10).description = 'Far threshold 2575';
        data.all.sppData(10).value = (data.all.sppData(3).value - data.all.sppData(2).value)/2;
        % 16% 84%�̎����̕���
        data.all.sppData(11).description = 'Far threshold 1684';%%must edit!!
        data.all.sppData(11).value = (data.all.sppData(7).value - data.all.sppData(6).value)/2;
        
        
        clear objfunc initVal;
        clear fvalMinNum fvalPFMin prmPFMin initValPFMin;

    disp('AllFarOK');
    end


    % ����W��(�S�������֐��̓��Ă͂܂�̂悳) �����߂� SSE:�c�������a SST:�S���U�̘a CoD:����W��

%     for n = 1:length(data.all)
%         for m = 1:data.ExpNum
%             dataAllDispVsConFarChoicePropMatTemp(:,m,n) = data.all.dataUsedinPcc.dataDispVsConFarChoicePropMat(:,n,m);
%         end
%         Ytemp(:,:,n) = repmat(data.all.rawDataValue,1, data.ExpNum);
%         SSE_Far(n) = sum(( data.all.rawDataValue - data.all.fitdata.func( data.x.value, data.all.fitdata.prm) ).^2);
%         SST_Far(n) = sum(sum((dataAllDispVsConFarChoicePropMatTemp(:,:,n) - Ytemp(:,:,n)).^2));
%         data.all.fitdata.r_sq = 1 - SSE_Far(n)/SST_Far(n);
% 
%     %     rsq_pf(n) = GetRsq( dataAllDispVsPosFarChoicePropMat(:,n,:),pmf(X(:,n), prmPFMat(n,:)) );
%     
%     end
    
    for n = 1:length(data.all)
        SSE_Correct(n) = sum(( data.all(n).rawDataValue - data.all(n).fitdata.func( data.x.value, data.all(n).fitdata.prm) ).^2);
        meanrawDataValue = mean(data.all(n).rawDataValue);
        SST_Correct(n) = sum(( data.all(n).rawDataValue - meanrawDataValue).^2);
        data.all(n).fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
    end
    clear SSE_Correct SST_Correct meanrawDataValue 
%     clear Ytemp;
end


if strcmp(data.type , 'PCC')
   
    for n =1:length(data.all)
        %�t�B�b�e�B���O����
        data.all(n).fitdata.isFit = true;
        % �S������֐��̒�`
        data.all(n).fitdata.func  = @(t, p) p(4) + (1 - p(4) - p(3)) .* evcdf(t,p(1),p(2)); 
    end
    
    LoopNum_Correct = 0;
    for n =1:length(data.all)
        % �ړI�֐��̒�`
        objfunc = @(p) -mlefunc(p, data.x.value, data.all(n).rawDataValue, data.all(n).rawTrialNum, data.all(n).fitdata.func);

        % �T���̏����l
        c = 1;
        for P = 0:0.5:0.5
        for Q = 0:0.5:0.5 
        for R = 0:0.25:0.50
        for S = 0:0.375:0.75    
            initVal{c} = [ P, Q, R, S]; %����,���U,��,���̒T�������l
            c = c + 1;
        end
        end
        end
        end

        % ����̒�`
        lb = [ 0, 1e-6,   0,  0 ];
        ub = [  Inf,  Inf,  1,  1 ];
        fvalMin = Inf;
        for c = 1:length(initVal)
            [ prm, fval, exitflag ] = fmincon( objfunc, initVal{c}, [], [], [], [], lb, ub, [], optimset('Display', 'notify' ) );

            if fval < fvalMin
                fvalMinNum = c; 
                fvalMin = fval;
                prmMin = prm;
                initValMinMat = initVal{c};
            end
            LoopNum_Correct = LoopNum_Correct +1

        end
        %�œK�ȒT���̏����l
        data.all(n).fitdata.initVal = initValMinMat;
        %����,���U,��,��
%         prmMin(1) = 0;
        data.all(n).fitdata.prm = prmMin;
        %��`�����}�C�i�X�ޓx�֐��̍ŏ��l
        data.all(n).fitdata.fval = fvalMin;
        % �ٕ�臒l (������ 75% �ɂ����鎋�����x) �����߂�
        data.all(n).sppData(1).description = 'Threshold';
        data.all(n).sppData(1).value = GetThreshold(0.75, data.all(n).fitdata.func, data.all(n).fitdata.prm);
        % ������ 60 %�ɂ����鎋�����x �����߂�
        data.all(n).sppData(2).description = '60% correct choice';
        data.all(n).sppData(2).value = GetThreshold(0.60, data.all(n).fitdata.func, data.all(n).fitdata.prm);
        % ������ 90 %�ɂ����鎋�����x �����߂�
        data.all(n).sppData(3).description = '90% correct choice';
        data.all(n).sppData(3).value = GetThreshold(0.90, data.all(n).fitdata.func, data.all(n).fitdata.prm);
        
        if data.all(n).sppData(1).value < 0.002 || data.all(n).sppData(1).value > 0.128
            data.all(n).sppData(1).value = GetThreshold2(0.75, data.all(n).fitdata.func, data.all(n).fitdata.prm);
            data.all(n).sppData(2).value = GetThreshold2(0.60, data.all(n).fitdata.func, data.all(n).fitdata.prm);
            data.all(n).sppData(3).value = GetThreshold2(0.90, data.all(n).fitdata.func, data.all(n).fitdata.prm); 
        end
        if data.all(n).sppData(1).value < 0.002 || data.all(n).sppData(1).value > 0.128
            data.all(n).sppData(1).value = GetThreshold3(0.75, data.all(n).fitdata.func, data.all(n).fitdata.prm);
            data.all(n).sppData(2).value = GetThreshold3(0.60, data.all(n).fitdata.func, data.all(n).fitdata.prm);
            data.all(n).sppData(3).value = GetThreshold3(0.90, data.all(n).fitdata.func, data.all(n).fitdata.prm); 
        end
  
        clear objfunc initVal;
        clear fvalMinNum fvalMin prmMin initValMin;

  
    end

    % ����W��(�S�������֐��̓��Ă͂܂�̂悳) �����߂� SSE:�c�������a SST:�S���U�̘a CoD:����W��

%     for n = 1:length(data.all)
%         for m = 1:data.ExpNum
%             dataAllMagDispVsConCorrectChoicePropMatTemp(:,m,n) = data.all.dataUsedinFitData.dataMagDispVsConCorrectChoicePropMat(:,n,m);
%         end
%         Ytemp(:,:,n) = repmat( data.all(n).rawDataValue,1,data.ExpNum);
%         SSE_Correct(n) = sum(( data.all(n).rawDataValue - data.all(n).fitdata.func( data.x.value, data.all(n).fitdata.prm) ).^2);
%         SST_Correct(n) = sum(sum((dataAllMagDispVsConCorrectChoicePropMatTemp(:,:,n) - Ytemp(:,:,n)).^2));
%         data.all(n).fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
%     end

    for n = 1:length(data.all)
        SSE_Correct(n) = sum(( data.all(n).rawDataValue - data.all(n).fitdata.func( data.x.value, data.all(n).fitdata.prm) ).^2);
        meanrawDataValue = mean(data.all(n).rawDataValue);
        SST_Correct(n) = sum(( data.all(n).rawDataValue - meanrawDataValue).^2);
        data.all(n).fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
    end
    clear SSE_Correct SST_Correct meanrawDataValue 

%     for 
%     data.all(n).fitdata.func(t,data.all(n).fitdata.prm)
end
%%
if strcmp(data.type , 'PCC')
   
    for n =1:length(data.left)
        %�t�B�b�e�B���O����
        data.left.fitdata.isFit = true;
        % �S������֐��̒�`
        data.left.fitdata.func  = @(t, p) p(4) + (1 - p(4) - p(3)) .* evcdf(t,p(1),p(2)); 
    end
    
    LoopNum_Correct = 0;
    for n =1:length(data.left)
        % �ړI�֐��̒�`
        objfunc = @(p) -mlefunc(p, data.x.value, data.left.rawDataValue, data.left.rawTrialNum, data.left.fitdata.func);

        % �T���̏����l
        c = 1;
        for P = 0:0.5:0.5
        for Q = 0:0.5:0.5 
        for R = 0:0.25:0.50
        for S = 0:0.375:0.75   
            initVal{c} = [ P, Q, R, S]; %����,���U,��,���̒T�������l
            c = c + 1;
        end
        end
        end
        end

        % ����̒�`
        lb = [ 0, 1e-6,   0,  0 ];
        ub = [  Inf,  Inf,  1,  1 ];
        fvalMin = Inf;
        for c = 1:length(initVal)
            [ prm, fval, exitflag ] = fmincon( objfunc, initVal{c}, [], [], [], [], lb, ub, [], optimset('Display', 'notify' ) );

            if fval < fvalMin
                fvalMinNum = c; 
                fvalMin = fval;
                prmMin = prm;
                initValMinMat = initVal{c};
            end
            LoopNum_Correct = LoopNum_Correct +1

        end
        %�œK�ȒT���̏����l
        data.left.fitdata.initVal = initValMinMat;
        %����,���U,��,��
%         prmMin(1) = 0;
        data.left.fitdata.prm = prmMin;
        %��`�����}�C�i�X�ޓx�֐��̍ŏ��l
        data.left.fitdata.fval = fvalMin;
        % �ٕ�臒l (������ 75% �ɂ����鎋�����x) �����߂�
        data.left.sppData(1).description = 'Threshold';
        data.left.sppData(1).value = GetThreshold(0.75, data.left.fitdata.func, data.left.fitdata.prm);
        % ������ 60 %�ɂ����鎋�����x �����߂�
        data.left.sppData(2).description = '60% correct choice';
        data.left.sppData(2).value = GetThreshold(0.60, data.left.fitdata.func, data.left.fitdata.prm);
        % ������ 90 %�ɂ����鎋�����x �����߂�
        data.left.sppData(3).description = '90% correct choice';
        data.left.sppData(3).value = GetThreshold(0.90, data.left.fitdata.func, data.left.fitdata.prm); 
        
        
        if data.left(n).sppData(1).value < 0.002 || data.left(n).sppData(1).value > 0.128
            data.left(n).sppData(1).value = GetThreshold2(0.75, data.left(n).fitdata.func, data.left(n).fitdata.prm);
            data.left(n).sppData(2).value = GetThreshold2(0.60, data.left(n).fitdata.func, data.left(n).fitdata.prm);
            data.left(n).sppData(3).value = GetThreshold2(0.90, data.left(n).fitdata.func, data.left(n).fitdata.prm); 
        end
        if data.left(n).sppData(1).value < 0.002 || data.left(n).sppData(1).value > 0.128
            data.left(n).sppData(1).value = GetThreshold3(0.75, data.left(n).fitdata.func, data.left(n).fitdata.prm);
            data.left(n).sppData(2).value = GetThreshold3(0.60, data.left(n).fitdata.func, data.left(n).fitdata.prm);
            data.left(n).sppData(3).value = GetThreshold3(0.90, data.left(n).fitdata.func, data.left(n).fitdata.prm); 
        end
  
        clear objfunc initVal;
        clear fvalMinNum fvalMin prmMin initValMin;

  
    end
    
    
    

    % ����W��(�S�������֐��̓��Ă͂܂�̂悳) �����߂� SSE:�c�������a SST:�S���U�̘a CoD:����W��

%     for n = 1:length(data.left)
%         for m = 1:data.ExpNum
%             dataleftMagDispVsConCorrectChoicePropMatTemp(:,m,n) = data.left.dataUsedinFitData.dataMagDispVsConCorrectChoicePropMat(:,n,m);
%         end
%         Ytemp(:,:,n) = repmat( data.left.rawDataValue,1,data.ExpNum);
%         SSE_Correct(n) = sum(( data.left.rawDataValue - data.left.fitdata.func( data.x.value, data.left.fitdata.prm) ).^2);
%         SST_Correct(n) = sum(sum((dataleftMagDispVsConCorrectChoicePropMatTemp(:,:,n) - Ytemp(:,:,n)).^2));
%         data.left.fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
%     end
    for n = 1:length(data.left)
        SSE_Correct(n) = sum(( data.left(n).rawDataValue - data.left(n).fitdata.func( data.x.value, data.left(n).fitdata.prm) ).^2);
        meanrawDataValue = mean(data.left(n).rawDataValue);
        SST_Correct(n) = sum(( data.left(n).rawDataValue - meanrawDataValue).^2);
        data.left(n).fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
    end
    clear SSE_Correct SST_Correct meanrawDataValue 
%     for 
%     data.all(n).fitdata.func(t,data.all(n).fitdata.prm)
end

if strcmp(data.type , 'PCC')
   
    for n =1:length(data.right)
        %�t�B�b�e�B���O����
        data.right.fitdata.isFit = true;
        % �S������֐��̒�`
        data.right.fitdata.func  = @(t, p) p(4) + (1 - p(4) - p(3)) .* evcdf(t,p(1),p(2));  
    end
    
    LoopNum_Correct = 0;
    for n =1:length(data.right)
        % �ړI�֐��̒�`
        objfunc = @(p) -mlefunc(p, data.x.value, data.right.rawDataValue, data.right.rawTrialNum, data.right.fitdata.func);

        % �T���̏����l
        c = 1;
        for P = 0:0.5:0.5
        for Q = 0:0.5:0.5 
        for R = 0:0.25:0.50
        for S = 0:0.375:0.75     
            initVal{c} = [ P, Q, R, S]; %����,���U,��,���̒T�������l
            c = c + 1;
        end
        end
        end
        end

        % ����̒�`
        lb = [ 0, 1e-6,   0,  0 ];
        ub = [  Inf,  Inf,  1,  1 ];
        fvalMin = Inf;
        for c = 1:length(initVal)
            [ prm, fval, exitflag ] = fmincon( objfunc, initVal{c}, [], [], [], [], lb, ub, [], optimset('Display', 'notify' ) );

            if fval < fvalMin
                fvalMinNum = c; 
                fvalMin = fval;
                prmMin = prm;
                initValMinMat = initVal{c};
            end
            LoopNum_Correct = LoopNum_Correct +1

        end
        %�œK�ȒT���̏����l
        data.right.fitdata.initVal = initValMinMat;
        %����,���U,��,��
%         prmMin(1) = 0;
        data.right.fitdata.prm = prmMin;
        %��`�����}�C�i�X�ޓx�֐��̍ŏ��l
        data.right.fitdata.fval = fvalMin;
        % �ٕ�臒l (������ 75% �ɂ����鎋�����x) �����߂�
        data.right.sppData(1).description = 'Threshold';
        data.right.sppData(1).value = GetThreshold(0.75, data.right.fitdata.func, data.right.fitdata.prm);
        % ������ 60 %�ɂ����鎋�����x �����߂�
        data.right.sppData(2).description = '60% correct choice';
        data.right.sppData(2).value = GetThreshold(0.60, data.right.fitdata.func, data.right.fitdata.prm);
        % ������ 90 %�ɂ����鎋�����x �����߂�
        data.right.sppData(3).description = '90% correct choice';
        data.right.sppData(3).value = GetThreshold(0.90, data.right.fitdata.func, data.right.fitdata.prm); 

        if data.right(n).sppData(1).value < 0.002 || data.right(n).sppData(1).value > 0.128
            data.right(n).sppData(1).value = GetThreshold2(0.75, data.right(n).fitdata.func, data.right(n).fitdata.prm);
            data.right(n).sppData(2).value = GetThreshold2(0.60, data.right(n).fitdata.func, data.right(n).fitdata.prm);
            data.right(n).sppData(3).value = GetThreshold2(0.90, data.right(n).fitdata.func, data.right(n).fitdata.prm); 
        end
        if data.right(n).sppData(1).value < 0.002 || data.right(n).sppData(1).value > 0.128
            data.right(n).sppData(1).value = GetThreshold3(0.75, data.right(n).fitdata.func, data.right(n).fitdata.prm);
            data.right(n).sppData(2).value = GetThreshold3(0.60, data.right(n).fitdata.func, data.right(n).fitdata.prm);
            data.right(n).sppData(3).value = GetThreshold3(0.90, data.right(n).fitdata.func, data.right(n).fitdata.prm); 
        end        
        
        
        clear objfunc initVal;
        clear fvalMinNum fvalMin prmMin initValMin;

  
    end

    % ����W��(�S�������֐��̓��Ă͂܂�̂悳) �����߂� SSE:�c�������a SST:�S���U�̘a CoD:����W��

%     for n = 1:length(data.right)
%         for m = 1:data.ExpNum
%             datarightMagDispVsConCorrectChoicePropMatTemp(:,m,n) = data.right.dataUsedinFitData.dataMagDispVsConCorrectChoicePropMat(:,n,m);
%         end
%         Ytemp(:,:,n) = repmat( data.right.rawDataValue,1,data.ExpNum);
%         SSE_Correct(n) = sum(( data.right.rawDataValue - data.right.fitdata.func( data.x.value, data.right.fitdata.prm) ).^2);
%         SST_Correct(n) = sum(sum((datarightMagDispVsConCorrectChoicePropMatTemp(:,:,n) - Ytemp(:,:,n)).^2));
%         data.right.fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
%     end
    
    for n = 1:length(data.right)
        SSE_Correct(n) = sum(( data.right(n).rawDataValue - data.right(n).fitdata.func( data.x.value, data.right(n).fitdata.prm) ).^2);
        meanrawDataValue = mean(data.right(n).rawDataValue);
        SST_Correct(n) = sum(( data.right(n).rawDataValue - meanrawDataValue).^2);
        data.right(n).fitdata.r_sq = 1 - SSE_Correct(n)/SST_Correct(n);
    end
    clear SSE_Correct SST_Correct meanrawDataValue 
%     for 
%     data.all(n).fitdata.func(t,data.all(n).fitdata.prm)
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subfunctions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%�ޓx�֐�
function out = mlefunc(p, x, y, n, f)
CNDF = f(x, p);

CNDF( CNDF <= 0 ) = 1e-6;
CNDF( CNDF >= 1 ) = 1 - 1e-6;

out = sum ( log ( factorial(n) ./ ( factorial( round(y .* n) ) .* factorial( round(n - y .* n) ) ) ) ...
                       + y .* n .* ( log( CNDF ) ) ...
                       + ( 1 - y ) .* n .* ( log( 1 - CNDF ) ) );
                   %K�͂��ꂼ��̃x�N�g���̒���
%�t�֐�
function x = GetThreshold(y, f, p)
objectFunc = @(t) (f(t, p) - y) ^ 2;
x = fminsearch(objectFunc, p(1),[]);%p(1)�}�s�ȂƂ���������l�ɂ���

%�t�֐�
function x = GetThreshold2(y, f, p)
objectFunc = @(t) (f(t, p) - y) ^ 2;
x = fminsearch(objectFunc, 0,[]);%p(1)�}�s�ȂƂ���������l�ɂ���

%�t�֐�
function x = GetThreshold3(y, f, p)
objectFunc = @(t) (f(t, p) - y) ^ 2;
x = fminsearch(objectFunc, 1,[]);%p(1)�}�s�ȂƂ���������l�ɂ���

% %����W��
% function r_sq = GetRsq(ExpNum,datacon,ChoicePropMat,x,y,p,f)
%     for n = 1:length(datacon)
%         for m = 1:ExpNum
%             RevChoicePropMat(:,m,n) = ChoicePropMat(:,n,m);
%         end
%         Ytemp(:,:,n) = repmat(y(n),1,length(dataFiles));
%         SSE(n) = sum(( y(n) - f( x, p(n) ) ).^2);
%         SST(n) = sum(sum((RevChoicePropMat(:,:,n) - Ytemp(:,:,n)).^2));
%         r_sq(n) = 1 - SSE(n)/SST(n);
%     end
% r = 1 - sum( (y - fx) .^ 2 ) / sum( (y - mean(y,1)) .^ 2 );%mean(y,1) �񕽋�
% 
% data.all.fitdata.r_sq = GetRsq( data.ExpNum,data.all,data.dataUsedinPcc.dataAllDispVsPosFarChoicePropMat, data.x.value,data.all.rawDataValue, data.all(n).fitdata.prm,data.all(n).fitdata.func)