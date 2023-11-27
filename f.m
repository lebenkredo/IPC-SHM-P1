f1=0.1;f2=0.13;
N=input('请选择采样点数 N:');
n=1:N;
xn=2*sin(2*pi*fl*ntpi/3)+10*sin(2*pi*f2*n+pi/4);
%dft
Xk=abs(fft(xn));
%求模平方
k=1:N;
A=k/N;
Sx=Xk.^2/N;
plot(fSx);
axis([0 0.25,-inf inf]);
title('功率谱');
xlabel('f');ylabel('Sx'),
%估计 f1,f2
sxk=zeros(1,N/2);
for k=1:N/2
sxk(k)-Sx(k);
end
[pks,locs] = findpeaks(sxk,SortStr,descend);%寻峰并降序排列for i = 1:2