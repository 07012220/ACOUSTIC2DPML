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
fid=fopen('fsismos2','r');
A=fread(fid,[90,90],'float');
fclose(fid);
y_ifft(1:256,1:90)=0;
h=10;
dt=1/160;
nt=256;
nx=90;
k=1;
for i=1:90
    for j=1:90
        y_ifft(j,i)=A(j,i);
    end
end
y_ifft=y_ifft/max(max((real(y_ifft))));
y_ifft940=load('9_PML.txt');
y_ifft1740=load('17_PML.txt');
y_ifft940p=load('9_CFSPML.txt');
y_ifft1740p=load('17_CFSPML.txt');
y_ifft940c=load('9_optimizedCFSPML.txt');
y_ifft1740c=load('17_optimizedCFSPML.txt');
% y_ifft1740c2=load('homo_17_optimizedCFSPML.txt');
% y_ifft120=load('120_layers_solution.txt');
h9=10; h17=15; nx9=90; nx17=60; dt=0.0063; nt=256;
x_axis9=0:h9:h9*(nx9-1);
x_axis17=0:h17:h17*(nx17-1);
y_axis=0:dt:dt*(nt-1);

%% seismograms
%%PML
figure(5);set(axes,'fontsize',14);
subplot(3,2,1)

plotimage(real(y_ifft940(1:nt,:)),x_axis9,y_axis,h9);
set(gca,'Position',[0.13 0.729 0.1773 0.2589]);
ylabel('Time (s)','FontSize', [14],'FontWeight','bold');
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
yticklabels({'0','0.2','0.4','0.6','0.8','1.0','1.2','1.4','1.6'});
set(gca,'FontSize',14,'FontWeight','bold');

subplot(3,2,2)

plotimage(real(y_ifft1740(1:nt,:)),x_axis17,y_axis,h17);
set(gca,'Position',[0.33 0.729 0.1773 0.2589]);
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
yticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
set(gca,'FontSize',14,'FontWeight','bold');

%%  CFS-PML
subplot(3,2,3)

plotimage(real(y_ifft940p(1:nt,:)),x_axis9,y_axis,h9);
set(gca,'Position',[0.13 0.44 0.177 0.259]);
ylabel('Time (s)','FontSize', [14],'FontWeight','bold');
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
yticklabels({'0','0.2','0.4','0.6','0.8','1.0','1.2','1.4','1.6'});
set(gca,'FontSize',14,'FontWeight','bold');

subplot(3,2,4)

plotimage(real(y_ifft1740p(1:nt,:)),x_axis17,y_axis,h17);
set(gca,'Position',[0.33 0.44 0.177 0.259]);
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
yticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
set(gca,'FontSize',14,'FontWeight','bold');

%%  Improved CFS-PML
subplot(3,2,5)

plotimage(real(y_ifft940c(1:nt,:)),x_axis9,y_axis,h9);

set(gca,'Position',[0.13 0.15 0.1773 0.2589]);
xlabel('x (m)','FontSize', [14],'FontWeight','bold');
ylabel('Time (s)','FontSize', [14],'FontWeight','bold');
xticklabels({'0','100','200','300','400','500','600','700','800','900'});
yticklabels({'0','0.2','0.4','0.6','0.8','1.0','1.2','1.4','1.6'});
set(gca,'FontSize',14,'FontWeight','bold');

subplot(3,2,6)

plotimage(real(y_ifft1740c(1:nt,:)),x_axis17,y_axis,h17);
set(gca,'Position',[0.33 0.15 0.1773 0.2589]);
xlabel('x (m)','FontSize', [14],'FontWeight','bold');
xticklabels({'0','100','200','300','400','500','600','700','800','900'});
yticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
set(gca,'FontSize',14,'FontWeight','bold');
%%  single traces
%%PML
figure(6);set(axes,'fontsize',14);
subplot(3,2,1)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft940(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]); r
hold on;
plot(y_axis,real(y_ifft1740(1:256,ceil(nx17/2))),':','color','k'); %axis([0 1.1 -1 1]); b
set(gca,'Position',[0.13 0.7349 0.157 0.2327]);
xticks(0:0.2:1.6);yticks(-0.8:0.2:1);xlim([0 1.6]);ylim([-0.8 1]);
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
hl = legend('Analytical solution','9-point','17-point'); set(hl,'Box','off');
ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold')
;set(gca,'FontSize',14,'FontWeight','bold');


subplot(3,2,2)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft940(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft1740(1:256,ceil(nx17/2))),':','color','k'); %axis([0 1.1 -1 1]);
set(gca,'Position',[0.3226 0.7349 0.157 0.2327]);
xticks(0.3:0.1:1.2);yticks(-0.05:0.01:0.05);xlim([0.3 1.2]);ylim([-0.05 0.05]);
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
h2 = legend('Analytical solution','9-point','17-point'); set(h2,'Box','off');
set(gca,'FontSize',14,'FontWeight','bold');

%%  CFS-PML
subplot(3,2,3)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft940p(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]); r
hold on;
plot(y_axis,real(y_ifft1740p(1:256,ceil(nx17/2))),':','color','k'); %axis([0 1.1 -1 1]); b
set(gca,'Position',[0.13 0.47 0.157 0.2327]);
xticks(0:0.2:1.6);yticks(-0.8:0.2:1);xlim([0 1.6]);ylim([-0.8 1]);
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
h3 = legend('Analytical solution','9-point','17-point'); set(h3,'Box','off');
ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold');set(gca,'FontSize',14,'FontWeight','bold');

subplot(3,2,4)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft940p(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]); r
hold on;
plot(y_axis,real(y_ifft1740p(1:256,ceil(nx17/2))),':','color','k'); %axis([0 1.1 -1 1]); b
set(gca,'Position',[0.3226 0.47 0.157 0.2327]);
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
h4 = legend('Analytical solution','9-point','17-point'); set(h4,'Box','off');
xticks(0.3:0.1:1.2);yticks(-0.05:0.01:0.05);xlim([0.3 1.2]);ylim([-0.05 0.05]);
set(gca,'FontSize',14,'FontWeight','bold');
%%  Improved CFS-PML
subplot(3,2,5)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft940c(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]); r
hold on;
plot(y_axis,real(y_ifft1740c(1:256,ceil(nx17/2))),'-.','color','k'); %axis([0 1.1 -1 1]); b
set(gca,'Position',[0.13 0.205 0.157 0.2327]);
xticks(0:0.2:1.6);yticks(-0.8:0.2:1);xlim([0 1.6]);ylim([-0.8 1]);
h5 = legend('Analytical solution','9-point','17-point'); set(h5,'Box','off');
xlabel('Time (s)','FontSize', [14],'FontWeight','bold'); 
ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold');
set(gca,'FontSize',14,'FontWeight','bold');


subplot(3,2,6)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft940c(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]); r
hold on;
plot(y_axis,real(y_ifft1740c(1:256,ceil(nx17/2))),':','color','k'); %axis([0 1.1 -1 1]); b
set(gca,'Position',[0.3226 0.205 0.157 0.2327]);
h6 = legend('Analytical solution','9-point','17-point'); set(h6,'Box','off');
xlabel('Time (s)','FontSize', [14],'FontWeight','bold');
xticks(0.3:0.1:1.2);yticks(-0.05:0.01:0.05);xlim([0.3 1.2]);ylim([-0.05 0.05]);
set(gca,'FontSize',14,'FontWeight','bold');





