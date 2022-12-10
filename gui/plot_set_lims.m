function [] = plot_set_lims(mw, hist_start_point,n_rounds)
    mw.Price.XLim = [0 hist_start_point + n_rounds];
    mw.Consumption.XLim = [0 hist_start_point + n_rounds];
    mw.Unemploynment.XLim = [0 hist_start_point + n_rounds];
    mw.Technology.XLim = [0 hist_start_point + n_rounds];
    mw.MoneySupply.XLim = [0 hist_start_point + n_rounds];
    mw.Labor.XLim = [0 hist_start_point + n_rounds];
end