%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
% idb: build (1) or not (0) damping function for the staggered grid
% itd: type of damping function (1: polynomial else cosinus)
% alphad: add a constant to the xi function
% betad: add an imaginary part to the frequency
function [d]=damp2(n,npml,h,a,w,v,fo)

% % values of damp and dampn outside PML (equal to 1)
pi=3.14159265;
pi2=pi*3*3/(10*h);
b1=0.95*fo;
ci=1i;

for i=1:n+2
    d(i)=1;
end

xpml=npml*h;
xmax=(n-1)*h;
for i=1:npml
    x=(i-1)*h;
    sig=pi2*((xpml-x)/xpml)*((xpml-x)/xpml)*v(i);
    
    bit=b1*(1-(((xpml-x)/xpml)));
    
    
    d(i+1)=1/(1+(sig/(bit+ci*w)));
    
    d(n-i+2)=d(i+1);
end
d(1)=d(2);
d(n+2)=d(n+1);


%% values of damp and dampn outside cos PML (equal to 1)
% pi=3.14159265;
% pi2=pi/2;
% ci=1i;
% 
% 
% for i=1:n+2
%     d(i)=1;
% end
% 
% xpml=npml*h;
% 
% xmax=(n-1)*h;
% for i=1:npml
%     x=(i-1)*h;
%     
%     %            eps=a*(1-cos((xpml-x)*pi2/xpml));
%     
%     eps=a*(cos(x*pi2/xpml));
%     
%     d(i+1)=1/(1-ci*eps/w);
%     d(n-i+2)=d(i+1);
% end
% d(1)=d(2);
% d(n+2)=d(n+1);

return

