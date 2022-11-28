%% ACOUSTIC2DPML 
% FORWARD MODELING OF THE FREQUENCY-DOMAIN ACUSTIC WAVEFIELD
% USING THE FINITE DIFFRENCE SCHEME WITH OPTIMIZED PML BOUNDARY CONDITION
% 
%See following references for details of the finite difference schemes used.
% Jo, C.-H., Shin, J.-H., and Suh, J.-H., 1996, 
%  An optimal 9-point finite-difference frequency-space 2-D Scalar wave extrapolator,
%  Geophysics, 61(2),529-537.
% Cao, S.-H., and Chen, J.-B, 2012, 
%  A 17-point scheme and its numerical implementation for high-accuracy 
%  modeling of frequency-domain acoustic equation, 
%  Chinese Journal of Geophysics (in Chinese), 55(10), 3440-3449.
%  
% Developed by:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
%
%%
% Cartesian coordinate system used
%     o -----------------> x
%     |
%     |
%     |
%     |
%     |
%     |
%     v 
%
%%  Parameter description
% ischeme----type of the finite difference schemes used, 
%            and 0 means 9-point, 1 means 17-point;
% iPML-------type of absorbing boundaries; 
%            and 0 means PML, 1 means CFS-PML, 2 means optimized CFS-PML;
% bo------Constants of complex frequency transposition ranging from 0~20,
% co------Constants of complex frequency transposition ranging from 0~2,
% fo---------The dominant frequency of the source.
% rz---------The depth of the receivers

% Model parameter settings
%  nx--------Number of grid nodes in the x- direction;
%  nz--------Number of grid nodes in the z- direction;
%  npml1-----Number of absorption layers in x- direction;
%  npml2-----Number of absorption layers in z- direction;
%  nxe-------Number of grid nodes in x- direction;
%  nze-------Number of grid nodes in z- direction;
%  nne-------Total number of grid nodes for the discretized model;
%  h---------Grid interval (spatial sampling interval);
%  v---------Velocity;
%  PML-------0 is for conventional PML, 
%            1 is for the CFS-PML from Pan et al.(2012)
%            and 2 is for the optimized CFS-PML.

% Source parameter settings
%  ishot1-----The ordinate of the shot points;
%  ishot2-----The abscissa of the shot points;
%  ishot------The coordinates of the shot points;
%  nt---------The sampling points for the time domain source;
%  dt---------Time sampling interval;
%
%  damp1------Conventional PML absorption boundary;
%  damp2------Optimized CFS-PML absorption boundary;
%  imped9pml--9-point finite difference scheme;
%  imped17pml-17-point finitedifference scheme.

%% forward calculation
clc; clear all;
tic;

bo=1.885;
co=2.826;
fo=30;
rz=1;

 data=load('para17_optimizedCFSPML.txt'); 
 nx=data(1);
 nz=data(2);
 npml1=data(3);
 npml2=data(4);
 h=data(5);
 ischeme=data(6);
 iPML=data(7);
 fs=data(8);


 if (ischeme==1)
 bo=18.85;
 end
 
 a=90;
 nxe=nx+2*npml2;  nze=nz+2*npml1; nne=nxe*nze; V(1:nz,1:nx)=0;
 
data=load('Marmousi2.mesh');  % Homo.mesh Overthrust.mesh  Marmousi2.mesh
for i=1:nz
    for j=1:nx
        V(i,j)=data(i,j);
    end
end

v=vextpml(nz,nx,V,npml1,npml2);



% Shot parameter seting
 ishot1=npml1+10;ishot2=ceil(nxe/2);ishot=kkindex(ishot1,ishot2,nze);
%ishot1=ceil(nze/2);ishot2=ceil(nxe/2);ishot=kkindex(ishot1,ishot2,nze);

nt=256;dt=1/fs;
src=rickerfwt(nt,dt,fo); %nt,dt and the peak frequency
ntnew=power2(nt);nw=ntnew;
dw=2*pi/(nt*dt);
w =[0:dw:(nt/2)*dw -((nt/2)*dw-dw):dw:-dw]; w(1)=1e-2;
fftsrc=fft(src,ntnew);

