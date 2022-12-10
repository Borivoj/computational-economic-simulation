function [] = update_q_t( agents, cfg, ActionsIndexes, State, Next_State, Rewards)
    if cfg.q_algo_type == 1 % moving discretization points
        for agent_index = 1:numel(agents)
            agents(agent_index).update_q_lin(State, ActionsIndexes(agent_index,:), Next_State, Rewards(agent_index), cfg); 
        end
    elseif cfg.q_algo_type == 2 % learning rate adjustment
        for agent_index = 1:numel(agents)
            agents(agent_index).update_q_lin_l(State, ActionsIndexes(agent_index,:), Next_State, Rewards(agent_index), cfg); 
        end
    elseif cfg.q_algo_type == 3 % delta adjustment
        for agent_index = 1:numel(agents)
            agents(agent_index).update_q_lin_delta(State, ActionsIndexes(agent_index,:), Next_State, Rewards(agent_index), cfg); 
        end
    end
end

