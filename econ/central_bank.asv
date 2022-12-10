function [Next_Price_B] = central_bank(Price_B,PriceHist, one_round_target)
% Increase decreaes by 5 * 10^-3
    i = [0 diff(PriceHist)]./PriceHist;
    mean_i = mean(i(2:end));
    
    if mean_i < one_round_target + 0.0000001
        Next_Price_B = min(0.9995,Price_B+0.0005);
    elseif  mean_i > one_round_target - 0.0000001 
        Next_Price_B = max(0.95, Price_B-0.0005);
    else
        Next_Price_B = Price_B;
    end
end