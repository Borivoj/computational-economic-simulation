function [ Supply ] = supply_function( firm,random_action, cfg, Price_B, labor_hired)

    ActionIndexes = zeros(cfg.DIMS_f.dimx(1),length(cfg.DIMS_f.dimu));
    if random_action == 0
        for CurvePointIndex = 1:numel(cfg.gmgrid)
           Price_G=cfg.gmgrid(CurvePointIndex);
           State = [Price_G, Price_B];
           [SelectedActionIndex] = firm.action(State,cfg,1);
           ActionIndexes(CurvePointIndex,:)=SelectedActionIndex; 
        end
    else
        for CurvePointIndex = 1:numel(cfg.gmgrid)
           ActionIndexes(CurvePointIndex,:)=random_action; 
        end
    end


    if (~labor_hired)
        Labor = cfg.maxLabor*cfg.ugrids_f{1}(ActionIndexes);

        if cfg.cap 
            Capital = firm.NextBudget - Labor*cfg.Wage;
            if (any(Capital<0))
                error('Wrong action selected')
            end
        else
            Capital = [];
        end
        
        Supply = Cobb_Douglas(cfg.Technology, Labor,Capital, cfg.alpha);
    else
        Wage=1;
        Supply = cfg.maxLabor*cfg.ugrids_f{1}(ActionIndexes);
    end

end

