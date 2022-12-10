function [one] = linSubset(u_subset,dimu)
    one = ndiSubset(u_subset, dimu);
    one = sort(ndi2lin(one, dimu));
end