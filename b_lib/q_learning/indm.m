function [ind, mu] = indm(x,c,n,p)
    %  Parameters:
    %   X           - p-dimensional vector of state variable
    %   C           - centers of fuzzy sets
    %   N           - number of fuzzy sets
    %   P           - number of variable dimensions
    mu=zeros(2,p);
    ind=zeros(2,p);
    for ip = 1:1:p
        i = find(c{ip} <= x(ip), 1, 'last');
        if i < n(ip),
            m  = (c{ip}(i+1) - x(ip)) / (c{ip}(i+1) - c{ip}(i));
            mv = [m;  1-m];
            iv = [i;  i+1];
        else                    
            mv = [  0;  1];
            iv = [i-1;  i];
        end
        ind(:,ip)=iv;
        mu(:, ip)  = mv;
    end
end