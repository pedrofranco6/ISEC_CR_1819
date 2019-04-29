close all;clearvars;clc;

datasetTrainingDir = 'Imagens/Formas_2/';
datasetTestingDir = 'Imagens/Formas_3/';
numRotations = 4;
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

tic
[trainingSet,targetTrainingSet] = datasetGenerator(datasetTrainingDir,numRotations,imageSize,hogFeatures,boundaries);
[testingSet,targetTestingSet] = datasetGenerator(datasetTestingDir,0,imageSize,hogFeatures,boundaries);
toc

fprintf('\n');
tic
for t=1:10
%     net = feedforwardnet((10),trainFunction);
    net = fitnet(10,trainFunction);
%     net = patternnet(10,trainFunction);
%     net = cascadeforwardnet(10,trainFunction);
    
    disp(strcat('Rede:',num2str(t)));
    net = train(net,trainingSet,targetTrainingSet);
    
    precisaoTreino=100-perform(net,targetTrainingSet,net(trainingSet));
    disp(strcat('Precisao Treino:',num2str(precisaoTreino)));
    
    precisaoTeste=100-perform(net,targetTestingSet,net(testingSet));
    disp(strcat('Precisao Teste:',num2str(precisaoTeste)));
    
    fprintf('\n');
end
toc
