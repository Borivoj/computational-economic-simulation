function [ Price ] = supply_demand_intersects( Supply, Demand, c)
    %c=cfg.xgrids_h{1};
    %n=cfg.DIMS_h.dimx(1);
    Diff = Supply - Demand;
    i = zeros_line_cross_ind(Diff);
    num_intersects = numel(i);
    Price = zeros(1, num_intersects);
    if not(isempty(i))
        intersect_counter=1;
        for intersect  = i
           Price(intersect_counter) = lin_intersect_with_zero( [c(intersect) Diff(intersect)], [c(intersect+1) Diff(intersect+1)] );
           intersect_counter = intersect_counter + 1;
        end
    else
       if max(Supply)>max(Demand)
          Price = c(1);
       else
          Price = c(end);
       end
    end
    
    
end

