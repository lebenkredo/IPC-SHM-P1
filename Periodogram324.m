clc
clear
c = cell2mat(struct2cell(load('per.mat')));
x = c(:,1);

pxx1 = periodogram(x,hamming(length(x)),[],64);
plot(pxx1);
xlabel('Frequency (Hz)');
ylabel('PSD');

