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
y_ifft95=load('homo_9_optimizedCFSPML_5n2.txt');
y_ifft985=load('homo_9_optimizedCFSPML_85n2.txt');
y_ifft9885=load('homo_9_optimizedCFSPML_885n2.txt');
y_ifft9=load('homo_9_optimizedCFSPML_n2.txt');
y_ifft91885=load('homo_9_optimizedCFSPML_1885n2.txt');
y_ifft175=load('homo_17_optimizedCFSPML_5n2.txt');
y_ifft1785=load('homo_17_optimizedCFSPML_85n2.txt');
y_ifft17885=load('homo_17_optimizedCFSPML_885n2.txt');
y_ifft17=load('homo_17_optimizedCFSPML_n2.txt');
y_ifft171885=load('homo_17_optimizedCFSPML_1885n2.txt');

h9=10; h17=15; nx9=90; nx17=60; dt=0.0063; nt=256;
x_axis9=0:h9:h9*(nx9-1);
x_axis17=0:h17:h17*(nx17-1);
y_axis=0:dt:dt*(nt-1);

%%  single traces
%%9-point
figure;set(axes,'fontsize',14);
subplot(2,1,1)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]); 
hold on;
plot(y_axis,real(y_ifft95(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft985(1:256,(ceil(nx9/2)))),':','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft9885(1:256,(ceil(nx9/2)))),'-.','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft9(1:256,(ceil(nx9/2)))),'--^','color','k','MarkerSize',4,'MarkerIndices',1:5:length(real(y_ifft9(1:256,(ceil(nx9/2)))))); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft91885(1:256,(ceil(nx9/2)))),'--o','color','k','MarkerSize',4,'MarkerIndices',1:5:length(real(y_ifft91885(1:256,(ceil(nx9/2)))))); %axis([0 1.1 -1 1]);
xticks(0:0.2:1.6);yticks(-0.8:0.2:1);xlim([0 1.6]);ylim([-0.8 1]);
set(gca,'Position',[0.13,0.5838,0.5,0.3412]);
hl = legend('Analytical solution','\beta_0 = 0.005,9-point','\beta_0 = 0.085,9-point','\beta_0 = 0.885,9-point','\beta_0 = 1.885,9-point','\beta_0 = 18.85,9-point'); set(hl,'Box','off');
ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold');
set(gca,'FontSize',14,'FontWeight','bold');


subplot(2,1,2)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]); 0.13,0.1998,0.5,0.3412
hold on;
plot(y_axis,real(y_ifft95(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft985(1:256,(ceil(nx9/2)))),':','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft9885(1:256,(ceil(nx9/2)))),'-.','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft9(1:256,(ceil(nx9/2)))),'--^','color','k','MarkerSize',4,'MarkerIndices',1:4:length(real(y_ifft9(1:256,(ceil(nx9/2)))))); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft91885(1:256,(ceil(nx9/2)))),'--o','color','k','MarkerSize',4,'MarkerIndices',1:4:length(real(y_ifft91885(1:256,(ceil(nx9/2)))))); %axis([0 1.1 -1 1]);
xticks(0.3:0.1:1.6);yticks(-0.1:0.02:0.06);xlim([0.3 1.6]);ylim([-0.1 0.06]);
set(gca,'Position',[0.13,0.1998,0.5,0.3412]);
xlabel('Time (s)','FontSize', [14],'FontWeight','bold'); ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold');
set(gca,'FontSize',14,'FontWeight','bold');

%%  17-point
figure;set(axes,'fontsize',14);
subplot(2,1,1)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft175(1:256,(ceil(nx17/2)))),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft1785(1:256,(ceil(nx17/2)))),':','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft17885(1:256,(ceil(nx17/2)))),'-.','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft17(1:256,(ceil(nx17/2)))),'--^','color','k','MarkerSize',4,'MarkerIndices',1:4:length(real(y_ifft17(1:256,(ceil(nx17/2)))))); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft171885(1:256,(ceil(nx17/2)))),'--o','color','k','MarkerSize',4,'MarkerIndices',1:4:length(real(y_ifft171885(1:256,(ceil(nx17/2)))))); %axis([0 1.1 -1 1]);
xticks(0:0.2:1.6);yticks(-0.8:0.2:1);xlim([0 1.6]);ylim([-0.8 1]);
hl = legend('Analytical solution','\beta_0 = 0.005,17-point','\beta_0 = 0.085,17-point','\beta_0 = 0.885,17-point','\beta_0 = 1.885,17-point','\beta_0 = 18.85,17-point'); set(hl,'Box','off');
set(gca,'Position',[0.13,0.5838,0.5,0.3412]);
ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold');
set(gca,'FontSize',14,'FontWeight','bold');


subplot(2,1,2)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft175(1:256,(ceil(nx17/2)))),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft1785(1:256,(ceil(nx17/2)))),':','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft17885(1:256,(ceil(nx17/2)))),'-.','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft17(1:256,(ceil(nx17/2)))),'--^','color','k','MarkerSize',4,'MarkerIndices',1:4:length(real(y_ifft17(1:256,(ceil(nx17/2)))))); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft171885(1:256,(ceil(nx17/2)))),'--o','color','k','MarkerSize',4,'MarkerIndices',1:4:length(real(y_ifft171885(1:256,(ceil(nx17/2))))));
xticks(0.3:0.1:1.6);yticks(-0.1:0.01:0.06);xlim([0.3 1.6]);ylim([-0.1 0.06]);
set(gca,'Position',[0.13,0.1998,0.5,0.3412]);
xlabel('Time (s)','FontSize', [14],'FontWeight','bold'); ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold');
set(gca,'FontSize',14,'FontWeight','bold');