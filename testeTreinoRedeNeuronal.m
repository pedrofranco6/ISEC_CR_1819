close all;clearvars;clc;

datasetTrainingDir = 'Imagens/Formas_2/';
datasetTestingDir = 'Imagens/Formas_3/';
netTrainAlgorithm = 1;
netLayers = [10];
numLayers = 1;
trainRatio = 70;
valRatio = 15;
testRatio = 15;
numRotations = 0;
imageSize = 20;
hogFeatures = 1;
boundaries = 1;

trainFunction = 'trainlm';
% 'trainlm' % Levenberg-Marquardt
% 'trainbr' % Bayesian Regularization
% 'trainbfg' % BFGS Quasi-Newton
% 'trainrp' % Resilient Backpropagation
% 'trainscg' % Scaled Conjugate Gradient
% 'traincgb' % Conjugate Gradient with Powell/Beale Restarts
% 'traincgf' % Fletcher-Powell Conjugate Gradient
% 'traincgp' % Polak-Ribiére Conjugate Gradient
% 'trainoss' % One Step Secant
% 'traingdx' % Variable Learning Rate Gradient Descent
% 'traingdm' % Gradient Descent with Momentum
% 'traingd' % Gradient Descent

actvFunc = {'poslin' 'poslin' 'poslin'};
% poslin
% tansig
% logsig
% radbas
% netinv
% hardlim
% compet
% purelin
% softmax
% tribas


disp('*** START ***');
tic
[trainingSet,targetTrainingSet] = datasetGenerator(datasetTrainingDir,numRotations,imageSize,hogFeatures,boundaries,0,'');
[testingSet,targetTestingSet] = datasetGenerator(datasetTestingDir,0,imageSize,hogFeatures,boundaries,0,'');
toc

fprintf('\n');
for t=1:10
    tic
    switch netTrainAlgorithm
        case 1
            net = feedforwardnet(netLayers,trainFunction);
        case 2
            net = fitnet(netLayers,trainFunction);
        case 3
            net = patternnet(netLayers,trainFunction);
        case 4
            net = cascadeforwardnet(netLayers,trainFunction);
    end
    
    net.divideParam.trainRatio = trainRatio;
    net.divideParam.valRatio = valRatio;
    net.divideParam.testRatio = testRatio;
    
    for i=1:numLayers
        net.layers{i}.transferFcn = actvFunc{i};
    end
    
    disp(strcat('Rede:',num2str(t)));
    net = train(net,trainingSet,targetTrainingSet);
    
    precisaoTreino=100-perform(net,targetTrainingSet,net(trainingSet));
    disp(strcat('Precisao Treino:',num2str(precisaoTreino)));
    
    precisaoTeste=100-perform(net,targetTestingSet,net(testingSet));
    disp(strcat('Precisao Teste:',num2str(precisaoTeste)));
    
    fprintf('\n');
    toc
end
disp('*** END ***');
