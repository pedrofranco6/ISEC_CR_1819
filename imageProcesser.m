function [returnImage] = imageProcesser(inputImage,imageSize,rotationAngle,boundaries)

if rotationAngle
    inputImage = imcomplement(imrotate(imcomplement(inputImage),rotationAngle));
end

noiselessImage = medfilt2(inputImage,[8 8],'symmetric');
noiselessImage = imbinarize(noiselessImage);

tempRotatedImage = imrotate(noiselessImage,90);
[~,leftCrop] = find(~noiselessImage,1,'first');
[~,topCrop] = find(~tempRotatedImage,1,'first');
[~,rightCrop] = find(~noiselessImage,1,'last');
[~,bottomCrop] = find(~tempRotatedImage,1,'last');
croppedImage = imcrop(noiselessImage,[leftCrop topCrop rightCrop-leftCrop bottomCrop-topCrop]);

if boundaries
    resizedImage = imresize(croppedImage, [imageSize-2 imageSize-2]);
    
    resizedImage = [ones(imageSize-2,1) resizedImage ones(imageSize-2,1)];
    resizedImage = [ones(1,imageSize); resizedImage; ones(1,imageSize)];
    
    [~,boundaryMask] = bwboundaries(resizedImage,8,'noholes');
    returnImage = ~boundarymask(boundaryMask,8);
else
    returnImage = imresize(croppedImage, [imageSize imageSize]);
end

end
