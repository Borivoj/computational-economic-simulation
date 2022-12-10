% Before running this file, download Approximate RL and DP toolbox from http://busoniu.net/repository.php
% and extract it into ./contrib directory.
% Set forder containing this file as working directory.
% Tested with MATLAB 2021b (debian 11 - amd64) and 2022a (maci64)
addpath(genpath('orche'));
addpath(genpath('b_lib'));
addpath(genpath('contrib'));
addpath(genpath('econ'));
addpath(genpath('gui'));

mw = main_window();

ini_ax_settings(mw);