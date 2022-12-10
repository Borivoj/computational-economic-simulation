function [ Prod ] = Cobb_Douglas_l( Technology,Labor, alpha )
    Prod = Technology * (Labor.^(1-alpha));
end

