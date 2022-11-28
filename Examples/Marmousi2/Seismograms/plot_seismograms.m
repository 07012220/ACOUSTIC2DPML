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
y_ifft9=load('9_PML.txt');
y_ifft17=load('17_PML.txt');
y_ifft9c=load('9_CFSPML.txt');
y_ifft17c=load('17_CFSPML.txt');
y_ifft9n=load('9_optimizedCFSPML.txt');
y_ifft17n=load('17_optimizedCFSPML.txt');

[y_ifft9]=balance_trace(y_ifft9);
[y_ifft17]=balance_trace(y_ifft17);
[y_ifft9c]=balance_trace(y_ifft9c);
[y_ifft17c]=balance_trace(y_ifft17c);
[y_ifft9n]=balance_trace(y_ifft9n);
[y_ifft17n]=balance_trace(y_ifft17n);


h9=10; h17=10; nx9=681; nx17=681; dt=1/98; nt=256;
x_axis9=0:h9:h9*(nx9-1);
x_axis17=0:h17:h17*(nx17-1);
y_axis=0:dt:dt*(nt-1);

%% seismograms

%%PML
figure(5)
subplot(3,2,1)
plotimage(real(y_ifft9(1:nt,:)),x_axis9,y_axis,h9); % wigb(real(y_ifft9(1:nt,1:8:nx9)),1,x_axis9,y_axis);
set(gca,'Position',[0.13 0.729 0.1773 0.2589]);
ylabel('Time (s)','FontSize', [14],'FontWeight','bold');
xticklabels({' ',' ',' ',' '});
yticklabels({'0','0.4','0.8','1.2','1.6','2.0','2.4'});
set(gca,'FontSize',14,'FontWeight','bold');

subplot(3,2,2)

plotimage(real(y_ifft17(1:nt,:)),x_axis17,y_axis,h17);
set(gca,'Position',[0.33 0.729 0.1773 0.2589]);
xticklabels({' ',' ',' ',' '});
yticklabels({' ',' ',' ',' ',' ',' ',' '});
set(gca,'FontSize',14,'FontWeight','bold');

%%  CFS-PML
subplot(3,2,3)

plotimage(real(y_ifft9c(1:nt,:)),x_axis9,y_axis,h9);
set(gca,'Position',[0.13 0.44 0.177 0.259]);
ylabel('Time (s)','FontSize', [14],'FontWeight','bold');
xticklabels({' ',' ',' ',' '});
yticklabels({'0','0.4','0.8','1.2','1.6','2.0','2.4'});

set(gca,'FontSize',14,'FontWeight','bold');


subplot(3,2,4)

plotimage(real(y_ifft17c(1:nt,:)),x_axis17,y_axis,h17);
set(gca,'Position',[0.33 0.44 0.177 0.259]);
xticklabels({' ',' ',' ',' '});
yticklabels({' ',' ',' ',' ',' ',' ',' '});
set(gca,'FontSize',14,'FontWeight','bold');

%%  Improved CFS-PML
subplot(3,2,5)

plotimage(real(y_ifft9n(1:nt,:)),x_axis9,y_axis,h9);
set(gca,'Position',[0.13 0.15 0.1773 0.2589]);
xlabel('x (m)','FontSize', [14],'FontWeight','bold');
ylabel('Time (s)','FontSize', [14],'FontWeight','bold');
xticklabels({'0','2000','4000','6000'});
yticklabels({'0','0.4','0.8','1.2','1.6','2.0','2.4'});
set(gca,'FontSize',14,'FontWeight','bold');

subplot(3,2,6)

plotimage(real(y_ifft17n(1:nt,:)),x_axis17,y_axis,h17);
set(gca,'Position',[0.33 0.15 0.1773 0.2589]);
xlabel('x (m)','FontSize', [14],'FontWeight','bold');
xticklabels({'0','2000','4000','6000'});
yticklabels({' ',' ',' ',' ',' ',' ',' '});
set(gca,'FontSize',14,'FontWeight','bold');


%%  single trace

% plot(y_axis,real(y_ifft(1:256,(ceil(nx/3)))));
% xticks(0:0.2:1.6);xlim([0 1.6]);
% xlabel('Time/s','FontSize', [14]); ylabel('Normalized Solution','FontSize', [14]);set(gca,'FontSize',12);

figure (6)
subplot(2,1,1)
plot(y_axis,real(y_ifft9(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft9c(1:256,(ceil(nx9/2)))),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft9n(1:256,(ceil(nx9/2)))),':','color','k'); %axis([0 1.1 -1 1]);
set(gca,'Position',[0.13 0.5838 0.5 0.3412]);
xticks(0:0.2:2.4);yticks(-0.8:0.2:1);xlim([0 2.4]);ylim([-0.8 1]);
h5 = legend('9-point,PML','9-point,CFS-PML','9-point,Improved CFS-PML'); set(h5,'Box','off');
ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold');
set(gca,'FontSize',14,'FontWeight','bold');


subplot(2,1,2)
plot(y_axis,real(y_ifft17(1:256,ceil(nx17/2))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft17c(1:256,ceil(nx17/2))),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft17n(1:256,ceil(nx17/2))),':','color','k'); %axis([0 1.1 -1 1]);
set(gca,'Position',[0.13 0.1942 0.5 0.3412]);
xlabel('Time (s)','FontSize', [14],'FontWeight','bold');
ylabel('Normalized Solution','FontSize', [14],'FontWeight','bold');
h6 = legend('17-point,PML','17-point,CFS-PML','17-point,Improved CFS-PML'); set(h6,'Box','off');
xticks(0:0.2:2.4);yticks(-0.8:0.2:1);xlim([0 2.4]);ylim([-0.8 1]);set(gca,'FontSize',14,'FontWeight','bold');



