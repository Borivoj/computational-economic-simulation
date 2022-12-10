function [xgrids_a] = n_dense_cell(xgrids_a,n)
    for state_var_indx = 1:numel(xgrids_a)
        xgrids_a{state_var_indx}=n_dense(xgrids_a{state_var_indx},n);
    end
end