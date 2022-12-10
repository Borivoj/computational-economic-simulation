classdef firm < agent

    methods
        function obj = firm(cfg)
            obj.xgrids = cfg.xgrids_f;
            obj.ugrids = cfg.ugrids_f;
            obj.dimx = cfg.DIMS_f.dimx;
            obj.dimu = cfg.DIMS_f.dimu;
            obj.p = cfg.DIMS_f.p;
            obj.q = length(cfg.ugrids_f);
            obj.N = prod(obj.dimx);
            obj.M = prod(obj.dimu);
            obj.tab = dec2base(0:(2^obj.p-1), 2) - 47;
            obj.theta_lin = zeros(obj.N,obj.M);
            obj.Budget = 0;
        end

        function [u_subset] = BudgetSubset(obj,cfg, Price, Budget)
            u_subset = find(cfg.ugrids_h{1}*cfg.maxLabor*cfg.Wage<=Budget);
            u_subset = linSubset(u_subset, obj.dimu);
        end
        
    end
end
