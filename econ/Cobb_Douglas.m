function [ Prod ] = Cobb_Douglas( Technology,Labor,Capital, alpha )
    if isempty(Capital)
        Prod = Technology * (Labor.^(1-alpha));
    else
        Prod = Technology * (Labor.^(1-alpha)) .* (Capital.^(alpha));
    end
end

