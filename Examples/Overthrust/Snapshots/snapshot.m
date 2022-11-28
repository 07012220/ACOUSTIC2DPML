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

load('Overthrust.mat');

h9=10; h17=10; nxe17=841; nze17=227;nx17=801; nz17=187;
npml117=20; npml217=20;
npml1=40; npml2=40;
 dt=1/98; nt=256;
%% frequency-domain snapshot

%%PML
figure(5)
subplot(2,1,1)
x=0:nxe-1;z=0:nze-1;
plotimage(real(xx(1:nze,1:nxe)),x,z,h);
colormap autumn;
ylabel('z (m)');
% xticks(0:1000:8810);yticks(0:200:2670);xlim([-1 8810]);ylim([-1 2670]);
xticks(0:1500:8810);yticks(0:450:2670);%xlim([-1 8810]);ylim([-1 2670]);
set(gca,'Position',[0.13 0.5838 0.6554 0.3412]);
set(gca,'FontSize',24,'FontWeight','bold');


subplot(2,1,2)
x=0:nxe17-1;z=0:nze17-1;
plotimage(real(xx17(1:nze17,1:nxe17)),x,z,h17);
colormap autumn;
xlabel('x (m)'); ylabel('z (m)');
xticks(0:1500:8410);yticks(0:480:2270);%xlim([-1 8410]);ylim([-1 2270]);
% xticks(0:1000:8410);yticks(0:200:2270);xlim([-1 8410]);ylim([-1 2270]);
set(gca,'Position',[0.147 0.2186 0.6252 0.3025]);
set(gca,'FontSize',24,'FontWeight','bold');



%%  time-domain snapshot

% plot(y_axis,real(y_ifft(1:256,(ceil(nx/3)))));
% xticks(0:0.2:1.6);xlim([0 1.6]);
% xlabel('Time/s','FontSize', [14]); ylabel('Normalized Solution','FontSize', [14]);set(gca,'FontSize',12);

%%Improved CFS-PML
figure (6)
subplot(2,1,1)
x=0:nxe-1;z=0:nze-1;
plotimage(real(xx1(1:nze,1:nxe)),x,z,h);
caxis([-2.692 5]);
ylabel('z (m)');
xticks(0:1500:8810);yticks(0:450:2670);%xlim([-1 8810]);ylim([-1 2670]);
set(gca,'Position',[0.13 0.5838 0.6554 0.3412]);
set(gca,'FontSize',24,'FontWeight','bold');



subplot(2,1,2)
x=0:nxe17-1;z=0:nze17-1;
plotimage(real(xx117(1:nze17,1:nxe17)),x,z,h17);
caxis([-2.692 5]);
xlabel('x (m)'); ylabel('z (m)');
xticks(0:1500:8410);yticks(0:480:2270);%xlim([-1 8410]);ylim([-1 2270]);
set(gca,'Position',[0.147 0.2186 0.6252 0.3025]);
set(gca,'FontSize',24,'FontWeight','bold');



