%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
function ss=imped9pml(nx,nz,h,v,w,npml1,npml2,d1,d2)
n1e=nz+2*npml1;
n2e=nx+2*npml2;
nn=n1e*n2e;
%damp1 : z      damp2 :  x
damp1(1:n1e,1:n2e)=1;damp2(1:n1e,1:n2e)=1;
for i=1:n2e
    damp1(1:npml1,i)=d1(2:npml1+1);
    damp1(n1e-npml1+1:n1e,i)=d1(n1e-npml1+2:n1e+1);
end
for i=1:npml2
    damp2(:,i)=d2(i+1);
    damp2(:,npml2+nx+i)=d2(nx+npml2+i+1);
end

pi=3.141592654;
h2=1./(h*h);
ci=1i;
% coeffients for optimal 9-point method
a=0.5461;
c=0.6248;
d=0.09381;      %0.0938
e=(1-c-4*d)/4;

%coeffients for conventional 5-piont method
%               a=1;c=1;d=0;e=0;
% nx %   sampling number in the x-direction
% nz % sampling number in the z-direction

%  C1=-4*a*h2-2*(1-a)*h2+c*w.^2/v.^2;
% damp1(1),damp1b1(1),damp1b2(1),damp2(1),damp2b1(1),damp2b2(1)
%------------------Construct impedence matrix using sparse------------------
%  C2=a*h2+d*w.^2/v.^2;
%  C3=C2;
%  C4=C2;
%  C5=C2;
%  R1=0.5*(1-a)*h2;
%  R2=R1;
%  R3=R1;
%  R4=R1;

j=1;
k=1;
icountc1=0;icountc2=0;icountc3=0;icountc4=0;icountc5=0;icountr1=0;icountr2=0;icountr3=0;icountr4=0;

for j = 1:n2e
    for k = 1:n1e
        
        %             get current cell index
        iele1=(j-2)*(n1e)+k-1;                          %(j-1,k-1) r1
        iele2=(j-2)*(n1e)+k;                            %(j-1,k)   c2
        iele3=(j-2)*(n1e)+k+1;                          %(j-1,k+1) r3
        iele4=(j-1)*(n1e)+k-1;                          %(j,k-1)   c4
        iele5=(j-1)*(n1e)+k ;                           %(j,k)     c1
        iele6=(j-1)*(n1e)+k+1 ;                         %(j,k+1)   c5
        iele7=(j)*(n1e)+k-1  ;                          %(j+1,k-1) r2
        iele8=(j)*(n1e)+k  ;                            %(j+1,k)   c3
        iele9=(j)*(n1e)+k+1 ;                           %(j+1,k+1)  r4
        
        
        
        
        %              U(j-1,k-1)
        if(j>1 && k>1)
            icountr1 = icountr1 + 1;
            r1(icountr1)=e*w.^2./v(iele5).^2+0.5*h2*(1-a)*(damp1(iele5).*damp1(iele5));
            
            irowr1(icountr1) = iele5;
            jcolr1(icountr1) = iele1;
        end
        
        %              U(j-1,k)
        if(j>1)
            icountc2 = icountc2 + 1;
            c2(icountc2)=d*w.^2./v(iele5).^2+a*h2*damp2(iele5).*damp2(iele5);
            
            irowc2(icountc2) = iele5;
            jcolc2(icountc2) = iele2;
            
        end
        
        %              U(j-1,k+1)
        if(j>1 && k<=n1e-1)
            icountr3 = icountr3 + 1;
            r3(icountr3)=e*w.^2./v(iele5).^2+0.5*h2*(1-a)*(damp2(iele5).*damp2(iele5));
            
            irowr3(icountr3) = iele5;
            jcolr3(icountr3) = iele3;
            
        end
        
        %             U(j,k-1)
        if(k>1)
            icountc4 = icountc4 + 1;
            c4(icountc4)=d*w.^2./v(iele5).^2+a*h2*damp1(iele5).*damp1(iele5);
            
            irowc4(icountc4) = iele5;
            jcolc4(icountc4) = iele4;
        end
        
        %             U(j,k)
        icountc1 = icountc1 + 1;
        c1(icountc1)=c*w.^2./v(iele5).^2-1*h2*(1-a)*(damp2(iele5).*damp2(iele5)+damp1(iele5).*damp1(iele5))-2*a*h2*(damp2(iele5).*damp2(iele5)+damp1(iele5).*damp1(iele5));
        
        irowc1(icountc1) = iele5;
        jcolc1(icountc1) = iele5;
        
        %             U(j,k+1)
        if(k<=n1e-1)
            icountc5 = icountc5 + 1;
            c5(icountc5)=d*w.^2./v(iele5).^2+a*h2*damp1(iele5).*damp1(iele5);
            
            irowc5(icountc5) = iele5;
            jcolc5(icountc5) = iele6;
        end
        
        %             U(j+1,k-1)
        if(j<=n2e-1 && k>1)
            icountr2 = icountr2 + 1;
            r2(icountr2)=e*w.^2./v(iele5).^2+0.5*h2*(1-a)*(damp2(iele5).*damp2(iele5));
            
            irowr2(icountr2) = iele5;
            jcolr2(icountr2) = iele7;
        end
        
        %              U(j+1,k)
        if(j<=n2e-1)
            icountc3 = icountc3 + 1;
            c3(icountc3)=d*w.^2./v(iele5).^2+a*h2*damp2(iele5).*damp2(iele5);
            
            irowc3(icountc3) = iele5;
            jcolc3(icountc3) = iele8;
        end
        
        %             U(j+1,k+1)
        if(j<=n2e-1 && k<=n1e-1)
            icountr4 = icountr4 + 1;
            r4(icountr4)=e*w.^2./v(iele5).^2+0.5*h2*(1-a)*(damp1(iele5).*damp1(iele5));
            
            irowr4(icountr4) = iele5;
            jcolr4(icountr4) = iele9;
        end
        
    end
end


% Store ss
sc1=sparse(irowc1,jcolc1, c1, nn,nn);
sc2=sparse(irowc2,jcolc2,c2,nn,nn);
sc3=sparse(irowc3,jcolc3,c3,nn,nn);
sc4=sparse(irowc4,jcolc4,c4,nn,nn);
sc5=sparse(irowc5,jcolc5,c5,nn,nn);
sr1=sparse(irowr1,jcolr1,r1,nn,nn);
sr2=sparse(irowr2,jcolr2,r2,nn,nn);
sr3=sparse(irowr3,jcolr3,r3,nn,nn);
sr4=sparse(irowr4,jcolr4,r4,nn,nn);

ss=sc1+sc2+sc3+sc4+sc5+sr1+sr2+sr3+sr4;

%---------------------------end of theconstruction-----------------------
% ss is the impedence matrix for the above-mentioned 9-point scheme in
% a general form.
