clear all;
close all;
clc;

%carregar as imagens da Folha_1
imageDatabase = imageSet('Imagens/Formas_1','recursive');

%separar a amostra em training st e testing set
[training, test] = partition(imageDatabase, [0.8, 0.2]);

%fazer uma tabela a zeros para alojar as HOGFeatures
%n linhas = n imagens /
trainingFeatures = zeros(training.Count,900);

featureCount = 1;
for i=1:training.Count
    sizeNormalizedImage = imresize(read(training(1),i),[50 50]);
    trainingFeatures(featureCount,:) = extractHOGFeatures(sizeNormalizedImage);
    [filepath,name,ext] = fileparts(training.ImageLocation{i});
    trainingLabel{featureCount} = name;    
    featureCount = featureCount + 1;
    imageIndex{i} = name;
end

%cria um image classifier com o fitcecoc
%imageClassifier = fitcecoc(trainingFeatures,trainingLabel);

%% Read test data
%figure;
%for  i= 2:5:25
 %   queryImage = imresize(read(imageDatabase,19),[50 50]);


inputImage = imread(imageDatabase.ImageLocation{40});
newImage = ImageResize(inputImage, 50);

subplot(3,1,1);imshow(inputImage);
axis on;
subplot(3,1,2);imshow(newImage);
axis on;
trainingFeatures = zeros(1,900);
trainingFeatures(1,:) = extractHOGFeatures(newImage);
subplot(3,1,3);imshow(trainingFeatures);
axis on;
%    queryFeatures = extractHOGFeatures(queryImage);
%    imageLabel = predict(imageClassifier,queryFeatures);
%end

% figureNum = 1;
% for  i= 1:5:25
%     queryImage = read(imageDatabase,i);
%     queryFeatures = extractHOGFeatures(queryImage);
%     imageLabel = predict(imageClassifier,queryFeatures);
%     booleanIndex = strcmp(imageLabel, imageIndex);
%     integerIndex = find(booleanIndex);
%     subplot(5,2,figureNum);imshow(queryImage);title('Query Image');
%     subplot(5,2,figureNum+1);imshow(read(imageDatabase,integerIndex));title('Matched Class');
%     figureNum = figureNum+2; 
% end