%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
function amp=rickerfwt(nt,dt,f0)
pi=3.141592654;
t0=1.5*sqrt(6.)/(pi*f0);
pi=3.14159265;
da=pi*f0;
for i=1:nt
    t=(i-1)*dt;
    a=pi*f0*(t-t0);
    a2=(pi*f0*(t-t0)).^2;
    amp(i)=(1.-2.*a2)*exp(-a2);
end
return
