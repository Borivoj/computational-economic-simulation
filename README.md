# Computational economic simulation based on RBC model with Q-learning agents
An agent-based computational simulation is built around a textbook RBC model. The model structure is taken from chapter 2 of Monetary policy, inflation, and the business cycle by Jordi Galí. The simulation is composed of interacting firms and households whose decision-making is driven by the Reinforcement learning algorithm, specificaly Q-learning (extended with fuzzy approximation).
# Installation

Download this repository into a folder on you local drive. Download Approximate RL and DP toolbox from http://busoniu.net/repository.php and extract it into ./contrib directory.

Open file simulation.m in MATLAB and run it. When propted to change working directory, click yes.
A GUI window should appear. Click "Run" in the right bottom corner to start the simulation.

You can change various parameters of the simulation, either in GUI (click "Apply" after making a chnage) or by modifying setup.m file.

Tested with MATLAB 2021b (debian 11 - amd64) and 2022a (maci64)
