function [] = ini_ax_settings(mw)
    mw.Consumption.XLim = [0 100];
    mw.Consumption.YLim = [0 1000];
    
    mw.Unemploynment.YLim = [0 100];
    mw.Unemploynment.XLim = [0 100];
    
    mw.Price.XLim = [0 100];
    mw.Price.YLim = [0 1];
    
%    mw.Technology.XLim = [0 100];
%    mw.Technology.YLim = [0 10];
    
    mw.MoneySupply.XLim = [0 100];
    mw.MoneySupply.YLim = [0 400];
    
    mw.Labor.XLim = [0 100];
    mw.Labor.YLim = [0 100];
end