%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
function ss=imped17pml(nx,nz,h,v,w,npml1,npml2,d1,d2)
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
a=1.0673;
b=0.8875;
c=0.0251;
d=0.0237;      %0.0938
e=-0.0204;
f=(1-b-4*c-4*d-4*e)/4;


%------------------Construct impedence matrix using sparse------------------


icountr11=0;icountr21=0;icountr31=0;icountr41=0;icountr12=0;icountr22=0;icountr32=0;icountr42=0;icountc5=0;
icountc11=0;icountc21=0;icountc31=0;icountc41=0;icountc12=0;icountc22=0;icountc32=0;icountc42=0;

for j = 1:n2e
    for k = 1:n1e
        
        %             get current cell index
        
        iele10=(j-3)*(n1e)+k-2;                         %(j-2,k-2) r11
        iele11=(j-3)*(n1e)+k;                           %(j-2,k)   c21
        iele12=(j-3)*(n1e)+k+2;                         %(j-2,k+2) r21
        iele1=(j-2)*(n1e)+k-1;                          %(j-1,k-1) r31
        iele2=(j-2)*(n1e)+k;                            %(j-1,k)   c41
        iele3=(j-2)*(n1e)+k+1;                          %(j-1,k+1) r41
        iele13=(j-1)*(n1e)+k-2;                         %(j,k-2)   c11
        iele4=(j-1)*(n1e)+k-1;                          %(j,k-1)   c31
        iele5=(j-1)*(n1e)+k;                            %(j,k)     c5
        iele6=(j-1)*(n1e)+k+1;                          %(j,k+1)   c32
        iele14=(j-1)*(n1e)+k+2;                         %(j,k+2)   c12
        iele7=(j)*(n1e)+k-1;                            %(j+1,k-1) r42
        iele8=(j)*(n1e)+k;                              %(j+1,k)   c42
        iele9=(j)*(n1e)+k+1;                            %(j+1,k+1) r32
        iele15=(j+1)*(n1e)+k-2;                         %(j+2,k-2)  r22
        iele16=(j+1)*(n1e)+k;                           %(j+2,k)    c22
        iele17=(j+1)*(n1e)+k+2;                         %(j+2,k+2)  r12
        
        
        
        %              U(j-2,k-2)
        if(j>2 && k>2)
            icountr11 = icountr11 + 1;
            r11(icountr11)=f*w.^2./v(iele5).^2-(1/24)*h2*(1-a)*(damp1(iele5).*damp1(iele5));
            
            irowr11(icountr11) = iele5;
            jcolr11(icountr11) = iele10;
        end
        
        %              U(j-2,k)
        if(j>2)
            icountc21 = icountc21 + 1;
            c21(icountc21)=e*w.^2./v(iele5).^2-(1/12)*a*h2*(damp2(iele5).*damp2(iele5));
            
            irowc21(icountc21) = iele5;
            jcolc21(icountc21) = iele11;
        end
        
        %              U(j-2,k+2)
        if(j>2 && k<=n1e-2)
            icountr21 = icountr21 + 1;
            r21(icountr21)=f*w.^2./v(iele5).^2-(1/24)*h2*(1-a)*(damp2(iele5).*damp2(iele5));
            
            irowr21(icountr21) = iele5;
            jcolr21(icountr21) = iele12;
            
        end
        
        
        %              U(j-1,k-1)
        if(j>1 && k>1)
            icountr31 = icountr31 + 1;
            r31(icountr31)=d*w.^2./v(iele5).^2+(2/3)*h2*(1-a)*(damp1(iele5).*damp1(iele5));
            
            irowr31(icountr31) = iele5;
            jcolr31(icountr31) = iele1;
        end
        
        %              U(j-1,k)
        if(j>1)
            icountc41 = icountc41 + 1;
            c41(icountc41)=c*w.^2./v(iele5).^2+(4/3)*a*h2*(damp2(iele5).*damp2(iele5));
            
            irowc41(icountc41) = iele5;
            jcolc41(icountc41) = iele2;
            
        end
        
        %              U(j-1,k+1)
        if(j>1 && k<=n1e-1)
            icountr41 = icountr41 + 1;
            r41(icountr41)=d*w.^2./v(iele5).^2+(2/3)*h2*(1-a)*(damp2(iele5).*damp2(iele5));
            
            irowr41(icountr41) = iele5;
            jcolr41(icountr41) = iele3;
            
        end
        
        %             U(j,k-2)
        if(k>2)
            icountc11 = icountc11 + 1;
            c11(icountc11)=e*w.^2./v(iele5).^2-(1/12)*a*h2*(damp1(iele5).*damp1(iele5));
            
            irowc11(icountc11) = iele5;
            jcolc11(icountc11) = iele13;
        end
        
        
        %             U(j,k-1)
        if(k>1)
            icountc31 = icountc31 + 1;
            c31(icountc31)=c*w.^2./v(iele5).^2+(4/3)*a*h2*(damp1(iele5).*damp1(iele5));
            
            irowc31(icountc31) = iele5;
            jcolc31(icountc31) = iele4;
        end
        
        %             U(j,k)
        icountc5 = icountc5 + 1;
        c5(icountc5)=b*w.^2./v(iele5).^2-1.25*h2*(1-a)*(damp2(iele5).*damp2(iele5)+damp1(iele5).*damp1(iele5))-2.5*a*h2*(damp2(iele5).*damp2(iele5)+damp1(iele5).*damp1(iele5));
        
        irowc5(icountc5) = iele5;
        jcolc5(icountc5) = iele5;
        
        %             U(j,k+1)
        if(k<=n1e-1)
            icountc32 = icountc32 + 1;
            c32(icountc32)=c*w.^2./v(iele5).^2+(4/3)*a*h2*(damp1(iele5).*damp1(iele5));
            
            irowc32(icountc32) = iele5;
            jcolc32(icountc32) = iele6;
        end
        
        %             U(j,k+2)
        if(k<=n1e-2)
            icountc12 = icountc12 + 1;
            c12(icountc12)=e*w.^2./v(iele5).^2-(1/12)*a*h2*(damp1(iele5).*damp1(iele5));
            
            irowc12(icountc12) = iele5;
            jcolc12(icountc12) = iele14;
        end
        
        %             U(j+1,k-1)
        if(j<=n2e-1 && k>1)
            icountr42 = icountr42 + 1;
            r42(icountr42)=d*w.^2./v(iele5).^2+(2/3)*h2*(1-a)*(damp2(iele5).*damp2(iele5));
            
            irowr42(icountr42) = iele5;
            jcolr42(icountr42) = iele7;
        end
        
        %              U(j+1,k)
        if(j<=n2e-1)
            icountc42 = icountc42 + 1;
            c42(icountc42)=c*w.^2./v(iele5).^2+(4/3)*a*h2*(damp2(iele5).*damp2(iele5));
            
            irowc42(icountc42) = iele5;
            jcolc42(icountc42) = iele8;
        end
        
        %             U(j+1,k+1)
        if(j<=n2e-1 && k<=n1e-1)
            icountr32 = icountr32 + 1;
            r32(icountr32)=d*w.^2./v(iele5).^2+(2/3)*h2*(1-a)*(damp1(iele5).*damp1(iele5));
            
            irowr32(icountr32) = iele5;
            jcolr32(icountr32) = iele9;
        end
        
        %             U(j+2,k-2)
        if(j<=n2e-2 && k>2)
            icountr22 = icountr22 + 1;
            r22(icountr22)=f*w.^2./v(iele5).^2-(1/24)*h2*(1-a)*(damp2(iele5).*damp2(iele5));
            
            irowr22(icountr22) = iele5;
            jcolr22(icountr22) = iele15;
        end
        
        %              U(j+2,k)
        if(j<=n2e-2)
            icountc22 = icountc22 + 1;
            c22(icountc22)=e*w.^2./v(iele5).^2-(1/12)*a*h2*(damp2(iele5).*damp2(iele5));
            
            irowc22(icountc22) = iele5;
            jcolc22(icountc22) = iele16;
        end
        
        %             U(j+2,k+2)
        if(j<=n2e-2 && k<=n1e-2)
            icountr12 = icountr12 + 1;
            r12(icountr12)=f*w.^2./v(iele5).^2-(1/24)*h2*(1-a)*(damp1(iele5).*damp1(iele5));
            
            irowr12(icountr12) = iele5;
            jcolr12(icountr12) = iele17;
        end
        
    end
