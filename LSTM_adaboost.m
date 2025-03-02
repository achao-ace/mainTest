clear
close all
clc
data =  readmatrix('data.csv');
data = data(:,2:10);
w=1;                  % w是滑动窗口的大小
s=24;                  % 选取前24小时的所有数据去预测未来一小时的数据
m = 1200;            %选取m个样本作训练集
n = 200;             %选取n个样本作测试集
input_train=[];    %选取1月1日-1月10日，1月2日-1月11日，1月3日-1月12日…………3月1日到3月10日的数据作为训练集的输入
for i =1:m
    xx = data(1+w*(i-1):w*(i-1)+s,:);
    xx =xx(:);
    input_train = [input_train,xx];
end
output_train =[];  %选取1月11日，1月12日，1月13日…………3月11日的数据作为训练集的输出
output_train = data(2:m+1,1)';

input_test=[];  %选取3月2日到3月11日的数据作为测试集的输入
for i =m+1:m+n
    xx = data(1+w*(i-1):w*(i-1)+s,:);
    xx =xx(:);
    input_test = [input_test,xx];
end
output_test = data(m+2:m+n+1,1)';

%% 数据归一化
[inputn,inputps]=mapminmax(input_train,0,1);
[outputn,outputps]=mapminmax(output_train);
inputn_test=mapminmax('apply',input_test,inputps);
%% 获取输入层节点、输出层节点个数
inputnum=size(input_train,1);
outputnum=size(output_train,1);
disp('/////////////////////////////////')
disp('LSTM神经网络结构...')
disp(['输入层的节点数为：',num2str(inputnum)])
disp(['输出层的节点数为：',num2str(outputnum)])

numFeatures = inputnum;   %特征为一维
numResponses = outputnum;  %输出也是一维
numHiddenUnits1 = 25;   %创建LSTM回归网络，指定LSTM层的隐含单元个数。可调
layers = [ ...
    sequenceInputLayer(numFeatures)    %输入层
    lstmLayer(numHiddenUnits1, 'OutputMode', 'sequence')
    fullyConnectedLayer(numResponses)    %为全连接层,是输出的维数。
    regressionLayer];      %其计算回归问题的半均方误差模块 。即说明这不是在进行分类问题。
 
%指定训练选项，求解器设置为adam， 1000轮训练。
%梯度阈值设置为 1。指定初始学习率 0.01，在 125 轮训练后通过乘以因子 0.2 来降低学习率。
options = trainingOptions('adam', ...
    'MaxEpochs',10, ...
    'GradientThreshold', 1, ...
    'InitialLearnRate',0.01, ...      
    'LearnRateSchedule','piecewise', ...%每当经过一定数量的时期时，学习率就会乘以一个系数。
    'LearnRateDropFactor', 0.01, ...
    'LearnRateDropPeriod',600, ...      %乘法之间的纪元数由" LearnRateDropPeriod"控制。可调
    'Verbose',0,  ...  %如果将其设置为true，则有关训练进度的信息将被打印到命令窗口中。默认值为true。
    'Plots','training-progress');    %构建曲线图 将'training-progress'替换为none
net0 = trainNetwork(inputn,outputn,layers,options); 
an0 = predict(net0,inputn_test);  
%预测结果反归一化与误差计算
test_simu0=mapminmax('reverse',an0,outputps); %把仿真得到的数据还原为原始的数量级
%误差指标
error0 = output_test - test_simu0;
mse0=mse(output_test,test_simu0)
%% 标准LSTM神经网络作图
figure
plot(output_test,'b-','markerfacecolor',[0.5,0.5,0.9],'MarkerSize',6)
hold on
plot(test_simu0,'r--','MarkerSize',6)
title(['mse误差：',num2str(mse0)])
legend('真实y','预测的y')
xlabel('样本数')
ylabel('负荷值')

%% 
disp('采用LSTM-Adaboost方法进行预测')
K=10;   %Adaboost预测器的个数
%样本权重
[mm,nn]=size(inputn);
D(1,:)=ones(1,nn)/nn;
for i=1:K
    disp(['第',num2str(i),'个弱分类器进行构建学习…………'])
    %弱预测器训练
    clear net
    options = trainingOptions('adam', ...
    'MaxEpochs',100, ...
    'GradientThreshold', 1, ...
    'InitialLearnRate',0.01, ...      
    'LearnRateSchedule','piecewise', ...%每当经过一定数量的时期时，学习率就会乘以一个系数。
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod',600, ...      %乘法之间的纪元数由" LearnRateDropPeriod"控制。可调
    'Verbose',0,  ...  %如果将其设置为true，则有关训练进度的信息将被打印到命令窗口中。默认值为true。
    'Plots','none');    %构建曲线图 将'training-progress'替换为none
    net = trainNetwork(inputn,outputn,layers,options); 
    %弱预测器预测
    an1=predict(net,inputn);
    LSTMoutput=mapminmax('reverse',an1,outputps);
    
    %预测误差
    error(i,:)=output_train-LSTMoutput;
      
    %测试数据预测
    an=predict(net,inputn_test);
    test_simu(i,:)=mapminmax('reverse',an,outputps);
    
    %调整D值
    weight(i) = 0;
    for j=1:nn
        if abs(error(i,j))>0.3%较大误差，这个值可以根据实际情况进行更改！就看弱分类器的预测值和实际值差多少，酌情更改
            weight(i) =weight(i)+D(i,j);
            D(i+1,j)=D(i,j)*1.1;
        else
            D(i+1,j)=D(i,j);
        end
    end
    %计算弱预测器权重
     weight(i) =0.5/exp(abs(weight(i)));
    %D值归一化
    D(i+1,:)=D(i+1,:)/sum(D(i+1,:)); 
end

%% 强预测器预测
weight = weight / sum(weight);
%% 结果统计
%强预测器效果
output=weight*test_simu;
error=output_test-output;
MSE = mse(output_test,output)
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