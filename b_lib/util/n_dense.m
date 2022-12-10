function [xgrids_x] = n_dense(xgrids_x,n)
    div = 0;
    while div<n
        xgrids_x_new = zeros(1,numel(xgrids_x)*2-1);
        for disc_point_indx = 1:(numel(xgrids_x)-1)
            xgrids_x_new(2*disc_point_indx)= (xgrids_x(disc_point_indx+1)+xgrids_x(disc_point_indx))/2;
            xgrids_x_new(2*disc_point_indx-1)= xgrids_x(disc_point_indx);
        end
        xgrids_x_new(end) = xgrids_x(end);
        xgrids_x = xgrids_x_new;
        div=div+1;
    end
end

