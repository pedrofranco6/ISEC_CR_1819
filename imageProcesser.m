function [resizedImage] = imageProcesser(inputImage,imageSize)

noiselessImage = medfilt2(inputImage,[8 8],'symmetric');
noiselessImage = imbinarize(noiselessImage);

tempRotatedImage = imrotate(noiselessImage,90);
[~,leftCrop] = find(~noiselessImage,1,'first');
[~,topCrop] = find(~tempRotatedImage,1,'first');
[~,rightCrop] = find(~noiselessImage,1,'last');
[~,bottomCrop] = find(~tempRotatedImage,1,'last');
croppedImage = imcrop(noiselessImage,[leftCrop topCrop rightCrop-leftCrop bottomCrop-topCrop]);

resizedImage = imresize(croppedImage, [imageSize imageSize]);

end

