%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
function vext=vext(n1,n2,v,v0)
n1e=n1+2; n2e=n2+2;
for i=1:n1
    for j=1:n2
        vext(j*n1e+i+1)=v((j-1)*n1+i);
    end
end
for i=1:n1
    vext(i+1)=v0(i);
    vext((n2+1)*n1e+i+1)=v0((n2-1)*n1+i);
end
for i=1:n2
    vext(i*n1e+1)=v0((i-1)*n1+1);
    vext((i+1)*n1e)=v0(i*n1);
end
vext(1)=v0(1);
vext((n2+1)*n1e+1)=v0((n2-1)*n1+1);
vext(n1e)=v0(n1);
vext(n1e*n2e)=v0(n1*n2);
