clc;close all;clear all;
tic

directory = 'Imagens/Formas_2/';
filelist = dir(directory);
dirlist = filelist([filelist(:).isdir]);
dirlist = {dirlist.name};
dirlist = dirlist(~strncmp(dirlist, '.', 1));
dirlist = dirlist(~strncmp(dirlist, '_', 1));

trainingSet = [];

disp('Imagens/Formas_2/Formas_2');
asd = strcat(directory,dirlist(1));
% strlength(asd)
disp(substring(asd,1,strlength(asd)-1));
% disp(substring(strcat(directory,dirlist(1)), 2, strcat(directory,dirlist(1)).length));

% targetTrainingSet = [];
% for i=1:length(dirlist)
%     disp(strcat(directory,dirlist(i)));
% %     imageDir = regexprep(strcat(directory,dirlist(i)),"'",'');
% disp('Imagens/Formas_2/circle');
% imageDir = 'Imagens/Formas_2/circle';
%     tempImageSet = imageSet(imageDir,'recursive');
% %     for j=1:tempImageSet.Count
% %         trainingSet = horzcat(trainingSet,reshape(imread(tempImageSet.ImageLocation{j}),[],1));
% %         targetTrainingSet = horzcat(targetTrainingSet, [1;0;0;0]);
% %     end
% end

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

% if ispc
%     xlswrite('Datasets\test.csv',trainingSet);
% elseif isunix || ismac
%     csvwrite('Datasets/test.csv',trainingSet);
% else
%     disp('Platform not supported');
% end

toc