classdef plot_int
    methods (Static)
        function [] = price(axes_l,Data, xlimits)
            intervals = [90,70,50,30]/100;
            plot_sim_sub(axes_l,Data,intervals, '', [0 1], xlimits,[]);
            axes_l.XLim = xlimits;
        end
        function [] = consumption(axes_l,Data, xlimits)
            intervals = [90,70,50,30]/100;
            plot_sim_sub(axes_l,Data,intervals, '', [0 max(max(Data))], xlimits,[15 49 102]/255);
            axes_l.XLim = xlimits;
        end
        function [] = money(axes_l,Data, xlimits)
            intervals = [90,70,50,30]/100;
            plot_sim_sub(axes_l,Data,intervals, '', [0 max(max(Data))], xlimits,[102 17 12]/255);
            axes_l.XLim = xlimits;
        end
        function [] = unempl(axes_l,Data, xlimits)
            intervals = [90,70,50,30]/100;
            plot_sim_sub(axes_l,Data,intervals, '', [0 max(1,max(max(Data)))], xlimits,[102 99 15]/255);
            axes_l.XLim = xlimits;
        end
        function [] = labor(axes_l,Data, xlimits)
            intervals = [90,70,50,30]/100;
            plot_sim_sub(axes_l,Data,intervals, '', [0 max(max(Data))], xlimits,[53 15 102]/255);
            axes_l.XLim = xlimits;
        end
    end
end