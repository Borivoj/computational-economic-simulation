# Computational economic simulation based on RBC model with Q-learning agents
An economic simulation presented in paper [Reinforcement Learning Induced Non-Neutrality of Monetary Policy in Computational Economic Simulation](https://ssrn.com/abstract=4325511)
<br>
For ease of use includes GUI and can run on any computer with MATLAB.
# Abstract
In a Real Business Cycle model, monetary shock does not affect real variables, and economic
agents are assumed to understand the model’s structure. This article shows how it is possible
to build a macroeconomic agent-based simulation from standard textbook Real Business
Cycle model and how to utilize reinforcement learning to drive agents’ decision making. The
reinforcement learning algorithm of choice in this article is Q-learning, extended with fuzzy
approximation. Q-learning is a simple algorithm based on incremental updates of estimated
future rewards. As such, it circumvents introducing black boxes into the simulation and
does not require strong assumptions on economic agents’ rationality and expectations. This
simulation falls into Real Business Cycle model category, but the reinforcement learning
driven decision making mechanism of economic agents causes monetary policy to be non-
neutral in the short run.

# Installation

Download this repository into a folder on your local drive. Download Approximate RL and DP toolbox from http://busoniu.net/repository.php and extract it into ./contrib directory.

Open file simulation.m in MATLAB and run it. When prompted, change the working directory.
A GUI window should appear. Click "Run" in the right bottom corner to start the simulation.

You can change various parameters of the simulation, either in GUI (click "Apply" after making a change) or by modifying setup.m file.

Tested with MATLAB 2021b (debian 11 - amd64) and 2022a (maci64)
