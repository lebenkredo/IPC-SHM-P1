clc
close all
clear all
t = 0:1/1000:2;
N = length(t);
fsig = 50;
signal = sin(2*pi*fsig*t);
fsig2 = 140;
signal2 = sin(2*pi*fsig2*t);
noise = 2*randn(1,N);
x = signal + signal2 + noise;
x = triang(64);

pxx1 = periodogram(x,triang(64),[],64);
subplot(4,1,1);
plot(pxx1);
xlabel('Frequency (Hz)');
ylabel('PSD');

pxx2 = periodogram(x,triang(64),[],128);
subplot(4,1,2);
plot(pxx2);
xlabel('Frequency (Hz)');
ylabel('PSD');

pxx3 = periodogram(x,triang(64),[],256);
subplot(4,1,3);
plot(pxx3);
xlabel('Frequency (Hz)');
ylabel('PSD');

pxx4 = periodogram(x,triang(64),[],512);
subplot(4,1,4);
plot(pxx4);
xlabel('Frequency (Hz)');
ylabel('PSD')

