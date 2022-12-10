classdef sim < handle

    properties
        economy
        hist
        indx
        cfg
    end

    methods
        function obj = reset(obj,cfg)
            if (isempty(cfg))
                obj.cfg = setup.config();
                obj.cfg = setup.grids(obj.cfg);
            else
                obj.cfg = cfg;
            end

            obj.indx = setup.indexing(obj.cfg);

            obj.hist.Consumption=[];
            obj.hist.Price=[];
            obj.hist.Unemploynment=[];
            obj.hist.Technology =[];
            obj.hist.Inflation = [];
            obj.hist.Money =[];
            obj.hist.Labor=[];
            obj.hist.BondPrice = [];

            obj.economy.households = setup.households(obj.cfg);
            obj.economy.firms = setup.firms(obj.cfg);

            [obj.economy.Price, obj.economy.Next_Price, obj.economy.Price_B, obj.economy.Next_Price_B] = setup.initial_param_values();


            % Add money to the economy
            for firm = obj.economy.firms
                firm.Budget = obj.cfg.initial_enw_firm;
                firm.NextBudget = obj.cfg.initial_enw_firm;
            end
            for household = obj.economy.households
                household.Budget = obj.cfg.initial_enw_household;
                household.NextBudget = obj.cfg.initial_enw_household;
            end

            % Set theta to random values
            for firm = obj.economy.firms
                firm.theta_lin = zero_field(firm.theta_lin);
            end

            for household = obj.economy.households
                household.theta_lin = zero_field(household.theta_lin);
            end


            obj.indx.FirmsActionsIndexes = firms_take_action(obj.cfg, obj.economy.firms, [obj.economy.Price obj.economy.Price_B]);
            obj.indx.HouseholdsActionsIndexes=households_take_action( obj.cfg,obj.economy.households,[obj.economy.Price obj.economy.Price_B] );

        end
        function step(obj, hist_start_point, round)

            % Central bank sets next bond price
            if 0==mod(round-1,10) && round>1 && ~isempty(obj.cfg.InflationTarget)
                obj.economy.Next_Price_B = central_bank(obj.economy.Price_B, obj.hist.Price((end-n_rounds+round-10):(end-n_rounds+round-1)), obj.cfg.InflationTarget);
            end

            % Get equilibriu goods price

            obj.economy.Next_Price = EQ_goods_price( obj.economy.households, obj.economy.firms,[], obj.cfg, obj.economy.Next_Price_B, obj.economy.Price, []);

            % Get random actions, i.e. determine for which firms/households
            % rand<eps
            [rand_indx] = random_actions(obj.cfg, 1 ,obj.economy.firms, obj.economy.households, obj.cfg.Wage,1, obj.economy.Next_Price);

            % Update Q estimates
            if round > 1
                update_q_t( obj.economy.firms, obj.cfg, obj.indx.FirmsActionsIndexes, [obj.economy.Price obj.economy.Price_B], [obj.economy.Next_Price obj.economy.Next_Price_B], obj.indx.FirmReward);
                update_q_t( obj.economy.households, obj.cfg, obj.indx.HouseholdsActionsIndexes, [obj.economy.Price obj.economy.Price_B], [obj.economy.Next_Price obj.economy.Next_Price_B], obj.indx.Reward);
            end

            % Put economy into next state, i.e. Price = Next_Price
            obj.economy = next_state(obj.economy);

            % Households decide on action
            obj.indx.HouseholdsActionsIndexes=households_take_action( obj.cfg,obj.economy.households,[obj.economy.Price obj.economy.Price_B] );
            % Firms take action
            obj.indx.FirmsActionsIndexes=firms_take_action(obj.cfg, obj.economy.firms, [obj.economy.Price obj.economy.Price_B]);
            % Randomize actions
            obj.indx.HouseholdsActionsIndexes(rand_indx.HouseholdsActionsIndexes(:,1)~=0,1)=rand_indx.HouseholdsActionsIndexes(rand_indx.HouseholdsActionsIndexes(:,1)~=0,1);
            obj.indx.HouseholdsActionsIndexes(rand_indx.HouseholdsActionsIndexes(:,2)~=0,2)=rand_indx.HouseholdsActionsIndexes(rand_indx.HouseholdsActionsIndexes(:,2)~=0,2);
            obj.indx.FirmsActionsIndexes(rand_indx.FirmsActionsIndexes(:,1)~=0,1)=rand_indx.FirmsActionsIndexes(rand_indx.FirmsActionsIndexes(:,1)~=0,1);

            % Calculate unemploynment rate
            LaborDemanded = sum(obj.cfg.ugrids_f{1}(obj.indx.FirmsActionsIndexes).*obj.cfg.maxLabor);
            LaborSupplied = sum(obj.indx.HouseholdsActionsIndexes(:,2)-1);
            obj.hist.Unemploynment(hist_start_point+round) = max(0,100*(LaborSupplied-LaborDemanded)/LaborSupplied);

            % Randomly assign labor
            [ HouseholdFirm ] = assign_labor(obj.indx.HouseholdsActionsIndexes, obj.indx.FirmsActionsIndexes,obj.cfg);

            % Firms produce and labor wages and capital price get substracted from their budgets
            FirmsLabor=zeros(obj.cfg.n_firms,1);
            FirmsProduction=zeros(obj.cfg.n_firms,1);
            FirmsInterest=zeros(obj.cfg.n_firms,1);
            FirmsCosts=zeros(obj.cfg.n_firms,1);
            for firm_index =1:obj.cfg.n_firms
                FirmsLabor(firm_index)=numel(HouseholdFirm(HouseholdFirm==firm_index));
                FirmsCapital = (obj.economy.firms(firm_index).Budget-FirmsLabor(firm_index)*obj.cfg.Wage);
                % Cost of capital
                FirmsInterest(firm_index)=(1/obj.economy.Price_B-1)*FirmsCapital;
                if obj.cfg.cap == 0
                    % If we dont use capital for production
                    FirmsInterest(firm_index) = 0;
                    FirmsCapital = [];
                end
                % Produce
                FirmsProduction(firm_index)=Cobb_Douglas( obj.cfg.Technology,FirmsLabor(firm_index),FirmsCapital, obj.cfg.alpha );
                FirmsCosts(firm_index) = FirmsLabor(firm_index)*obj.cfg.Wage + FirmsInterest(firm_index);
            end

            %% Households consume and firms get payed
            Demand = (obj.cfg.ugrids_h{1}(obj.indx.HouseholdsActionsIndexes(:,1)) .* utils.BugetPropToVect(obj.economy.households,0)') / obj.economy.Price;

            if sum(Demand)<sum(FirmsProduction)
                Consumption = Demand;
                VolumeSold=FirmsProduction*(sum(Demand)/sum(FirmsProduction));
            elseif sum(Demand)>sum(FirmsProduction)
                Consumption = Demand * (sum(FirmsProduction)/sum(Demand));
                VolumeSold=FirmsProduction;
            else
                Consumption = Demand;
                VolumeSold=FirmsProduction;
            end

            % Calculate reward/utility
            FirmsProfit = VolumeSold*obj.economy.Price - FirmsCosts;
            obj.indx.FirmReward = FirmsProfit - obj.cfg.Cl_firm;
            obj.indx.Reward = Utility(Consumption, sign(HouseholdFirm)', obj.cfg);

            % Non-negative rewards
            obj.indx.Reward = max(obj.indx.Reward,0);
            obj.indx.FirmReward = max(obj.indx.FirmReward,0);

            % Get money for goods
            money_in_the_economy = 0;

            Dividends = zeros(obj.cfg.n_firms,1);
            for firm_indx = 1:obj.cfg.n_firms
                if FirmsProfit(firm_indx)>0 && obj.economy.firms(firm_indx).Budget + FirmsProfit(firm_indx) > obj.cfg.dividend_treshold
                    Dividends(firm_indx) = ( obj.economy.firms(firm_indx).Budget + FirmsProfit(firm_indx) - obj.cfg.dividend_treshold) * obj.cfg.dividend_ratio;
                end
                obj.economy.firms(firm_indx).NextBudget = obj.economy.firms(firm_indx).Budget + FirmsProfit(firm_indx) - Dividends(firm_indx);
                % No negative budgets
                obj.economy.firms(firm_indx).NextBudget = max(0,obj.economy.firms(firm_indx).NextBudget);
                money_in_the_economy=money_in_the_economy+obj.economy.firms(firm_indx).NextBudget;
            end

            % Pay for goods, get interest, wage and divideds an - household
            Dividend = sum(Dividends)/obj.cfg.n_households;
            for household_index=1:obj.cfg.n_households
                % Pay for goods
                obj.economy.households(household_index).NextBudget = obj.economy.households(household_index).Budget - obj.economy.Price * Consumption(household_index);

                % Colect interest
                obj.economy.households(household_index).NextBudget = obj.economy.households(household_index).NextBudget * (1/obj.economy.Price_B);

                % Get wage
                if HouseholdFirm(household_index)~=0
                    obj.economy.households(household_index).NextBudget=obj.economy.households(household_index).NextBudget+obj.cfg.Wage;
                end

                % Get dividend
                obj.economy.households(household_index).NextBudget = obj.economy.households(household_index).NextBudget + Dividend;

                % No negative budget - it should not be..
                if (obj.economy.households(household_index).NextBudget < 0)
                    obj.economy.households(household_index).NextBudget = 0;
                end

                % Manoey in the economy
                money_in_the_economy=money_in_the_economy+obj.economy.households(household_index).NextBudget;
            end

            % Technology growth
            obj.cfg.Technology = obj.cfg.Technology*(1+obj.cfg.TechnologyGrowth);

            % Add money to bacrupt firms and reset theta - i.e. create new
            % firms
            number_of_bncrp = 0;
            for firm = obj.economy.firms
                if(firm.Budget < 1)
                    firm.Budget = 0;
                    firm.NextBudget = 0;
                    if rand<=obj.cfg.firm_emerge_prob
                        firm.theta_lin = zero_field(firm.theta_lin);
                        firm.Budget = 5;
                        firm.NextBudget = 5;
                    end
                    number_of_bncrp = number_of_bncrp+1;
                end
            end

            % Set remaining hist values
            obj.hist.Labor(hist_start_point+round) = 100*( sum(obj.indx.HouseholdsActionsIndexes(:,2)-1)/obj.cfg.n_households);
            obj.hist.Consumption(hist_start_point+round)=sum(Consumption);
            obj.hist.Price(hist_start_point+round)=obj.economy.Price;
            obj.hist.Technology(hist_start_point+round)=obj.cfg.Technology;
            if hist_start_point>1 || round>1
                obj.hist.Inflation(hist_start_point+round)=100*((obj.hist.Price(hist_start_point+round) - obj.hist.Price(hist_start_point+round-1))/obj.hist.Price(hist_start_point+round-1));
            end
            obj.hist.Money(hist_start_point+round) = money_in_the_economy;
            obj.hist.BondPrice(hist_start_point+round)  = obj.economy.Price_B;
            

        end

        function obj = run(obj,n_rounds)
            % Realocate arrays for storing historical values
            hist_start_point = numel(obj.hist.Price);
            obj.hist.Consumption=[obj.hist.Consumption zeros(1,n_rounds)];
            obj.hist.Money=[obj.hist.Money zeros(1,n_rounds)];
            obj.hist.Unemploynment=[obj.hist.Unemploynment zeros(1,n_rounds)];
            obj.hist.Price=[obj.hist.Price zeros(1,n_rounds)];
            obj.hist.Inflation=[obj.hist.Inflation zeros(1,n_rounds)];
            obj.hist.Technology=[obj.hist.Technology zeros(1,n_rounds)];
            obj.hist.Labor=[obj.hist.Labor zeros(1,n_rounds)];
            obj.hist.BondPrice=[obj.hist.BondPrice zeros(1,n_rounds)];
            
            % Run simulation
            for round=1:n_rounds
                obj.step(hist_start_point, round)
            end

        end
    end
end