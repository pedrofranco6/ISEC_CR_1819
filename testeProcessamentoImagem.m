clear all;
close all;
clc;

imageSize = 20;

inputImage = imread('Imagens/Formas_3/star/240.png');

noiselessImage = medfilt2(inputImage,[8 8],'symmetric');
noiselessImage = imbinarize(noiselessImage);

tempRotatedImage = imrotate(noiselessImage,90);
[~,leftCrop] = find(~noiselessImage,1,'first');
[~,topCrop] = find(~tempRotatedImage,1,'first');
[~,rightCrop] = find(~noiselessImage,1,'last');
[~,bottomCrop] = find(~tempRotatedImage,1,'last');
croppedImage = imcrop(noiselessImage,[leftCrop topCrop rightCrop-leftCrop bottomCrop-topCrop]);

resizedImage = imresize(croppedImage, [imageSize-2 imageSize-2]);

resizedImage = [ones(imageSize-2,1) resizedImage ones(imageSize-2,1)];
resizedImage = [ones(1,imageSize); resizedImage; ones(1,imageSize)];

[~,boundaryMask] = bwboundaries(resizedImage,8,'noholes');
imageBoundaries = ~boundarymask(boundaryMask,8);

subplot(2,3,1);
imshow(inputImage,'InitialMagnification','fit');
title('Input Image');
axis on; grid on;
subplot(2,3,2);
imshow(noiselessImage,'InitialMagnification','fit');
title('Noiseless Image');
axis on; grid on;
subplot(2,3,3);
imshow(resizedImage,'InitialMagnification','fit');
title('Resized Image');
axis on; grid on;
subplot(2,3,4);
imshow(tempRotatedImage,'InitialMagnification','fit');
title('Rotated Image');
axis on; grid on;
subplot(2,3,5);
imshow(croppedImage,'InitialMagnification','fit');
title('Cropped Image');
axis on; grid on;
subplot(2,3,6);
imshow(imageBoundaries,'InitialMagnification','fit');
title('Image Boundaries');
axis on; grid on;
