c = cell2mat(struct2cell(load('3_24.mat')));
Y = c(:,1);
X = c(:,2);
y = log(Y);
T = length(y);
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% 初步模型设定
Mdl = arima('Constant',0,'D',1,'Seasonality',120,...
              'MALags',4,'SMALags',120);
% 模型参数估计          
EstMdl = estimate(Mdl,y);
% 残差估计
res = infer(EstMdl,y);
stres = res/sqrt(EstMdl.Variance);
% 残差检验图
figure
subplot(1,2,1)
qqplot(stres)
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% 正态图观测
x = -4:.05:4;
[f,xi] = ksdensity(stres);
subplot(1,2,2)
plot(xi,f,'k','LineWidth',2);
hold on
plot(x,normpdf(x),'r--','LineWidth',2)
legend('Standardized Residuals','Standard Normal')
hold off
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% 相关图分析
figure
subplot(2,1,1)
autocorr(stres)
subplot(2,1,2)
parcorr(stres)
% 残差合理性检验
[h,p] = lbqtest(stres,'lags',[5,10,15],'dof',[3,8,13]);
y1 = y(1:1200);
y2 = y(1200:end);
% 预测模型建立
Mdl1 = estimate(Mdl,y1);
yF1  = forecast(Mdl1,241,'Y0',y1);
pmse = mean((y2-yF1(1:end)).^2);
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
figure
plot(X,exp(y),'b--','LineWidth',1.5)
hold on
plot(X(1200:1440),exp(yF1),'r--','LineWidth',1.5)
axis tight
dateaxis('X',15);
xlabel('Time');
ylabel('Value');
title('SARIMA预测曲线')
legend('真实值','预测值','Location','NorthWest')
hold off