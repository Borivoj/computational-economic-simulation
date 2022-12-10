function [] = plot_sim_sub(axes1,Var_p,intervals, impulse_title, y_limit, x_limit, fill_color)
    cla(axes1)
    if isempty(fill_color)
        fill_color = [12.8 46.9 0]/255;
    end
    previous_upper = [];
    previous_lower = [];
    for interval = flip(intervals,2)

        upper = quantile(Var_p,0.5+interval/2);
        lower = quantile(Var_p,0.5-interval/2);
        intervals_diff=find(abs(upper-lower)>0.0000001);
        x=2:numel(upper);
        if isempty(x)
            continue;
        end
        
        if (isempty(previous_lower))
            abd=fill(axes1,[x-1  flip(x)-1],[lower(x) flip(upper(x),2)],fill_color,'FaceAlpha',(1-interval),'LineStyle','none','DisplayName',strcat(string(interval*100), '%'));
        else 
            asd=fill(axes1,[x-1  flip(x)-1],[previous_upper(x) flip(upper(x),2)],fill_color,'FaceAlpha',(1-interval),'LineStyle','none','DisplayName',strcat(string(interval*100), '%'));
            abd=fill(axes1,[x-1  flip(x)-1],[previous_lower(x) flip(lower(x),2)],fill_color,'FaceAlpha',(1-interval),'LineStyle','none');
            abd.Annotation.LegendInformation.IconDisplayStyle='off';
        end
        if isempty(intervals_diff)
            abd.Annotation.LegendInformation.IconDisplayStyle='off';
            asd.Annotation.LegendInformation.IconDisplayStyle='off';

        end
        hold(axes1,'on')
        previous_lower=lower;
        previous_upper=upper;
    end
    abd = plot(axes1,[0:(size(Var_p,2)-1)] ,quantile(Var_p,0.5), 'Color','white', 'LineWidth',2);%plot(axes1,[0:(x(1)-2) x-1],quantile(Var_p,0.5), 'Color','white', 'LineWidth',3);
    abd.Annotation.LegendInformation.IconDisplayStyle='off';
    plot(axes1,[0:(size(Var_p,2)-1)],quantile(Var_p,0.5), 'DisplayName','Mean', 'Color','black', 'LineWidth',1);%plot(axes1,[0:(x(1)-2) x-1],quantile(Var_p,0.5), 'DisplayName','Mean', 'Color','black', 'LineWidth',2);
    
    ylim(axes1,y_limit);
    if isempty(x_limit)
        xlim(axes1,[min([0:(x(1)-2) x-1]) max([0:(x(1)-2) x-1])]);
    else 
        xlim(axes1,x_limit);
    end
    
    %set(axes1,'FontSize',14,'XGrid','on','YGrid','on');
    %legend1 = legend(axes1,'show');
    %set(legend1,'Orientation','horizontal','Location','southoutside',...
    %    'FontSize',12,...
    %    'EdgeColor','none', ...
    %    'NumColumns',3);
   
    %xlabel('$t$','interpreter','latex')
   

end