function [ zeroed ] = zero_field( field_to_zero )
    dimensions = size(field_to_zero);
    zeroed = field_to_zero;
    if numel(dimensions)<=2
        zeroed = zeros(dimensions(1), dimensions(2));
    elseif numel(dimensions) == 3
        for indx = 1:dimensions(3)
           zeroed(:,:,indx) = zeros(dimensions(1), dimensions(2));  
        end
    else
        for indx = 1:dimensions(3)
            for indx2 = 1:dimensions(4)
                zeroed(:,:,indx, indx2) = zeros(1,dimensions(1), dimensions(2));
            end
        end
    end
end

