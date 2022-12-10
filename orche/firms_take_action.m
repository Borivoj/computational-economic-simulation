function [ FirmsActionsIndexes ] = firms_take_action( cfg,firms,State )
    FirmsActionsIndexes = zeros(cfg.n_firms, cfg.DIMS_f.q);
    for firm_index = 1:cfg.n_firms
       FirmsActionsIndexes(firm_index)=firms(firm_index).action(State,cfg,0);
    end
end

