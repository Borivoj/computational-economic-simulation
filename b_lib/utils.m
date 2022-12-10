classdef utils
    %% Various utility functions for simulation
    methods(Static)
        function EqWage = euqilibrium_wage(inputArg1,inputArg2)
            % Not finished
            FirstTerm=((cfg.utilsigma+cfg.utilphi)/(cfg.utilsigma*(1+cfg.alpha)+cfg.utilphi+cfg.alpha));
            SecondTerm=((cfg.utilsigma*(1-cfg.alpha)+cfg.utilphi)*log(1-cfg.alpha))/((cfg.utilsigma*(1-cfg.alpha)+cfg.utilphi+cfg.alpha));
            EqWage=Technology * FirstTerm + SecondTerm; 
        end
        
        function Budget = BugetPropToVect(agents, Next)
            Budget = zeros(numel(agents), 1);
            for agent_index = 1:numel(agents)
                if Next
                    Budget(agent_index) = agents(agent_index).NextBudget;
                else
                    Budget(agent_index) = agents(agent_index).Budget;
                end
            end
        end
        
    end
end

