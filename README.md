# codes for DDGA

This is the code for the diffusion decomposition of Gaussian approximation (DDGA), an effective approximation approach for quantifying the landscape of oscillatory systems with varying dimensions.

The four folders correspond to the four figures in our article. If you are interested in the details, the codes in the four folders can help you reproduce the results of the four figures in our article. If you are only interested in our methods, files `./Figure3/land_DDGA.m` will serve as an example of the application of our methods in a 44-dimensional mammalian cell cycle network system, and help you understand how our methods work. File `./Figure4/Sensitivity_Analysis.m` will provide a sensitivity analysis for the parameters of 44-dimensional mammalian cell cycle network system, using the landscape obtained by DDGA.

For the latter purpose, run all the blocks in `./Figure3/land_DDGA.m` in order. For the former purpose, run all the blocks in `./Figure1/KL_limit3_Dchange_revised.m`,`./Figure2/Coherence_Fluxintloop_Repressilator.m`,`./Figure3/Gaussian_45_dim.m`,`./Figure3/land_DDGA.m`,`./Figure4/Sensitivity_Analysis.m` in order, separately. Also, the code in `./Figure3/cc45flux.nb` offers another format `.nb' in Mathematica, provided from [Li 2014 PNAS].

See details in the files.

