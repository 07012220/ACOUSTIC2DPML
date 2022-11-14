%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
function xxx=plotimage(trace,x,z,h)
[xx zz]=meshgrid(x,z);%xx=xx*h;zz=zz*h;

pcolor(xx,zz,trace)
% set(gca, 'YDir', 'reverse','XAxisLocation', 'top')
% set(gca, 'YDir', 'reverse')
shading interp
colormap gray
 caxis([-0.7 1.2]);
 xticks(0:100:901);yticks(0:0.2:1.6);
% xlim([0 900]);ylim([0 1.6]);
 set(gca,'YDir','reverse');