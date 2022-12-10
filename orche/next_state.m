function [economy] = next_state(economy)
    economy.Price = economy.Next_Price;
    economy.Price_B = economy.Next_Price_B;
    for firm = economy.firms
        firm.Budget = firm.NextBudget;
    end

    for household = economy.households
        household.Budget = household.NextBudget;
    end
end