%% Contact information:
% Wen Lei and Dr. Gang Li*
% Department of Marine Sciences
% Zhejiang University
% Email: gangli@zju.edu.cn or ligang0309@gmail.com
% 
%%
function f=power2(n)
data=[16 32 64 128 256 512 1024 2048 4096 8192 16384 32768];
for i=1:12
    if(n==data(i)|n<data(i))
        f=data(i);
        break
    end
end
return
