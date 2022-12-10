function [ Price ] = EQ_goods_price( households, firms,rand_indx, cfg, BondPrice, OldPrice, mw )
    if isempty(rand_indx)
        rand_indx.FirmsActionsIndexes = zeros(cfg.n_firms,cfg.DIMS_f.q);
        rand_indx.HouseholdsActionsIndexes = zeros(cfg.n_households,cfg.DIMS_h.q);
    end

    
    [Demand, Labor] = aggregate_demand(households,rand_indx.HouseholdsActionsIndexes, cfg, BondPrice); 


    Supply = aggregate_supply(firms,rand_indx.FirmsActionsIndexes, cfg,BondPrice, Labor);

    Intersects = supply_demand_intersects( Supply, Demand, cfg.gmgrid);
    Price = Intersects(randi(numel(Intersects)));
    %Price = closest_point_in_vec( OldPrice,  Intersects );

    if isa(mw,'main_window')
        plot(mw.Market,cfg.gmgrid(4:end),Supply(4:end),'LineWidth',1, 'Color','red');
        hold(mw.Market,'on')
        plot(mw.Market,cfg.gmgrid(4:end),Demand(4:end),'LineWidth',1, 'Color','black');
        hold(mw.Market,'off')
    end
end

