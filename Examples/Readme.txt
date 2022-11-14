This is for the homogeneous, Overthrust and Marmousi2 model tests and related figures.

***RUNNING DESCRIPTION
1) Parameter settings
For example, for the homogenous model test, the file "para9_optimizedCFSPML.txt" in the subfolder "/acoustic2dpml/Examples/Homogeneous/Inputs" is for setting parameters required for running this test using the 9-point scheme with our optimized CFS-PML boundary conditions. 
  >The first parameter is the number of grid nodes in the x- direction.
  >The second parameter is the number of grid nodes in the z- direction.
  >The third parameter is the number of absorption layers in the x- direction.
  >The fourth parameter is the number of absorption layers in the z- direction.
  >The fifth parameter is the gridding interval (i.e., the spatial sampling interval).
  >The sixth parameter is for setting the type of the finite difference schemes used, 
    and 0 and 1 are for 9- and17-point finite-difference schemes, respectively;
  >The seventh parameter is for setting the type of absorbing boundaries, 
    and 0, 1, and 2 are for the conventional PML, the CFS-PML and our optimized CFS-PML, respectively;
  >The eighth parameter is the frequency slice interval;

Input files for running tests using different finite-difference schemes with different boundary conditions are referred to:
  > "para9_PML.txt":                        9-pont scheme, the conventional PML;            
  > "para9_CFSPML.txt":                  9-pont scheme, the CFS-PML;
  > "para9_optimizedCFSPML.txt":   9-pont scheme, the optimized CFS-PML; 
  > "para17_PML.txt":                      17-pont scheme, the conventional PML;            
  > "para17_CFSPML.txt":                17-pont scheme, the CFS-PML;
  > "para17_optimizedCFSPML.txt": 17-pont scheme, the optimized CFS-PML; 

2) Velocity file(s)
The file "Homo.mesh" is the mesh file for the homogenous model.

***RESULTS AND PLOTTING
The output and plotting files are can be found in the subfolders such as “/Examples/Homogeneous/Seismograms” or “/Examples/Homogeneous/Snapshots” and the users are referred to the "Readme.txt" file inside for details.
