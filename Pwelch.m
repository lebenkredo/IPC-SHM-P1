clc
close all
clear all

c = cell2mat(struct2cell(load('3_24.mat')));
Y = c(:,1);
x = c(:,2);

subplot(3,2,1);
plot(x,Y);
dateaxis('x',15);
xlabel('Time');
ylabel('Value');

pxx3 = pwelch(Y,hamming(length(Y)),[],64,4);
subplot(3,2,3);
plot(pxx3);
xlabel('Frequency (Hz)');
ylabel('PSD');

pxx4 = pwelch(Y,hamming(length(Y)),[],512,256);
subplot(3,2,5);
autocorr(Y);
xlabel('Lag');
ylabel('Autocorelation');

t = 0:1/1000:1;
N = length(t);
fsig = 50;
signal = sin(2*pi*fsig*t);
fsig2 = 100;
signal2 = sin(2*pi*fsig2*t);
noise = 0.25*randn(1,N);
X = signal + signal2 + noise;

subplot(3,2,2);
plot(X);
xlabel('Time');
ylabel('Value');

pxx2 = pwelch(X,hamming(length(X)),[],128,256); %Welch metodu
subplot(3,2,4);
plot(pxx2);
xlabel('Frequency (Hz)');
ylabel('PSD');

subplot(3,2,6);
autocorr(X);
xlabel('Lag');
ylabel('Autocorelation');