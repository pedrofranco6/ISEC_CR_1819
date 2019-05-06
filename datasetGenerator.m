function [trainingSet,targetTrainingSet] = datasetGenerator(directory,numRotations,imageSize,hogFeatures,boundaries,exportDataset,datasetName)

filelist = dir(directory);
dirlist = filelist([filelist(:).isdir]);
dirlist = {dirlist.name};
dirlist = dirlist(~strncmp(dirlist, '.', 1));
dirlist = dirlist(~strncmp(dirlist, '_', 1));

trainingSet = [];
targetTrainingSet = [];
for i=1:length(dirlist)
    tempImageSet = imageSet(strcat(directory,dirlist{i}),'recursive');
    targetArray = zeros([length(dirlist) 1]); targetArray(i) = 1;
    for j=1:tempImageSet.Count
        importedImage = imread(tempImageSet.ImageLocation{j});
        if hogFeatures
            tempImage = extractHOGFeatures(imageProcesser(importedImage,imageSize,0,boundaries));
        else
            tempImage = imageProcesser(importedImage, imageSize,0,boundaries);
        end
        trainingSet = horzcat(trainingSet,tempImage(:));
        targetTrainingSet = horzcat(targetTrainingSet,targetArray);
        for l=1:numRotations
            randomRotation = randi(359,1,1);
            if hogFeatures
                tempImage = extractHOGFeatures(imageProcesser(importedImage,imageSize,randomRotation,boundaries));
            else
                tempImage = imageProcesser(importedImage,imageSize,randomRotation,boundaries);
            end
            trainingSet = horzcat(trainingSet,tempImage(:));
            targetTrainingSet = horzcat(targetTrainingSet,targetArray);
        end
    end
end

if exportDataset
    if ispc; datasetDirectory = 'Datasets\'; else; datasetDirectory = 'Datasets/'; end
    fullDatasetName = strcat(datasetDirectory,datasetName,'_',strcat(datestr(now,'dd-mm-yyyy'),'_',datestr(now,'HH-MM-SS')))
    save(fullDatasetName,'trainingSet','targetTrainingSet');
end

end
