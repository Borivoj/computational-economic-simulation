function [ Supply ] = aggregate_supply(firms,FirmsActionIndexes, cfg, BondPrice, LaborSupply )
    LaborDemand = zeros(cfg.n_firms,numel(cfg.gmgrid));
    Supply = zeros(1,numel(cfg.gmgrid));
    for firm_indx = 1:cfg.n_firms
       LaborDemand(firm_indx,:) = supply_function(firms(firm_indx),FirmsActionIndexes(firm_indx,:), cfg,BondPrice, 1); 
    end
    for CurvePointIndex = 1:numel(cfg.gmgrid)
        TotLaborDemand = sum(LaborDemand(:,CurvePointIndex));
        for firm_indx = 1:cfg.n_firms
            if LaborSupply(CurvePointIndex)<=TotLaborDemand
                ExpLabor = LaborDemand(firm_indx,CurvePointIndex) * (LaborSupply(CurvePointIndex)/TotLaborDemand);
            else
                ExpLabor = LaborDemand(firm_indx,CurvePointIndex);
            end
            
    
            if cfg.cap 
                Capital = firms(firm_indx).NextBudget - ExpLabor*cfg.Wage;
                if (any(Capital<0))
                    error('Wrong action selected')
                end
            else
                Capital = [];
            end
            
            Supply(CurvePointIndex) = Supply(CurvePointIndex) + Cobb_Douglas(cfg.Technology, ExpLabor,Capital, cfg.alpha);
        end
    end
end

