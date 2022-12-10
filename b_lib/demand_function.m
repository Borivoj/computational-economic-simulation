function [ Demand, Labor ] = demand_function( household,random_action, Price_B, cfg)
    
    ActionIndexes = zeros(numel(cfg.gmgrid),length(cfg.DIMS_h.dimu));
    
    for CurvePointIndex = 1:numel(cfg.gmgrid)
        Price_G=cfg.gmgrid(CurvePointIndex);  
        
        [SelectedActionIndex] = household.action([Price_G, Price_B],cfg, 1);
        
        ActionIndexes(CurvePointIndex,:)=SelectedActionIndex;
    end

    if random_action(1) ~= 0
        ActionIndexes(:,1)=random_action(1);
    end

    if random_action(2) ~= 0
        ActionIndexes(:,2)=random_action(2);
    end
        
    Budget = household.NextBudget;
    Demand = ( Budget*cfg.ugrids_h{1}(ActionIndexes(:,1)) ) ./ cfg.gmgrid;%( cfg.maxGoods*cfg.ugrids_h{1}(ActionIndexes(:,1)) )
    Labor = cfg.ugrids_h{2}(ActionIndexes(:,2));
    
end

