clear all;
close all;
clc;

datasetTrainingDir = 'Imagens/Formas_2/';
datasetTestingDir = 'Imagens/Formas_3/';
numRotations = 0;
imageSize = 20;
hogFeatures = 1;
boundaries = 0;
% hogFeaturesStrongest = 0;
% wantedCornerPoints = 5;

% TRAINING SETS

% trainingSet = [];
% tempImage = medfilt2(imread('Imagens/Formas_2/circle/107.png'),[8 8],'symmetric');
% strongest = selectStrongest(detectHarrisFeatures(tempImage),wantedCornerPoints);
% disp(strongest.Count);
% teste = reshape(extractHOGFeatures(tempImage,strongest,'CellSize',[8 8]),1,[]);
% asd = zeros(1,(wantedCornerPoints-strongest.Count)*36);
% teste = [teste asd];
% % hogFeaturesArray = [hogFeaturesArray zeros((wantedCornerPoints-strongest.Count)*36)];
% trainingSet = vertcat(trainingSet,asd);

% if hogFeaturesStrongest
%     tempImage = medfilt2(imread(circleImageDatabase.ImageLocation{i}),[8 8],'symmetric');
%     strongest = selectStrongest(detectHarrisFeatures(tempImage),wantedCornerPoints);
%     hogFeaturesArray = reshape(extractHOGFeatures(tempImage,strongest,'CellSize',[8 8]),1,[]);
%     hogFeaturesArray = [hogFeaturesArray zeros(1,(wantedCornerPoints-strongest.Count)*36)];
%     trainingSet = vertcat(trainingSet,hogFeaturesArray);
% end

% % TEST SETS
% testSet = [];
% targetTestSet = [];
tic
[trainingSet,targetTrainingSet] = datasetGenerator(datasetTrainingDir,numRotations,imageSize,hogFeatures,boundaries);
[testingSet,targetTestingSet] = datasetGenerator(datasetTestingDir,numRotations,imageSize,hogFeatures,boundaries);
toc

net = feedforwardnet(10);
% net = patternnet(10);
net = train(net,trainingSet,targetTrainingSet);
out=sim(net,testingSet);

r=0;
for i=1:length(out)
    a = out(i);
    b = targetTestingSet(i);
    if abs(a-b) < 0.01
        r = r+1;
    end
end

precisao = r/length(out)*100
