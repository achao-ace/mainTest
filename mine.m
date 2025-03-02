clear;
dataObtain;
%选择数据集大小
C=44484;
D=4449;

w=1;                  % w是滑动窗口的大小
s=24;                  % 选取前24小时的所有数据去预测未来一小时的数据
m = 44484;            %选取m个样本作训练集
n = 4449;             %选取n个样本作测试集

%输入训练数据
bothSensor = [trainIn11(1,1:C);trainIn12(1,1:C);trainIn13(1,1:C);trainIn14(1,1:C);trainIn15(1,1:C);trainIn16(1,1:C);trainIn17(1,1:C);
              trainIn21(1,1:C);trainIn22(1,1:C);trainIn23(1,1:C);trainIn24(1,1:C);trainIn25(1,1:C);trainIn26(1,1:C);trainIn27(1,1:C);
              trainIn31(1,1:C);trainIn32(1,1:C);trainIn33(1,1:C);trainIn34(1,1:C);trainIn35(1,1:C);trainIn36(1,1:C);trainIn37(1,1:C)];

bothSensor2 = [testIn11(1,1:D);testIn12(1,1:D);testIn13(1,1:D);testIn14(1,1:D);testIn15(1,1:D);testIn16(1,1:D);testIn17(1,1:D);
              testIn21(1,1:D);testIn22(1,1:D);testIn23(1,1:D);testIn24(1,1:D);testIn25(1,1:D);testIn26(1,1:D);testIn27(1,1:D);
              testIn31(1,1:D);testIn32(1,1:D);testIn33(1,1:D);testIn34(1,1:D);testIn35(1,1:D);testIn36(1,1:D);testIn37(1,1:D)];

[A,B]=size(bothSensor);



%输出数据（选择输出关节1-7）
labelRow  = trainOut1(1,1:C);
labelRow2  = testOut1(1,1:D);

% Create training testing and validation sets
%选择测试数据和训练数据大小
n = 10000;
m = 5000;

%选择训练数据
input_train=bothSensor(:,1:end);
output_train=labelRow(:,1:end);
input_test=bothSensor2(:,1:end);
output_test=labelRow2(:,1:end);

%% 数据归一化
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

input_test= mapminmax('apply',input_test,inputps);   %测试输入数据归一化
output_test= mapminmax('apply',output_test,outputps);

%% 获取输入层节点、输出层节点个数
inputnum=size(input_train,1);
outputnum=size(output_train,1);
disp('/////////////////////////////////')
disp('LSTM神经网络结构...')
disp(['输入层的节点数为：',num2str(inputnum)])
disp(['输出层的节点数为：',num2str(outputnum)])

numFeatures = inputnum;   %特征为一维
numResponses = outputnum;  %输出也是一维
numHiddenUnits1 = 30;   %创建LSTM回归网络，指定LSTM层的隐含单元个数。可调
layers = [ ...
    sequenceInputLayer(numFeatures)    %输入层
    lstmLayer(60)
    lstmLayer(60)
    fullyConnectedLayer(numResponses)    %为全连接层,是输出的维数。
    regressionLayer];      %其计算回归问题的半均方误差模块 。即说明这不是在进行分类问题。
 
%指定训练选项，求解器设置为adam， 1000轮训练。
%梯度阈值设置为 1。指定初始学习率 0.01，在 125 轮训练后通过乘以因子 0.2 来降低学习率。
options = trainingOptions('adam', ...
    'MaxEpochs',100, ...
    'GradientThreshold', 1, ...
    'InitialLearnRate',0.01, ...      
    'Verbose',0,  ...  %如果将其设置为true，则有关训练进度的信息将被打印到命令窗口中。默认值为true。
    'Shuffle','every-epoch', ...
    'Plots','training-progress');    %构建曲线图 将'training-progress'替换为none
net0 = trainNetwork(inputn,outputn,layers,options); 
an0 = predict(net0,input_test);  
%预测结果反归一化与误差计算
% test_simu0=mapminmax('reverse',an0,outputps); %把仿真得到的数据还原为原始的数量级
test_simu0=an0;
%误差指标
error0 = output_test - test_simu0;
Rmse0=sqrt(mse(output_test,test_simu0))
%% 标准LSTM神经网络作图
figure
plot(output_test,'b-','markerfacecolor',[0.5,0.5,0.9],'MarkerSize',6)
hold on
plot(test_simu0,'r--','MarkerSize',6)
title(['mse误差：',num2str(Rmse0)])
legend('真实y','预测的y')
xlabel('样本数')
ylabel('负荷值')

%% 
disp('采用LSTM-Adaboost方法进行预测')
K=10;   %Adaboost预测器的个数
%样本权重
[mm,nn]=size(inputn);
% mm=21;nn=44484;
d(1,:)=ones(1,nn)/nn;
for i=1:K
    disp(['第',num2str(i),'个弱分类器进行构建学习…………'])
    %弱预测器训练
    clear net
    options = trainingOptions('adam', ...
    'MaxEpochs',100, ...
    'GradientThreshold', 1, ...
    'InitialLearnRate',0.01, ...      
    'Verbose',0,  ...  %如果将其设置为true，则有关训练进度的信息将被打印到命令窗口中。默认值为true。
    'Shuffle','every-epoch', ...
    'Plots','none');    %构建曲线图 将'training-progress'替换为none
    net = trainNetwork(inputn,outputn,layers,options); 
    %弱预测器预测
    an1=predict(net,inputn);
    % LSTMoutput=mapminmax('reverse',an1,outputps);
    LSTMoutput=an1;

    %预测误差
    error(i,:)=output_train-LSTMoutput;
      
    %测试数据预测
    an=predict(net,input_test);
    % test_simu(i,:)=mapminmax('reverse',an,outputps);
    test_simu(i,:)=an;
    
    %调整D值
    weight(i) = 0;
    for j=1:nn
        if abs(error(i,j))>0.05%较大误差，这个值可以根据实际情况进行更改！就看弱分类器的预测值和实际值差多少，酌情更改
            weight(i) =weight(i)+d(i,j);
            d(i+1,j)=d(i,j)*1.1;
        else
            d(i+1,j)=d(i,j);
        end
    end
    %计算弱预测器权重
     weight(i) =0.5/exp(abs(weight(i)));
    %D值归一化
    d(i+1,:)=d(i+1,:)/sum(d(i+1,:)); 
end

%% 强预测器预测
weight = weight / sum(weight);
%% 结果统计
%强预测器效果
output=weight*test_simu;
err or=output_test-output;
MSE = mse(output_test,output)
RMSE=sqrt(MSE)
figure
plot(abs(error),'-*')
hold on
plot(abs(error0),'-or')
title('预测误差对比图','fontsize',12)
xlabel('预测样本','fontsize',12)
ylabel('误差绝对值','fontsize',12)
legend('LSTM-Adaboost强预测器预测','lstm预测器预测')

figure
plot(output_test,'b-.')
hold on
plot(test_simu0,'r')
hold on
plot(output,'g')
hold off
grid on
legend('真实值','LSTM预测值','Adaboost+LSTM预测值')
xlabel('样本编号')
ylabel('样本数据分类号')