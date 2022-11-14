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

h9=10; h17=15; nx9=90; nx17=60; dt=0.0063; nt=256;


yc_ifft940(:,1)=abs(real(y_ifft940(:,ceil(nx9/2)))-real(y_ifft(:,ceil(nx9/2))));
yc_ifft1740(:,1)=abs(real(y_ifft1740(:,ceil(nx17/2)))-real(y_ifft(:,ceil(nx9/2))));
yc_ifft940p(:,1)=abs(real(y_ifft940p(:,ceil(nx9/2)))-real(y_ifft(:,ceil(nx9/2))));
yc_ifft1740p(:,1)=abs(real(y_ifft1740p(:,ceil(nx17/2)))-real(y_ifft(:,ceil(nx9/2))));
yc_ifft940c(:,1)=abs(real(y_ifft940c(:,ceil(nx9/2)))-real(y_ifft(:,ceil(nx9/2))));
yc_ifft1740c(:,1)=abs(real(y_ifft1740c(:,ceil(nx17/2)))-real(y_ifft(:,ceil(nx9/2))));


x_axis9=0:h9:h9*(nx9-1);
x_axis17=0:h17:h17*(nx17-1);
y_axis=0:dt:dt*(nt-1);

%% seismograms
%%absolute error
figure(5);set(axes,'fontsize',14);
subplot(2,1,1)
plot(y_axis,real(yc_ifft940(1:256,1)),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(yc_ifft940p(1:256,1)),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(yc_ifft940c(1:256,1)),':','color','k'); %axis([0 1.1 -1 1]);
%set(gca,'Position',[0.13 0.7349 0.157 0.2327]);
xticks(0.3:0.2:1.6);yticks(0:0.005:0.03);
xlim([0.3 1.6]);ylim([0 0.03]);
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});
hl = legend('9-point,PML','9-point,CFS-PML','9-point,NewCFS-PML'); set(hl,'Box','off');
 ylabel('Absolute error','FontSize', [14],'FontWeight','bold');set(gca,'FontSize',14,'FontWeight','bold');

subplot(2,1,2)
plot(y_axis,real(yc_ifft1740(1:256,1)),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(yc_ifft1740p(1:256,1)),'--','color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(yc_ifft1740c(1:256,1)),':','color','k'); %axis([0 1.1 -1 1]);
set(gca,'Position',[0.1489 0.1708 0.7561 0.3137]);
xticks(0.3:0.2:1.6);yticks(0:0.005:0.03);
xlim([0.3 1.6]);ylim([0 0.03]);
hl = legend('17-point,PML','17-point,CFS-PML','17-point,NewCFS-PML'); set(hl,'Box','off');
xlabel('Time (s)','FontSize', [14],'FontWeight','bold'); 
ylabel('Absolute error','FontSize', [14],'FontWeight','bold');
set(gca,'FontSize',14,'FontWeight','bold');
