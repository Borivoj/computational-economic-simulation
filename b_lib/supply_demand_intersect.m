function [ Price ] = supply_demand_intersect( Supply, Demand, c, n)
    %c=cfg.xgrids_h{1};
    %n=cfg.DIMS_h.dimx(1);
    i = find(Supply - Demand<=0, 1, 'last');
    % when it changes??? ale takhle je to asi docela rozumne
    if i==n
       i = find(Supply - Demand>=0, 1, 'last'); 
    end
    
    if not(isempty(i))
        if i < n,
            iv = [i;  i+1];
        else             
            iv = [i-1;  i];
        end

        ind=iv;

        SDDiff = [Supply - Demand ];

        slope = (SDDiff(ind(2))-SDDiff(ind(1)))/(c(ind(2))-c(ind(1)));
        intercept = SDDiff(ind(1))-c(ind(1))*slope;

        Price = -(intercept/slope);
        if abs(Price*slope+intercept)>10^(-10)
            error('Wrong price')
        end
    else
       if max(Supply)>max(Demand)
          Price = c(1);
       else
          Price = c(end);
       end
    end
    
    
end