end


%The array is stored in the column

sc11=sparse(irowc11,jcolc11, c11, nn,nn);
sc21=sparse(irowc21,jcolc21,c21,nn,nn);
sc31=sparse(irowc31,jcolc31,c31,nn,nn);
sc41=sparse(irowc41,jcolc41,c41,nn,nn);
sc12=sparse(irowc12,jcolc12, c12, nn,nn);
sc22=sparse(irowc22,jcolc22,c22,nn,nn);
sc32=sparse(irowc32,jcolc32,c32,nn,nn);
sc42=sparse(irowc42,jcolc42,c42,nn,nn);
sc5=sparse(irowc5,jcolc5,c5,nn,nn);
sr11=sparse(irowr11,jcolr11,r11,nn,nn);
sr21=sparse(irowr21,jcolr21,r21,nn,nn);
sr31=sparse(irowr31,jcolr31,r31,nn,nn);
sr41=sparse(irowr41,jcolr41,r41,nn,nn);
sr12=sparse(irowr12,jcolr12,r12,nn,nn);
sr22=sparse(irowr22,jcolr22,r22,nn,nn);
sr32=sparse(irowr32,jcolr32,r32,nn,nn);
sr42=sparse(irowr42,jcolr42,r42,nn,nn);

ss=sc11+sc21+sc31+sc41+sc12+sc22+sc32+sc42+sc5+sr11+sr21+sr31+sr41+sr12+sr22+sr32+sr42;

%---------------------------end of theconstruction-----------------------
% ss is the impedence matrix for the above-mentioned 17-point scheme in
% a general form.
