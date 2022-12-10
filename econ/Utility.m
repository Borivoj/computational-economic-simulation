function [util] = Utility(Consumption,HoursWorked,cfg)
    if size(Consumption,1)~=size(HoursWorked,1)
        error('Utility: dimension miscmatch');
    end
    util = (1/(1-cfg.sigma))*(Consumption.^(1-cfg.sigma))-(1/(1+cfg.rho))*(HoursWorked.^(1+cfg.rho))-cfg.Cl;%sqrt(Consumption)
end