function [] = plot_sim(axes1,Var_p,intervals, impulse_title, y_limit, x_limit)
    previous_upper = [];
    previous_lower = [];
    for interval = flip(intervals,2)
        upper = quantile(Var_p,0.5+interval/2);
        lower = quantile(Var_p,0.5-interval/2);
        x=find(abs(upper-lower)>0.0000001);
        %if (min(x))<2
        %    x=2:size(Var_p,2);
        %else
        %    x=[x(1)-1 x];
        %end
        
        if (isempty(previous_lower))
            fill(axes1,[x-1  flip(x)-1],[lower(x) flip(upper(x),2)],[12.8 46.9 0]/255,'FaceAlpha',(1-interval),'LineStyle','none','DisplayName',strcat(string(interval*100), '%'));
        else 
            fill(axes1,[x-1  flip(x)-1],[previous_upper(x) flip(upper(x),2)],[12.8 46.9 0]/255,'FaceAlpha',(1-interval),'LineStyle','none','DisplayName',strcat(string(interval*100), '%'));
            abd=fill(axes1,[x-1  flip(x)-1],[previous_lower(x) flip(lower(x),2)],[12.8 46.9 0]/255,'FaceAlpha',(1-interval),'LineStyle','none');
            abd.Annotation.LegendInformation.IconDisplayStyle='off';
        end
        hold on
        previous_lower=lower;
        previous_upper=upper;
    end
    abd = plot(axes1,[0:(size(Var_p,2)-1)] ,quantile(Var_p,0.5), 'Color','white', 'LineWidth',3);%plot(axes1,[0:(x(1)-2) x-1],quantile(Var_p,0.5), 'Color','white', 'LineWidth',3);
    abd.Annotation.LegendInformation.IconDisplayStyle='off';
    plot(axes1,[0:(size(Var_p,2)-1)],quantile(Var_p,0.5), 'DisplayName','Mean', 'Color','black', 'LineWidth',2);%plot(axes1,[0:(x(1)-2) x-1],quantile(Var_p,0.5), 'DisplayName','Mean', 'Color','black', 'LineWidth',2);
    
    ylim(axes1,y_limit);
    if isempty(x_limit)
        xlim(axes1,[min([0:(x(1)-2) x-1]) max([0:(x(1)-2) x-1])]);
    else 
        xlim(axes1,x_limit);
    end
    
    set(axes1,'FontSize',12,'XGrid','on','YGrid','on');
    legend1 = legend(axes1,'show');
    set(legend1,'Orientation','horizontal','Location','southoutside',...
        'FontSize',12,...
        'EdgeColor','none');
    % Create ylabel
    ylabel(impulse_title);

    xlabel('$t$','interpreter','latex')
    % Create title
    
    %title(impulse_title);

end