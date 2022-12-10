classdef household < agent
    methods
        function obj = household(cfg)
            obj.xgrids = cfg.xgrids_h;
            obj.ugrids = cfg.ugrids_h;
            obj.dimx = cfg.DIMS_h.dimx;
            obj.dimu = cfg.DIMS_h.dimu;
            obj.p = cfg.DIMS_h.p;
            obj.q = length(cfg.ugrids_h);
            obj.N = prod(obj.dimx);
            obj.M = prod(obj.dimu);
            obj.tab = dec2base(0:(2^obj.p-1), 2) - 47;
            obj.theta_lin = zeros(obj.N,obj.M);
            obj.Budget = 0;
        end
        function [u_subset] = BudgetSubset(obj,cfg, Price, Budget)
            u_subset = 1:numel(cfg.ugrids_h{1});%find(cfg.ugrids_h{1}*cfg.maxGoods*Price<=Budget);
            u_subset = linSubset(u_subset, obj.dimu);
        end

        
    end
end