y(1:ntnew,1:nx)=0; wavefield(1:nne,1:ntnew)=0; s(1:nne,1)=0;
n=0;
for i=1:ntnew/2+1
    n=n+1
    
    if (iPML==0)
        %  Conventional PML absorption boundary
        [d1]=damp1(nze,npml1,h,a,w(i));
        [d2]=damp1(nxe,npml2,h,a,w(i));
    elseif (iPML==1)
        %  CFS-PML absorption boundary
        [d1]=damp2(nze,npml1,h,a,w(i),v,fo);
        [d2]=damp2(nxe,npml2,h,a,w(i),v,fo);
    elseif(iPML==2)
        %  Optimized CFS-PML absorption boundary
        [d1]=damp3(nze,npml1,h,a,w(i),v,co,bo,fo);
        [d2]=damp3(nxe,npml2,h,a,w(i),v,co,bo,fo);
    end
    
    if(ischeme==0)
        % 9-point scheme
        A=imped9pml(nx,nz,h,v,w(i),npml1,npml2,d1,d2);
    else
        % 17-point scheme
        A=imped17pml(nx,nz,h,v,w(i),npml1,npml2,d1,d2);
    end
    
    
    % LU Decomposition
    s(ishot,1)=-fftsrc(i);
    if(fftsrc(i)==0)
        y(i,:)=0;
    else
  
        x=A\s;
        
        wavefield(:,i)=x;
        if(i==49)
            for iz=1:nze
                for ix=1:nxe
                    xx(iz,ix)=x((ix-1)*nze+iz);
                end
            end
        end
        for j=1:nx
            %index of receiver points, they are on top of the original model
            k=kkindex(rz+npml1,j+npml2,nze);
            y(i,j)=x(k);%extract wavefield of the receiver points
        end

    end
end

% Inverse transform of wavefield
y(nt/2+2:nt,:)=conj(y(nt/2:-1:2,:));
wavefield(:,nt/2+2:nt)=conj(wavefield(:,nt/2:-1:2));
A=0;
y_ifft=ifft(y);
wavefield_ifft=ifft(wavefield,[],2);
y_ifft=y_ifft/max(max((real(y_ifft))));

toc

if (ischeme==0 && iPML==0)
    fid=fopen('9_PML.txt','wt');  % set your own file path if nessary
elseif (ischeme==0 && iPML==1)
    fid=fopen('9_CFSPML.txt','wt');
elseif (ischeme==0 && iPML==2)
    fid=fopen('9_optimizedCFSPML.txt','wt');
elseif (ischeme==1 && iPML==0)
    fid=fopen('17_PML.txt','wt');
elseif (ischeme==1 && iPML==1)
    fid=fopen('17_CFSPML.txt','wt');
elseif (ischeme==1 && iPML==2)
    fid=fopen('17_optimizedCFSPML.txt','wt');
end

for i=1:nt
    for j=1:nx
        if (j==nx)
            fprintf(fid,'%g\n',real(y_ifft(i,j)));
        else
            fprintf(fid,'%g\t',real(y_ifft(i,j)));
        end
    end
end

fclose(fid);


%% Plotting the figures
x_axis=0:h:h*(nx-1);
y_axis=0:dt:dt*(nt-1);

% % Simulated seismogram diagram
figure;
wigb(real(y_ifft(1:nt,:)),1,x_axis,y_axis);
xlabel('x(m)','FontSize',[14]);ylabel('Time(s)','FontSize',[14]);

% Single channel seismograph
figure;set(axes,'fontsize',14);
if (ischeme==0)
    plot(y_axis,real(y_ifft(1:256,ceil(nx/3))),'color','k'); %axis([0 1.1 -1 1]);
else
    plot(y_axis,real(y_ifft(1:256,ceil(nx/3))),'color','k'); %axis([0 1.1 -1 1]);
end
xlabel('time(s)','FontSize', [14]); ylabel('Normalized Solution','FontSize', [14]);

figure;set(axes,'fontsize',14);
x=0:nx-1;z=0:nz-1;plotimage(real(xx(npml1+1:nze-npml1,npml2+1:nxe-npml2)),x,z,h);
colormap autumn;
xlabel('x(m)'); ylabel('z(m)');
% 156ms wavefield snapshot
figure;
x=wavefield_ifft(:,25);
for iz=1:nze
    for ix=1:nxe
        xx1(iz,ix)=x((ix-1)*nze+iz);
    end
end
x=0:nx-1;z=0:nz-1;plotimage(real(xx1(npml1+1:nze-npml1,npml2+1:nxe-npml2)),x,z,h); 
caxis([-6.037 9.68414]);
if (ischeme==0)
caxis([-2.692 5]);
end
xlabel('x(m)'); ylabel('z(m)');

% 218ms wavefield snapshot
figure;
x=wavefield_ifft(:,35);
for iz=1:nze
    for ix=1:nxe
        xx1(iz,ix)=x((ix-1)*nze+iz);
    end
end
x=0:nx-1;z=0:nz-1;plotimage(real(xx1(npml1+1:nze-npml1,npml2+1:nxe-npml2)),x,z,h); 
caxis([-6.037 9.68414]);
if (ischeme==0)
caxis([-2.692 5]);
end
xlabel('x(m)'); ylabel('z(m)');

% 281ms wavefield snapshot
figure;
x=wavefield_ifft(:,45);
for iz=1:nze
    for ix=1:nxe
        xx1(iz,ix)=x((ix-1)*nze+iz);
    end
end
x=0:nx-1;z=0:nz-1;plotimage(real(xx1(npml1+1:nze-npml1,npml2+1:nxe-npml2)),x,z,h);
caxis([-6.037 9.68414]);
if (ischeme==0)
caxis([-2.692 5]);
end
xlabel('x(m)'); ylabel('z(m)');

