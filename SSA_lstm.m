clear;
dataObtain;
%选择数据集大小
C=44484;
D=4449;

%输入训练数据
bothSensor = [trainIn11(1,1:C);trainIn12(1,1:C);trainIn13(1,1:C);trainIn14(1,1:C);trainIn15(1,1:C);trainIn16(1,1:C);trainIn17(1,1:C);
              trainIn21(1,1:C);trainIn22(1,1:C);trainIn23(1,1:C);trainIn24(1,1:C);trainIn25(1,1:C);trainIn26(1,1:C);trainIn27(1,1:C);
              trainIn31(1,1:C);trainIn32(1,1:C);trainIn33(1,1:C);trainIn34(1,1:C);trainIn35(1,1:C);trainIn36(1,1:C);trainIn37(1,1:C)];

bothSensor2 = [testIn11(1,1:D);testIn12(1,1:D);testIn13(1,1:D);testIn14(1,1:D);testIn15(1,1:D);testIn16(1,1:D);testIn17(1,1:D);
              testIn21(1,1:D);testIn22(1,1:D);testIn23(1,1:D);testIn24(1,1:D);testIn25(1,1:D);testIn26(1,1:D);testIn27(1,1:D);
              testIn31(1,1:D);testIn32(1,1:D);testIn33(1,1:D);testIn34(1,1:D);testIn35(1,1:D);testIn36(1,1:D);testIn37(1,1:D)];

[A,B]=size(bothSensor);



%输出数据（选择输出关节1-7）
labelRow  = trainOut7(1,1:C);
labelRow2  = testOut7(1,1:D);

% Create training testing and validation sets
%选择测试数据和训练数据大小
n = 10000;
m = 5000;

%选择训练数据
P_train=bothSensor(:,1:end);
T_train=labelRow(:,1:end);
P_test=bothSensor2(:,1:end);
T_test=labelRow2(:,1:end);

[p_train,inputps]=mapminmax(P_train);          %输入数据归一化处理
[t_train,outputps]=mapminmax(T_train);     %输出数据归一化处理

% [p_train, ps_input] = mapminmax(P_train);
% p_test = mapminmax('apply', P_test, ps_input);

p_test= mapminmax('apply',P_test,inputps);   %测试输入数据归一化
t_test= mapminmax('apply',T_test,outputps);

% [t_train, ps_output] = mapminmax(T_train);
% t_test = mapminmax('apply', T_test, ps_output);

%% 采用ssa优化
[x ,fit_gen,process]=ssaforlstm(p_train,t_train,p_test,t_test);%分别对隐含层节点 训练次数与学习率寻优

%% 画适应度曲线
plfit(fit_gen,'SSA')
disp('优化的超参数为：')
disp('L1:'),x(1)
disp('L2:'),x(2)
disp('K:'),x(3)
disp('lr:'),x(4)

%% 利用优化得到的参数重新训练
train=0;%是否重新训练
    rng(0)
    numFeatures = size(p_train,1);%输入节点数
    numResponses = size(t_train,1);%输出节点数
    miniBatchSize = 128; %batchsize
    numHiddenUnits1 = x(1);
    numHiddenUnits2 = x(2);
    maxEpochs=x(3);
    learning_rate=x(4);
 layers = [...
        sequenceInputLayer(21)
        lstmLayer(numHiddenUnits1)
        lstmLayer(numHiddenUnits2)
        fullyConnectedLayer(1)
        regressionLayer];
    options = trainingOptions('adam', ...
        'MaxEpochs',maxEpochs, ...
        'MiniBatchSize',miniBatchSize, ...
        'InitialLearnRate',learning_rate, ...
        'GradientThreshold',1, ...
        'Shuffle','every-epoch', ...
        'Verbose',false);

net = trainNetwork(p_train,t_train,layers,options);

%% 训练集误差评价
% 预测
YPredtr = predict(net,p_train,"MiniBatchSize",numFeatures);
% 结果
t_sim1 =double(YPredtr');
% 反归一化
CNNLSTMoutput_tra=t_sim1;%mapminmax('reverse',t_sim1,ps_output);
T_sim1=double(CNNLSTMoutput_tra);
%% 测试集误差评价
% 预测
YPred = predict(net,p_test,"MiniBatchSize",numFeatures);
% 结果
t_sim2=double(YPred');
% 反归一化
CNNLSTMoutput_test=t_sim2;%mapminmax('reverse',t_sim2,ps_output);
T_sim2=double(CNNLSTMoutput_test);
err=YPred-t_test;
% toc
%% 训练集误差评价
%%  均方根误差
sumerr=0;
sumout=0;
for i=1:1:length(err)
    sumerr=sumerr+err(i)*err(i);
    sumout=sumout+t_test(i)*t_test(i);
end
LSTM_MSE=sumerr/length(err)
LSTM_RMSE=sqrt(sumerr/length(err))
LSTM_relE=sqrt(sumerr/sumout)

plot(YPred);
hold on;
plot(t_test);

mape=mean(abs((t_test-YPred)./t_test));
disp(['平均相对百分误差（MAPE）：',num2str(mape*100),'%'])
[r2 ,rmse] =r2_rmse(t_test,YPred);
disp(['拟合优度（r2）：',num2str(r2),'%'])
fprintf('\n')
% 
% %
% figure
% plot(true_value,'-s','Color',[0 0 255]./255,'linewidth',1,'Markersize',5,'MarkerFaceColor',[0 0 255]./255)
% hold on
% plot(predict_value,'-o','Color',[0 0 0]./255,'linewidth',0.8,'Markersize',4,'MarkerFaceColor',[0 0 0]./255)
% legend('实际值','预测值')
% grid on
% title('SSA-LSTM模型预测结果')
% legend('真实值','预测值')
% xlabel('样本')
% ylabel('预测值')
% 
% figure
% bar((predict_value - true_value))   
% legend('SSA-LSTM模型测试集误差')
% title('SSA-LSTM模型测试集误差')
% ylabel('误差','fontsize',10)
% xlabel('样本','fontsize',10)

