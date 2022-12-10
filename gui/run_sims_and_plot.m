function [] = run_sims_and_plot(app, n_rounds)
    rounds_at_once = 5;
    
    for round = 1:n_rounds/rounds_at_once
        n_rounds_to_disp = numel(app.sims(1).hist.Price)+rounds_at_once;
        Price = zeros(app.cfg.NumberOfSimulations, n_rounds_to_disp);
        Unemploy = zeros(app.cfg.NumberOfSimulations, n_rounds_to_disp);
        Consumption = zeros(app.cfg.NumberOfSimulations, n_rounds_to_disp);
        Money = zeros(app.cfg.NumberOfSimulations, n_rounds_to_disp);
        Labor = zeros(app.cfg.NumberOfSimulations, n_rounds_to_disp);
        
        for sim_indx = 1:app.cfg.NumberOfSimulations
            app.sims(sim_indx).run(rounds_at_once);
            Price(sim_indx,:) = app.sims(sim_indx).hist.Price;
            Price(sim_indx,:) = app.sims(sim_indx).hist.Price;
            Price(sim_indx,:) = app.sims(sim_indx).hist.Price;
            Price(sim_indx,:) = app.sims(sim_indx).hist.Price;

            Price(sim_indx,:) = app.sims(sim_indx).hist.Price;
            Unemploy(sim_indx,:) = app.sims(sim_indx).hist.Unemploynment;
            Consumption(sim_indx,:) = app.sims(sim_indx).hist.Consumption;
            Money(sim_indx,:) = app.sims(sim_indx).hist.Money;
            Labor(sim_indx,:) = app.sims(sim_indx).hist.Labor;
        end
        
        %% Plot price
        plot_int.price(app.Price, Price, [0 n_rounds_to_disp]);
        plot_int.consumption(app.Consumption, Consumption, [0 n_rounds_to_disp]);
        plot_int.unempl(app.Unemploynment, Unemploy, [0 n_rounds_to_disp]);
        plot_int.labor(app.Labor, Labor, [0 n_rounds_to_disp]);
        plot_int.money(app.MoneySupply, Money, [0 n_rounds_to_disp]);
        pause(0.001);
    end
    
end