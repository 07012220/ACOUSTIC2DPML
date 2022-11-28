%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
clc;
clear all;
%% Input

load('Homo.mat');

h9=10; h17=15; nxe17=100; nze17=100; dt=1/160; nt=256;
y_axis=0:dt:dt*(nt-1);

%% seismograms

%%PML
figure(5)
subplot(2,1,1)
x=0:nxe-1;z=0:nze-1;plotimage(real(xx(1:nze,1:nxe)),x,z,h);
colormap autumn;
ylabel('z (m)','FontSize', [14],'FontWeight','bold');
xticks(0:300:1700);yticks(0:300:1700);
set(gca,'Position',[0.13 0.59 0.201 0.4]);
set(gca,'FontSize',14,'FontWeight','bold');


subplot(2,1,2)
x=0:nxe17-1;z=0:nze17-1;plotimage(real(xx17(1:nze17,1:nxe17)),x,z,h17);
colormap autumn;
xlabel('x (m)','FontSize', [14],'FontWeight','bold'); ylabel('z (m)','FontSize', [14],'FontWeight','bold');
xticks(0:300:1500);yticks(0:300:1500);
set(gca,'Position',[0.1422 0.185 0.178 0.354]);
set(gca,'FontSize',14,'FontWeight','bold');


%%  single trace


%%Improved CFS-PML
figure (6)
subplot(2,1,1)
x=0:nxe-1;z=0:nze-1;plotimage(real(xx1(1:nze,1:nxe)),x,z,h); 
caxis([-2.692 5]);
xticks(0:300:1700);yticks(0:300:1700);
ylabel('z (m)','FontSize', [14],'FontWeight','bold');
set(gca,'Position',[0.13 0.59 0.201 0.4]);
set(gca,'FontSize',14,'FontWeight','bold');

subplot(2,1,2)
x=0:nxe17-1;z=0:nze17-1;plotimage(real(xx117(1:nze17,1:nxe17)),x,z,h17); 
caxis([-2.692 5]);
xlabel('x (m)','FontSize', [14],'FontWeight','bold'); ylabel('z (m)','FontSize', [14],'FontWeight','bold');
xticks(0:300:1700);yticks(0:300:1700);
set(gca,'Position',[0.1422 0.185 0.178 0.354]);
set(gca,'FontSize',14,'FontWeight','bold');




