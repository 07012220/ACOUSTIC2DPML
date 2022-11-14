function [D]=balance_trace(d)
% Balancing traces in the trace or time direction
% Author: Yutao LIU
% Science & Technology on Integrated Information System Laboratory, Institute of Software, Chinese Academy of Sciences, Beijing, China
% E-mail:  yutao_liu2022@163.com


[ntime,ntrace]=size(d);
D=zeros(ntime,ntrace);

allmax1=max(max(d));                                                        %Trace direction
for j=1:ntrace
    pertime_max1=max(d(:,j));
    D(:,j)=d(:,j)/pertime_max1*allmax1;
end


% allmax=max(max(D));                                                         %Time direction
% for i=1:ntime
%     pertime_max=max(D(i,:));
%     D(i,:)=D(i,:)/pertime_max*allmax;
% end



