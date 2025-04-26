# Dissertation-Companion

This repository contains the necessary files to recreate and implement the simulation figures and algorithms in the doctoral dissertation "Modeling Bias in Decision-Making Attractor Networks" by Safaan Sadiq describing research from the years 2021-2025 at Pennsylvania State University in the Department of Mathematics.

1. Trajectory Graphs

The file "placeholder.m" is a function which takes as inputs the synapthic weights and external drive currents as parameters for a two-dimensional competitive TLN.  It generates a figure depicting a partition of the state space compatible with a trajectory graph as depicted in the figures of Chapter 2.

2. State Transition Graph

The folder "State_Transition_Graph_CTLN" contains the algorithm implementation which will output a state transition graph for the ReLU hyperplane and nullcline arrangement of a CTLN.  This is an application of Algorithm 1 of the dissertation to this particular hyperplane arrangement.  The main file for users is "stg_main.m" which requires an adjacency matrix for the CTLN graph and a choice of parameters.

3. Basins of attraction in the Neighborhood of Saddle Points

The datasets ".mat" and ".mat" are those used to create Fig. 5.2A and Fig 5.2B respectively using the "plotbasinfrac.m" function which takes as input the cell array of DAG adjacency matrices "sAlist", the cell array of sink indegrees "indeg", and the cell array of fractional sizes of the basins of attraction "basin_frac".  Fig 5.3 is obtained using ".mat" and by slightly modifying "plotbasinfrac.m" to only consider the DAGs with a particular number of sinks.

For new results, a list of DAGs can be generated using "sAlistgenerator.m".  Corresponding simulation results can be obtained using the files "brute_force.m" and "brute_force_full.m" which randomly sample initial conditions and numerically compute the relative sizes of the basins of attraction in the neighborhood of the saddle point and the state space as a whole respectively.

5. Balanced State Attractor Prediction

The implementation of Algorithm 2 is "bsalgo.m" which takes as an input an adjacency matrix for the DAG G.  To generate Fig. 6.8, use the program "placeholder.m".  Again, the file "sAlistgenerator.m" can be used to generate a list of DAGs of a particular size.
