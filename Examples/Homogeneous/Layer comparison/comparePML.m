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
y_ifft1720=load('17_optimizedCFSPML20.txt');
y_ifft1740=load('17_optimizedCFSPML40.txt');
y_ifft120=load('17_optimizedCFSPML120.txt');
h9=10; h17=15; nx9=90; nx17=60; dt=0.0063; nt=256;
x_axis9=0:h9:h9*(nx9-1);
x_axis17=0:h17:h17*(nx17-1);
y_axis=0:dt:dt*(nt-1);

%% PMl layers compare

figure (7);
subplot(2,1,1)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft1720(1:256,(ceil(nx17/2)))),'color','m'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft1740(1:256,(ceil(nx17/2)))),'color','r'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft120(1:256,ceil(nx17/2))),'color','b'); %axis([0 1.1 -1 1]);
xticks(0:0.2:1.6);yticks(-0.8:0.2:1);xlim([0 1.6]);ylim([-0.8 1]);
h1 = legend('Analytical solution','17-point,20 layers','17-point,40 layers','17-point,120 layers'); set(h1,'Box','off');
xlabel('Time(s)','FontSize', [14]); ylabel('Normalized Solution','FontSize', [14]);

subplot(2,1,2)
plot(y_axis,real(y_ifft(1:256,(ceil(nx9/2)))),'color','k'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft1720(1:256,(ceil(nx17/2)))),'color','m'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft1740(1:256,(ceil(nx17/2)))),'color','r'); %axis([0 1.1 -1 1]);
hold on;
plot(y_axis,real(y_ifft120(1:256,ceil(nx17/2))),'color','b'); %axis([0 1.1 -1 1]);
xticks(0.3:0.1:1.6);yticks(-0.02:0.005:0.02);xlim([0.3 1.6]);ylim([-0.02 0.02]);
h1 = legend('Analytical solution','17-point,20 layers','17-point,40 layers','17-point,120 layers'); set(h1,'Box','off');
xlabel('Time(s)','FontSize', [14]); ylabel('Normalized Solution','FontSize', [14]);
