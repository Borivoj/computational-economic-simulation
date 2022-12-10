classdef setup
    %% Basic simulation parameters setup
    methods(Static)
        function cfg = config()
            %% Number of simulations
            cfg.NumberOfSimulations = 4;
            %% Number of Agents
            cfg.n_firms = 50;
            cfg.n_households = 60;

            %% Q-learning parameters
            % Algorithm type selection 
            % 1 - moving disc. points
            % 2 - learning rate adjustment
            % 3 - delta adjustment
            cfg.q_algo_type = 3;
            
            % Dicretization of state/action space
            cfg.discretization_points_state = 5;
            cfg.discretization_points_action = 5;
            cfg.MinimumPrice = 0.01;
            cfg.discretization_coef_state = (1-cfg.MinimumPrice)/(cfg.discretization_points_state-1);
            cfg.discretization_coef_action = 1/(cfg.discretization_points_action-1);
            % discount rate
            cfg.gamma = 0.95;
            % Learning rate
            cfg.Learning_rate = 0.9;
            % Select random action probability
            cfg.eps = 0.1;
            cfg.eps_w = 0.1; % This get overwritten while setting grids - see code below

            %% Economy parameters
            % Set Technlogy coef and Technology growth coef
            cfg.Technology = 2;
            cfg.TechnologyGrowth = 0.000;
            % Production function
            cfg.alpha = 0.1; % 0.1 
            % Households utility function
            cfg.rho = 14;
            cfg.sigma = 0.2;
            cfg.Cl = 0.1;
            
            % Firm cost of living
            cfg.Cl_firm = cfg.Cl;

            % inflation target - set to empty for no central bank
            cfg.InflationTarget=[];
            % Firmsproduction function - use capital or not?
            cfg.cap = 1;
            % Wage is set to constant
            cfg.Wage = 1;

            %% Additional parameters
            cfg.maxLabor = 4;

            cfg.firm_emerge_prob = 0.1;

            %% Initial endowment

            cfg.initial_enw_firm = 4;
            cfg.initial_enw_household = 2;

            %% Dividends 

            cfg.dividend_treshold = 5;
            cfg.dividend_ratio = 0.1;
            
        end
        function cfg = grids(cfg)
            %% Set discretization grids
            % Household
            % Price, BondPrice, Budget - Three dimensional state
            PriceDiscretization = 0.0:0.2:1;%[0.01 0.2 0.4 0.6 0.8 1];%cfg.MinimumPrice:cfg.discretization_coef_state:1;
            BondPriceDiscretization = [0.8:0.1:1];%0.7:0.1:1;%[0.5 0.95 1];%[0.7 (1-0.7)/(cfg.discretization_points_state) 1];%cfg.MinimumPrice:cfg.discretization_coef_state:1;
            BudgetDiscretization = n_dense([0 1 2 3 4 5 6 10 100],0);%[0:1/(cfg.discretization_points_state-1):(1-1/(cfg.discretization_points_state-1)) 100000]*5;

            cfg.xgrids_h = {PriceDiscretization, BondPriceDiscretization, BudgetDiscretization};
            % Action
            cfg.ugrids_h = {0:cfg.discretization_coef_action:1, [0 1]};
            % Firms
            % Price, BondPrice, Budget
            BudgetDiscretization = n_dense([0 1 2 3 4 5 6 10 100],0);
            cfg.xgrids_f = {PriceDiscretization, BondPriceDiscretization, BudgetDiscretization};
            % Amout of labor hired (Action)
            cfg.ugrids_f = {0:cfg.discretization_coef_action:1};
            
            X_h = cfg.xgrids_h;
            U_h = cfg.ugrids_h;
            cfg.DIMS_h.p = length(X_h);
            cfg.DIMS_h.q = length(U_h); 
            cfg.DIMS_h.dimx = [];
            cfg.DIMS_h.dimu = [];
            for p = 1:cfg.DIMS_h.p
                cfg.DIMS_h.dimx(p) = length(X_h{p});
            end
            for q = 1:cfg.DIMS_h.q
                cfg.DIMS_h.dimu(q) = length(U_h{q});
            end
            cfg.tab_h = dec2base(0:(2^cfg.DIMS_h.p-1), 2) - 47;
            
            X_f = cfg.xgrids_f;
            U_f = cfg.ugrids_f;
            cfg.DIMS_f.p = length(X_f);
            cfg.DIMS_f.q = length(U_f); 
            
            cfg.DIMS_f.dimx = [];
            cfg.DIMS_f.dimu = [];
            
            for p = 1:cfg.DIMS_f.p
                cfg.DIMS_f.dimx(p) = length(X_f{p});
            end
            for q = 1:cfg.DIMS_f.q
                cfg.DIMS_f.dimu(q) = length(U_f{q});
            end
            cfg.tab_f = dec2base(0:(2^cfg.DIMS_f.p-1), 2) - 47;

            %% Market grid
            cfg.gmgrid = cfg.xgrids_h{1}(1):( (cfg.xgrids_h{1}(end)-cfg.xgrids_h{1}(1))/30 ):cfg.xgrids_h{1}(end);
        end
        function [Price, Next_Price, Price_B, Next_Price_B] = initial_param_values()
           Price = 0.5;
           Next_Price = Price;
           Price_B = 0.99; 
           Next_Price_B = Price_B;
        end
        function hist = time_series()
            hist.PriceEvolution=[];
            hist.HDP=[];
            hist.HistProfit=[];
            hist.ExcessSupply=[];
            hist.LaborHist=[];
            hist.GoodsProducedHist=[]; 
        end
        function indx = indexing(cfg)
            indx.HouseholdsWorks=zeros(cfg.n_households,1);
            indx.HouseholdsActionsIndexes=ones(cfg.n_households,2);
            indx.FirmsActionsIndexes=ones(cfg.n_firms,1);
            indx.FirmReward=zeros(cfg.n_firms,1);
            indx.Reward=zeros(cfg.n_households,1);
        end
        function [households] = households(cfg)
            households = household.empty(cfg.n_households,0);
            for hindx = 1:cfg.n_households
               households(hindx) = household(cfg); 
            end
        end
        function [firms] = firms(cfg)
            firms = firm.empty(cfg.n_firms,0);
            for findx = 1:cfg.n_firms
                firms(findx) = firm(cfg); 
            end
        end
    end
end

