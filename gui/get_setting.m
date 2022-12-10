function [] = get_setting(mw)
    mw.cfg.TechnologyGrowth = mw.TechnologygrowthrateEditField.Value/100;
    mw.cfg.eps = mw.epsilonEditField_2.Value/100;
    mw.cfg.eps_w = mw.epsilon_wEditField.Value/100;
    mw.cfg.alpha = mw.alphaEditField.Value;
    mw.cfg.Technology = mw.ProductiontechnologyEditField.Value;
    mw.cfg.gamma = mw.betaEditField.Value;
    mw.cfg.Learning_rate = mw.LearningRate.Value;
    mw.cfg.Cl = mw.CostOfLiving.Value;
    mw.cfg.rho = mw.util_rho.Value;
    mw.cfg.sigma = mw.util_sigma.Value;
    mw.cfg.firm_emerge_prob = mw.NewfirmemergenceprobEditField.Value;
    mw.cfg.NumberOfSimulations = mw.NumberofsimulationsEditField.Value;
    mw.cfg.n_firms = mw.NumberofhouseholdsEditField.Value;
    mw.cfg.n_households = mw.NumberofhouseholdsEditField.Value;
    if mw.MovingdiscretizationpointsButton.Value == 1
        mw.cfg.q_algo_type = 1;
    elseif mw.LearningrateadjustmentButton.Value == 1
        mw.cfg.q_algo_type = 2;
    elseif mw.DeltaadjustmentButton.Value == 1
        mw.cfg.q_algo_type = 3;
    end

    for sim_indx = 1:length(mw.sims)
        mw.sims(sim_indx).cfg = mw.cfg;
        mw.sims(sim_indx).economy.Next_Price_B = mw.Q.Value;
    end
end