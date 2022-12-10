function [one] = ndiSubset(u_subset,dimu)
    if (size(u_subset,1) == 1)
        one = u_subset';
    else
        one = u_subset;
    end
    one = sort(one,1);
    for disc_point_num = dimu(2:end)
        one = [ repmat(one,disc_point_num,1) sort(repmat((1:disc_point_num)',size(one,1),1),1)];
    end
end