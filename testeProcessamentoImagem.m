clear all;
close all;
clc;

imageSize = 20;

oldImage = imread('Imagens/Formas_3/square/215.png');
% [x y] = size(oldImage);

noiselessImage = medfilt2(oldImage,[8 8],'symmetric');
noiselessImage = imbinarize(noiselessImage);

resizedImage = imresize(noiselessImage, [imageSize imageSize]);

leftCrop = round(find(imrotate(resizedImage,90)==0,1,'first')/imageSize)-1;
topCrop = round(find(resizedImage==0,1,'first')/imageSize)-1;
rightCrop = round(find(imrotate(resizedImage,90)==0,1,'last')/200)+1-leftCrop;
bottomCrop = round(find(resizedImage==0,1,'last')/200)+1-topCrop;
croppedImage = imcrop(resizedImage,[leftCrop topCrop rightCrop bottomCrop]);

subplot(2,3,1);
imshow(oldImage,'InitialMagnification','fit');
title('Old Image');
axis on;
subplot(2,3,2);
imshow(noiselessImage,'InitialMagnification','fit');
title('Noiseless Image');
axis on;
subplot(2,3,3);
imshow(resizedImage,'InitialMagnification','fit');
title('Resized Image');
axis on;
subplot(2,3,4);
imshow(croppedImage,'InitialMagnification','fit');
title('Cropped Image');
axis on;
subplot(2,3,5);
imshow(imrotate(noiselessImage,90),'InitialMagnification','fit');
title('Rotated Image');
axis on;