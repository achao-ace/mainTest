clear 
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
labelRow  = trainOut1(1,1:C);
labelRow2  = testOut1(1,1:D);

% Create training testing and validation sets
%选择测试数据和训练数据大小
n = 10000;
m = 5000;

%选择训练数据
xTrain = bothSensor(:,1:end);
yTrain = labelRow(:,1:end);

[xTrain,inputps]=mapminmax(xTrain);          %输入数据归一化处理
[yTrain,outputps]=mapminmax(yTrain);     %输出数据归一化处理

%选择验证数据
XValidation = bothSensor(:,end-m+1:end);
YValidation = labelRow(:,end-m+1:end);

%选择测试数据
xTest = bothSensor2(:,1:end);
yTest = labelRow2(:,1:end);

xTest= mapminmax('apply',xTest,inputps);   %测试输入数据归一化
yTest= mapminmax('apply',yTest,outputps);

layers = [
        sequenceInputLayer(21)
        lstmLayer(58)
        lstmLayer(78)
        fullyConnectedLayer(1)
        regressionLayer];
    options = trainingOptions('adam', ...
        'MaxEpochs',186, ...
        'MiniBatchSize',128, ...
        'InitialLearnRate',0.0034, ...
        'GradientThreshold',1, ...
        'Shuffle','every-epoch', ...
        'Verbose',false);

%Train the model
net = trainNetwork(xTrain,yTrain,layers,options);
% net=fitrnet(XTrain,YTrain,"LayerSizes",[100,100],'Activations','tanh');

%Evaluate Model
% prediction = classify(net,XTest);
YPred = predict(net,xTest,'MiniBatchSize',1);
% lstmYPred= mapminmax('reverse',YPred2,outputps);   %网络预测数据反归一化
lstmYPred=YPred;
lstmerr2=lstmYPred-yTest;

%计算误差，输出结果
sumerr=0;
sumout=0;
for i=1:1:length(lstmerr2)
    sumerr=sumerr+lstmerr2(i)*lstmerr2(i);
    sumout=sumout+yTest(i)*yTest(i);
end
LSTM_MSE=sumerr/length(lstmerr2)
LSTM_RMSE=sqrt(sumerr/length(lstmerr2))
LSTM_relE=sqrt(sumerr/sumout)

plot(lstmYPred);
hold on;
plot(yTest);