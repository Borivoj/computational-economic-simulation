function [ change_indices ] = zeros_line_cross_ind( Diff )
    change_indices = find(Diff(1:end-1).*Diff(2:end)<=0);
end

