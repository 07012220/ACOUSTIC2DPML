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
% set(gca, 'YDir', 'reverse')
shading interp
colormap gray
 caxis([-0.39 0.7]);
 xticks(0:20000:68100);yticks(0:4:24);
 xlim([0 68000]);ylim([0 24]);
 set(gca,'YDir','reverse');