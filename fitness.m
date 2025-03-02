function y=fitness(x,p,t,pt,tt)
rng(0)
% numFeatures = size(p,1);%����ڵ���
% numResponses = size(t,1);%����ڵ���
miniBatchSize = 128; %batchsize
numHiddenUnits1 = x(1);
numHiddenUnits2 = x(2);
maxEpochs=x(3);
learning_rate=x(4);
% FiltZise=x(4);

% layers = [ ...
%     sequenceInputLayer(numFeatures)
%     bilstmLayer(numHiddenUnits1)
%     bilstmLayer(numHiddenUnits2)
%     fullyConnectedLayer(numResponses)
%     regressionLayer];
% lg = layerGraph();
% lg = addLayers(lg, [
%     sequenceInputLayer(21, "Name", "input")
%     gruLayer( numHiddenUnits1, 'OutputMode', 'sequence', ...
%         "Name", "gru1")
%     concatenationLayer(1, 2, "Name", "cat1")
%     gruLayer( numHiddenUnits1, 'OutputMode', 'sequence', ...
%         "Name", "gru3")
%     concatenationLayer(1, 2, "Name", "cat2")
%     fullyConnectedLayer(1)
%     regressionLayer] );
% lg = addLayers( lg, [
%     FlipLayer("flip1")
%     gruLayer( numHiddenUnits2, 'OutputMode', 'sequence', ...
%         "Name", "gru2" )
%     FlipLayer("flip2")] );
% lg = addLayers(lg, [
%     FlipLayer("flip3")
%     gruLayer( numHiddenUnits2, 'OutputMode', 'sequence', ...
%         "Name", "gru4" )] );
% lg = connectLayers(lg, "input", "flip1");
% lg = connectLayers(lg, "flip2", "cat1/in2");
% lg = connectLayers(lg, "cat1", "flip3");
% lg = connectLayers(lg, "gru4", "cat2/in2");
FiltZise = 10;
% layers = [...
%         % ��������
%         sequenceInputLayer([21 1 1],'Name','input')
%         sequenceFoldingLayer('Name','fold')
%         % CNN������ȡ
%         convolution2dLayer([FiltZise 1],32,'Padding','same','WeightsInitializer','he','Name','conv','DilationFactor',1);
%         batchNormalizationLayer('Name','bn')
%         eluLayer('Name','elu')
%         averagePooling2dLayer(1,'Stride',FiltZise,'Name','pool1')
%         % չ����
%         sequenceUnfoldingLayer('Name','unfold')
%         % ƽ����
%         flattenLayer('Name','flatten')
%         % LSTM����ѧϰ
%         lstmLayer(numHiddenUnits1,'Name','lstm1','RecurrentWeightsInitializer','He','InputWeightsInitializer','He')
%         % LSTM���
%         lstmLayer(numHiddenUnits2,'OutputMode',"last",'Name','bil4','RecurrentWeightsInitializer','He','InputWeightsInitializer','He')
%         dropoutLayer(0.25,'Name','drop3')
%         % ȫ���Ӳ�
%         fullyConnectedLayer(1,'Name','fc')
%         regressionLayer('Name','output')    ];
% 
%     layers = layerGraph(layers);
%     layers = connectLayers(layers,'fold/miniBatchSize','unfold/miniBatchSize');
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


net = trainNetwork(p,t,layers,options);

YPred = predict(net,pt,'MiniBatchSize',1);
% YPred=double(YPred);
predict_value=YPred;%mapminmax('reverse',YPred,outputps);
y =mse(predict_value-tt);
% ��mseΪ��Ӧ�Ⱥ������Ż��㷨Ŀ�ľ����ҵ�һ�鳬���� ʹ�����mse���
rng((100*sum(clock)))

