t = [0  20  40  60  120  180  300];

CAm = [10  8  6  5  3  2  1];

% 用最小二乘样条拟合法计算微分dCA/dt--使用不经过实验点的B样条插值函数

knots = 3;

K = 3;                  % 三次B样条

sp = spap2(knots,K,t,CAm);

pp = fnder(sp);         % 计算B样条函数的导函数

dCAdt = fnval(pp,t)    % 计算t处的导函数值

rAm = dCAdt;

% 绘制浓度拟合曲线

ti = linspace(t(1),t(end),200);

CAi = fnval(sp,ti);

plot(t,CAm,'ro',ti,CAi,'b-')

xlabel('t')

ylabel('C_A')

legend('实验值','B样条拟合')

% 非线性拟合

beta0 = [0.0053 1.39];

[beta,resnorm,residual,exitflag,output,lambda,jacobian] = ...

lsqnonlin(@OptObjFunc,beta0,[],[],[],rAm,CAm);

ci = nlparci(beta,residual,jacobian);

% 参数辨识结果

fprintf('Estimated Parameters:\n')

fprintf('\tk = %.4f ± %.4f\n',beta(1),ci(1,2)-beta(1))

fprintf('\tn = %.2f ± %.2f\n',beta(2),ci(2,2)-beta(2))

fprintf('  The sum of the squares is: %.1e\n\n',sum(residual.^2))

% 绘制反应速率拟合曲线

figure

plot(t,rAm,'ro',t,Rate(CAm,beta),'b*')

xlabel('t')

ylabel('dC_Adt')

legend('Experiment','Kinetic Model')

% ------------------------------------------------------------------

function f = OptObjFunc(beta,rAm,CAm)

rAc = Rate(CAm,beta);

f = rAc - rAm;

% ------------------------------------------------------------------

function rA = Rate(CA,beta)

rA = -beta(1)*CA.^beta(2);   % -rA = -dCA/dt = k*CA^n, 其中k=beta(1), n=beta(2)，