ACOUSTIC2DPML is a MATLAB package for performing the 2-D frequency-domain acoustic wavefield simulations. Both the conventional 9-point (Jo et al.,1996) and recently developed 17-point (Cao and Chen, 2012) finite-difference schemes are used with the optimized CFS-PML boundary condition. 

Note that the paper for the 17-point scheme presented by Cao and Chen (2012) was originally written in Chinese. In this package, we have implemented the 17-point scheme using MATLAB with our optimized CFS-PML boundary. The readers interested are referred to our paper for GEOPHYSICS for details.

See following references for details of the finite-difference schemes used.
  *Jo, C.-H., Shin, J.-H., and Suh, J.-H., 1996, An optimal 9-point finite-difference frequency-space 2-D Scalar wave extrapolator, Geophysics, 61(2),529-537.
  *Cao, S.-H., and Chen, J.-B, 2012, A 17-point scheme and its numerical implementation for high-accuracy modeling of frequency-domain acoustic equation, Chinese Journal of Geophysics (in Chinese), 55(10), 3440-3449.

1. BRIEF CODE DESCRIPTION
The file acoustic2dpml.m in the subfolder /SourceCode is for the main program for running this code.

*Input files and output results:
See the file 'Readme.txt' in the subfolder /Examples for details.

2. SUBFOLDERS DESCRIPTION:
2.1 /SourceCode
This folder includes all the source codes written in MATLAB.

2.2 /Examples
This folder includes the homogeneous, Overthrust and Marmousi2 model tests and related figures for this study.

3. USAGE DECLARATION
ACOUSTIC2DPML is distributed for ONLY academic use but WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. You should have a GNU license or the SEG disclaimer.txt file within this package.  See the GNU license and https://software.seg.org/disclaimer.txt for more details.

External package(s) used:
The plotting file wigb.m is distributed freely for academic use and it can be found at: https://github.com/nicklinyi/seismic_utils/blob/master/wigb.m

The balance_trace.m file in the subfolder /Examples/Marmousi2/Seismograms for balancing traces is written by Yutao Liu:
Yutao LIU
Science & Technology on Integrated Information System Laboratory, Institute of Software, Chinese Academy of Sciences, Beijing, China
E-mail:  yutao_liu2022@163.com

If you show related results in a paper or presentation using ACOUSTIC2DPML, please give a reference to the following papers:

Wen Lei, Yutao Liu, Gang Li*, Shuang Zhu and Guoxin Chen. 2D FREQUENCY-DOMAIN FINITE-DIFFERENCE ACOUSTIC WAVE MODELING USING OPTIMIZED PERFECTLY MATCHED LAYERS. Geophysics, 2022, under review.

If you have any questions, please contact the developers:
Wen LEI and Dr. Gang LI*
Department of Marine Sciences, Zhejiang University
E-mail:  gangli@zju.edu.cn or ligang0309@gmail.com.

