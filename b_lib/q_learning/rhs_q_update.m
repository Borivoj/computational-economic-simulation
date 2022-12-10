function [ q ] = rhs_q_update( Reward, estimate_now, max_next_estimates, cfg )
    q = (1-cfg.Learning_rate)*( estimate_now ) + cfg.Learning_rate*( Reward + cfg.gamma * max_next_estimates );
end

