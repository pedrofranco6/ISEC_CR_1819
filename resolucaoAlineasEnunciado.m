clear all;
close all;
clc;

% Alinea a)
% [trainingSet,targetTrainingSet] = datasetGenerator('Imagens/Formas_1/',0,20,0,0,0,'');
% 
% numLayers = 2;
% actvFunc = {'poslin' 'poslin' 'hardlim'};
% % actvFunc = {'logsig' 'poslin' 'tribas'};
% % actvFunc = {'softmax' 'radbas' 'poslin'};
% % actvFunc = {'hardlim' 'compet' 'poslin'};
% % actvFunc = {'netinv' 'logsig' 'poslin'};
% 
% net = feedforwardnet([10],'trainlm');
% % net = feedforwardnet([10 10],'trainbr');
% % net = feedforwardnet([10 10],'trainscg');
% % net = feedforwardnet([10 10],'trainoss');
% % net = feedforwardnet([10 10],'traingdm');
% % view(net)
% 
% for i=1:numLayers
%     net.layers{i}.transferFcn = actvFunc{i};
% end
% 
% net = train(net,trainingSet,targetTrainingSet);
% precisaoTreino=100-perform(net,targetTrainingSet,net(trainingSet));
% disp(strcat('Precisao Treino: ',num2str(precisaoTreino)));

% ----------------------------------------------------------------------------------- %
% Alinea b)
[trainingSet,targetTrainingSet] = datasetGenerator('Imagens/Formas_2/',0,20,0,1,0,'');

numLayers = 2;
actvFunc = {'poslin' 'poslin' 'hardlim'};
% actvFunc = {'logsig' 'poslin' 'tribas'};
% actvFunc = {'softmax' 'radbas' 'poslin'};
% actvFunc = {'hardlim' 'compet' 'poslin'};
% actvFunc = {'netinv' 'logsig' 'poslin'};

net = feedforwardnet([10],'trainlm');
% net = feedforwardnet([10 10],'trainbr');
% net = feedforwardnet([10 10],'trainscg');
% net = feedforwardnet([10 10],'trainoss');
% net = feedforwardnet([10 10],'traingdm');
% view(net)

for i=1:numLayers
    net.layers{i}.transferFcn = actvFunc{i};
end

net.divideParam.trainRatio = 65;
net.divideParam.valRatio = 20;
net.divideParam.testRatio = 15;

net = train(net,trainingSet,targetTrainingSet);
precisaoTreino=100-perform(net,targetTrainingSet,net(trainingSet));
disp(strcat('Precisao Treino: ',num2str(precisaoTreino)));

% ----------------------------------------------------------------------------------- %
% Alinea c)
% [testSet,targetTestSet] = datasetGenerator('Imagens/Formas_3/',0,20,0,1,0,'');
% 
% precisaoTest=100-perform(net,targetTestSet,net(testSet));
% disp(strcat('Precisao Teste: ',num2str(precisaoTest)));
% 
% net = train(net,testSet,targetTestSet);
% precisaoTreinoTeste=100-perform(net,targetTrainingSet,net(trainingSet));
% disp(strcat('Precisao Treino com exemplos de Teste: ',num2str(precisaoTreino)));

% ----------------------------------------------------------------------------------- %
% Alinea d)

for i=1:6
    disp(strcat('Imagem: ',num2str(i)));

    importeImage = imread(strcat('Imagens/imagens_teste/Screenshot_',num2str(i),'.png'));
    processedImage = extractHOGFeatures(imageProcesser(importeImage(:, :, 2),20,0,0));
    sim(net,processedImage(:))
    
    fprintf('\n');
end
