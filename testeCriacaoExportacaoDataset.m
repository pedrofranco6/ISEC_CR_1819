clc;close all;clear all;
tic

% circleImageDatabase = imageSet('Imagens/Formas_2/circle','recursive');
% squareImageDatabase = imageSet('Imagens/Formas_2/square','recursive');
% starImageDatabase = imageSet('Imagens/Formas_2/star','recursive');
% triangleImageDatabase = imageSet('Imagens/Formas_2/triangle','recursive');
% 
% trainingSet = [];
% targetTrainingSet = [];
% for i=1:circleImageDatabase.Count
%     trainingSet = horzcat(trainingSet,reshape(imread(circleImageDatabase.ImageLocation{i}),[],1));
%     targetTrainingSet = horzcat(targetTrainingSet, [1;0;0;0]);
% end
% for i=1:squareImageDatabase.Count
%     trainingSet = horzcat(trainingSet,reshape(imread(squareImageDatabase.ImageLocation{i}),[],1));
%     targetTrainingSet = horzcat(targetTrainingSet, [0;1;0;0]);
% end
% for i=1:starImageDatabase.Count
%     trainingSet = horzcat(trainingSet,reshape(imread(starImageDatabase.ImageLocation{i}),[],1));
%     targetTrainingSet = horzcat(targetTrainingSet, [0;0;1;0]);
% end
% for i=1:triangleImageDatabase.Count
%     trainingSet = horzcat(trainingSet,reshape(imread(triangleImageDatabase.ImageLocation{i}),[],1));
%     targetTrainingSet = horzcat(targetTrainingSet, [0;0;0;1]);
% end

if ispc
    xlswrite('Datasets\test.csv',trainingSet);
elseif isunix || ismac
    csvwrite('Datasets/test.csv',trainingSet);
else
    disp('Platform not supported');
end

toc