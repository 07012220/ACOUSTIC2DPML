%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
function vext=vextpml(n1,n2,v0,npml1,npml2)
n1e=n1+2*npml1; n2e=n2+2*npml2;
for i=1:n1              %The area in the model
    for j=1:n2
        vext(i+npml1,j+npml2)=v0(i,j);
    end
end
for i=1:npml2          %Left -right
    vext(npml1+1:n1+npml1,i)=v0(:,1);
    vext(npml1+1:n1+npml1,i+npml2+n2)=v0(:,n2);
end
for i=1:n2             %Upper -lower
    vext(1:npml1,i+npml2)=ones(npml1,1)*v0(1,i);
    vext(n1+npml1+1:n1e,i+npml2)=ones(npml1,1)*v0(n1,i);
end
for i=1:npml1             %Four horns
    for j=1:npml2
        vext(i,j)=v0(1,1);
        vext(i,n2+npml2+j)=v0(1,n2);
        vext(n1+npml1+i,j)=v0(n1,1);
        vext(n1+npml1+i,n2+npml2+j)=v0(n1,n2);
    end
end