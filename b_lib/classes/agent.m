classdef agent < handle
    properties
        theta_lin
        xgrids
        ugrids
        dimx %
        dimu %
        p %
        q %
        N %
        M %
        tab %
        Budget
        NextBudget
    end
    methods
        function [ind, mu, indp]  = mdegs_p_a(obj, State)
            [ind, mu, indp]  = mdegs_p(State, obj.xgrids,[] , obj.dimx, obj.p, obj.tab);
        end

        function [ActionEstimates] = action_estimates(obj, State)
            
            [ind, mu, indp]  = obj.mdegs_p_a(State);
            
            ActionEstimates = mu' * obj.theta_lin(ind, :);
        end

        function [u_subset] = BudgetSubset(~)
            error('Agent class cant be used directly. If you want to inherit from it, you need to implement BudgetSubset method.');
        end

        function [Action] = action(obj, State, cfg, Next)
            if Next
                SBudget = obj.NextBudget;
            else
                SBudget = obj.Budget;
            end
            
            State = [State,SBudget];
            
            Price = State(1);
            u_subset = obj.BudgetSubset(cfg, Price, SBudget);

            % Author: Lucian Busoniu
            [ind, mu, indp]  = obj.mdegs_p_a(State);

            ActionEstimates = mu' * obj.theta_lin(ind, :);

            ui = find(ActionEstimates(u_subset) == max(ActionEstimates(u_subset)));
            
            ui = ui(ceil(rand * length(ui)));
            ui = u_subset(ui);
            Action = lin2ndi(ui, obj.dimu);
        end
        function [Action] = action_no_rand(obj, State, cfg, Next, min)
            if Next
                SBudget = obj.NextBudget;
            else
                SBudget = obj.Budget;
            end
            
            State = [State,SBudget];
            
            Price = State(1);
            u_subset = obj.BudgetSubset(cfg, Price, SBudget);

            % Author: Lucian Busoniu
            [ind, mu, indp]  = obj.mdegs_p_a(State);

            ActionEstimates = mu' * obj.theta_lin(ind, :);

            if min
                ui = find(ActionEstimates(u_subset) == max(ActionEstimates(u_subset)),1,'first');
            else
                ui = find(ActionEstimates(u_subset) == max(ActionEstimates(u_subset)),1,'last');
            end


            ui = u_subset(ui);
            Action = lin2ndi(ui, obj.dimu);
        end
        function [Action] = action_no_subset(obj, State, Next)
            if Next
                SBudget = obj.NextBudget;
            else
                SBudget =obj.Budget;
            end
            
            State = [State,SBudget];

            % Author: Lucian Busoniu
            [ind, mu, indp]  = obj.mdegs_p_a(State);
            ActionEstimates = mu' * obj.theta_lin(ind, :);
            ui = find(ActionEstimates == max(ActionEstimates));
            ui = ui(ceil(rand * length(ui)));
            Action = lin2ndi(ui, obj.dimu);
        end

        %% Q-learning testing functions
        function [Action] = action_no_rand_no_subset(obj, State, cfg, Next, min)
            if Next
                SBudget = obj.NextBudget;
            else
                SBudget = obj.Budget;
            end
            
            State = [State,SBudget];
            
            Price = State(1);
            
            % Author: Lucian Busoniu
            [ind, mu, indp]  = obj.mdegs_p_a(State);

            ActionEstimates = mu' * obj.theta_lin(ind, :);

            if min
                ui = find(ActionEstimates == max(ActionEstimates),1,'first');
            else
                ui = find(ActionEstimates == max(ActionEstimates),1,'last');
            end

            Action = lin2ndi(ui, obj.dimu);
        end

        %% Q-estimate update functions

        function [] = update_q_lin_l(obj, State, Action, NextState, Reward, cfg)
            % Learning rate adjustment
            Action_lin = ndi2lin(Action,obj.dimu);
            NextState = [NextState, obj.NextBudget];
            [NextActionEstimates] = obj.action_estimates(NextState);
            State = [State, obj.Budget];
            [ind, mu, indp]  = obj.mdegs_p_a(State);
            % with special l
            l = mu * cfg.Learning_rate;
            obj.theta_lin(ind, Action_lin) = (1-l).*obj.theta_lin(ind, Action_lin) + l.*( Reward + cfg.gamma * max(NextActionEstimates) );
        end
        
        function [] = update_q_lin_delta(obj, State, Action, NextState, Reward, cfg)
            Action_lin = ndi2lin(Action,obj.dimu);
            
            NextState = [NextState, obj.NextBudget];
            [NextActionEstimates] = obj.action_estimates(NextState);
            State = [State, obj.Budget];
            [ind, mu, indp]  = obj.mdegs_p_a(State);
            %% Estimate now part
            current_estimates = obj.action_estimates( State );
            if isa(obj,'household')
                a=111;
            end
            delta = (Reward + cfg.gamma * max(NextActionEstimates)) - current_estimates(Action_lin);
            
            delta_theta = (mu).*delta;
            %delta_theta = zeros(numel(mu),1)+delta;
            if abs(sum(mu)-1)>0.00001
                error('etf');
            end
            obj.theta_lin(ind, Action_lin) = obj.theta_lin(ind, Action_lin) +cfg.Learning_rate * (delta_theta);   
        end

        
        function [] = update_q_lin(obj, State, Action, NextState, Reward, cfg)
            % Moving descretization points
            Action_lin = ndi2lin(Action,obj.dimu);
            
            NextState = [NextState, obj.NextBudget];
            
            [NextActionEstimates] = obj.action_estimates(NextState);
            
            State = [State, obj.Budget];

            current_estimates = obj.action_estimates( State );
            
            estimate_now = current_estimates(Action_lin);

            state_theta_indx = zeros(1,obj.p);
            for ip = 1:obj.p
                if abs(State(ip) - obj.xgrids{ip}(1)) < 0.001
                    state_theta_indx(ip) = 1;
                elseif abs(State(ip) - obj.xgrids{ip}(end)) < 0.001
                    state_theta_indx(ip) = numel(obj.xgrids{ip});
                else
                    [val, indx] = min(abs(obj.xgrids{ip}(2:end-1)-State(ip)));
                    state_theta_indx(ip) = indx+1;
                    obj.xgrids{ip}(state_theta_indx(ip))=State(ip);
                end
            end
            State_lin = ndi2lin(state_theta_indx,obj.dimx);

            obj.theta_lin(State_lin,Action_lin) = rhs_q_update( Reward, estimate_now, max(NextActionEstimates), cfg );
        end
    end
end
