%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
function xxx=plotimage(trace,x,z,h)
[xx zz]=meshgrid(x,z);xx=xx*h;zz=zz*h;
pcolor(xx,zz,trace)
% set(gca, 'YDir', 'reverse','XAxisLocation', 'top')
set(gca, 'YDir', 'reverse')
shading interp
colormap cool