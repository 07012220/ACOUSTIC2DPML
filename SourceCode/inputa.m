clc; clear all;
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
x_axis=0:h:h*(nx-1);
y_axis=0:dt:dt*(nt-1);
figure;
wigb(real(y_ifft(1:nt,:)),1,x_axis,y_axis);
xlabel('x/m','FontSize',[14]);ylabel('Time/s','FontSize',[14]);

figure;
plot(y_axis,y_ifft(1:256,ceil(nx/2)),'color','k'); %axis([0 1.1 -1 1]);
xlabel('time/s','FontSize', [14]); ylabel('Normalized Solution','FontSize', [14]);