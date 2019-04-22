clear all;
close all;
clc;

hogFeatures = 1;
wantedImageSize = 20;

% TRAINING SETS
circleImageDatabase = imageSet('Imagens/Formas_2/circle','recursive');
squareImageDatabase = imageSet('Imagens/Formas_2/square','recursive');
starImageDatabase = imageSet('Imagens/Formas_2/star','recursive');
triangleImageDatabase = imageSet('Imagens/Formas_2/triangle','recursive');

trainingSet = [];
targetTrainingSet = [];
for i=1:circleImageDatabase.Count
    if hogFeatures
        trainingSet = vertcat(trainingSet,extractHOGFeatures(imageProcesser(imread(circleImageDatabase.ImageLocation{i}), wantedImageSize)));
    else
        trainingSet = vertcat(trainingSet,reshape(imageProcesser(imread(circleImageDatabase.ImageLocation{i}), wantedImageSize),1,wantedImageSize*wantedImageSize));
    end
    targetTrainingSet = vertcat(targetTrainingSet, [1 0 0 0]);
end
for i=1:squareImageDatabase.Count
    if hogFeatures
        trainingSet = vertcat(trainingSet,extractHOGFeatures(imageProcesser(imread(squareImageDatabase.ImageLocation{i}), wantedImageSize)));
    else
        trainingSet = vertcat(trainingSet,reshape(imageProcesser(imread(squareImageDatabase.ImageLocation{i}), wantedImageSize),1,wantedImageSize*wantedImageSize));
    end
    targetTrainingSet = vertcat(targetTrainingSet, [0 1 0 0]);
end
for i=1:starImageDatabase.Count
    if hogFeatures
        trainingSet = vertcat(trainingSet,extractHOGFeatures(imageProcesser(imread(starImageDatabase.ImageLocation{i}), wantedImageSize)));
    else
        trainingSet = vertcat(trainingSet,reshape(imageProcesser(imread(starImageDatabase.ImageLocation{i}), wantedImageSize),1,wantedImageSize*wantedImageSize));
    end
    targetTrainingSet = vertcat(targetTrainingSet, [0 0 1 0]);
end
for i=1:triangleImageDatabase.Count
    if hogFeatures
        trainingSet = vertcat(trainingSet,extractHOGFeatures(imageProcesser(imread(triangleImageDatabase.ImageLocation{i}), wantedImageSize)));
    else
        trainingSet = vertcat(trainingSet,reshape(imageProcesser(imread(triangleImageDatabase.ImageLocation{i}), wantedImageSize),1,wantedImageSize*wantedImageSize));
    end
    targetTrainingSet = vertcat(targetTrainingSet, [0 0 0 1]);
end
trainingSet = transpose(trainingSet);
targetTrainingSet = transpose(targetTrainingSet);

% TEST SETS
circleTestImageDatabase = imageSet('Imagens/Formas_3/circle','recursive');
squareTestImageDatabase = imageSet('Imagens/Formas_3/square','recursive');
starTestImageDatabase = imageSet('Imagens/Formas_3/star','recursive');
triangleTestImageDatabase = imageSet('Imagens/Formas_3/triangle','recursive');

testSet = [];
targetTestSet = [];
for i=1:circleTestImageDatabase.Count
    if hogFeatures
        testSet = vertcat(testSet,extractHOGFeatures(imageProcesser(imread(circleTestImageDatabase.ImageLocation{i}), wantedImageSize)));
    else
        testSet = vertcat(testSet,reshape(imageProcesser(imread(circleTestImageDatabase.ImageLocation{i}), wantedImageSize),1,wantedImageSize*wantedImageSize));
    end
    targetTestSet = vertcat(targetTestSet, [1 0 0 0]);
end
for i=1:squareTestImageDatabase.Count
    if hogFeatures
        testSet = vertcat(testSet,extractHOGFeatures(imageProcesser(imread(squareTestImageDatabase.ImageLocation{i}), wantedImageSize)));
    else
        testSet = vertcat(testSet,reshape(imageProcesser(imread(squareTestImageDatabase.ImageLocation{i}), wantedImageSize),1,wantedImageSize*wantedImageSize));
    end
    targetTestSet = vertcat(targetTestSet, [0 1 0 0]);
end
for i=1:starTestImageDatabase.Count
    if hogFeatures
        testSet = vertcat(testSet,extractHOGFeatures(imageProcesser(imread(starTestImageDatabase.ImageLocation{i}), wantedImageSize)));
    else
        testSet = vertcat(testSet,reshape(imageProcesser(imread(starTestImageDatabase.ImageLocation{i}), wantedImageSize),1,wantedImageSize*wantedImageSize));
    end
    targetTestSet = vertcat(targetTestSet, [0 0 1 0]);
end
for i=1:triangleTestImageDatabase.Count
    if hogFeatures
        testSet = vertcat(testSet,extractHOGFeatures(imageProcesser(imread(triangleTestImageDatabase.ImageLocation{i}), wantedImageSize)));
    else
        testSet = vertcat(testSet,reshape(imageProcesser(imread(triangleTestImageDatabase.ImageLocation{i}), wantedImageSize),1,wantedImageSize*wantedImageSize));
    end
    targetTestSet = vertcat(targetTestSet, [0 0 0 1]);
end
testSet = transpose(testSet);
targetTestSet = transpose(targetTestSet);

net = feedforwardnet(10);
% net = patternnet(10);
net = train(net,trainingSet,targetTrainingSet);
out=sim(net,trainingSet);

r=0;
for i=1:length(out)
    a = out(i);
    b = targetTrainingSet(i);
    if abs(a-b) < 0.01
        r = r+1;
    end
end

precisao = r/length(out)*100
