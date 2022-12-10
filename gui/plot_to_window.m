function [] = plot_to_window(mw,hist,hist_start_point, round)
        % Price
        plot(mw.Price,hist.Price(1:(hist_start_point+round)),'LineWidth',1);
        % Consumption
        if mw.Consumption.YLim(2)<hist.Consumption(hist_start_point+round)
            mw.Consumption.YLim(2)=ceil(hist.Consumption(hist_start_point+round)/100)*100;
        end
        plot(mw.Consumption,hist.Consumption(1:(hist_start_point+round)),'LineWidth',1);
        % Unemplynment rate
        plot(mw.Unemploynment,hist.Unemploynment(1:(hist_start_point+round)),'LineWidth',1);
        % Technolgy growth
        plot(mw.Technology,hist.Technology(1:(hist_start_point+round)),'LineWidth',1);    
        if mw.Technology.YLim(2)<hist.Technology(hist_start_point+round)
            mw.Technology.YLim(2)=ceil(hist.Technology(hist_start_point+round)/100)*100;
        end
        % Money supply
        plot(mw.MoneySupply,hist.Money(1:(hist_start_point+round)),'LineWidth',1);
        if mw.MoneySupply.YLim(2)<hist.Money(hist_start_point+round)
            mw.MoneySupply.YLim(2)=ceil(hist.Money(hist_start_point+round)/100)*100;
        end

        % Labor participation
        plot(mw.Labor,hist.Labor(1:(hist_start_point+round)),'LineWidth',1);
        pause(0.001);
end