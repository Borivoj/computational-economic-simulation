function [] = set_gui_setting(mw)
    % Set gui values
    mw.NumberofsimulationsEditField.Value = mw.cfg.NumberOfSimulations;
    mw.NumberofhouseholdsEditField.Value = mw.cfg.n_households;
    mw.NumberoffirmsEditField.Value = mw.cfg.n_firms;
    mw.TechnologygrowthrateEditField.Value = mw.cfg.TechnologyGrowth*100;
    mw.ProductiontechnologyEditField.Value = mw.cfg.Technology;

    mw.Q.Value = mw.sims(1).economy.Price_B;

    mw.epsilonEditField_2.Value = mw.cfg.eps*100;
    mw.epsilon_wEditField.Value = mw.cfg.eps_w*100;

    mw.alphaEditField.Value = mw.cfg.alpha;
    mw.betaEditField.Value = mw.cfg.gamma;

    mw.LearningRate.Value = mw.cfg.Learning_rate;

    mw.util_sigma.Value = mw.cfg.sigma;
    mw.util_rho.Value = mw.cfg.rho;
    
    mw.CostOfLiving.Value = mw.cfg.Cl;
    
    mw.NewfirmemergenceprobEditField.Value = mw.cfg.firm_emerge_prob;

    if mw.cfg.q_algo_type == 1
        mw.MovingdiscretizationpointsButton.Value = 1;
    elseif mw.cfg.q_algo_type == 2
        mw.LearningrateadjustmentButton.Value = 1;
    elseif mw.cfg.q_algo_type == 3
        mw.DeltaadjustmentButton.Value = 1;
    end


end