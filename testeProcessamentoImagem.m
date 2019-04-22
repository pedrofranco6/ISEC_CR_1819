clear all;
close all;
clc;

imageSize = 50;

inputImage = imread('Imagens/Formas_3/star/215.png');
% [x y] = size(inputImage);

noiselessImage = medfilt2(inputImage,[8 8],'symmetric');
noiselessImage = imbinarize(noiselessImage);

% resizedImage = imresize(noiselessImage, [imageSize imageSize]);

% tempRotatedImage = imrotate(resizedImage,90);
% [auxl,leftCrop] = find(tempRotatedImage==0,1,'first');
% [auxt,topCrop] = find(resizedImage==0,1,'first');
% [auxr,rightCrop] = find(tempRotatedImage==0,1,'last');
% [auxb,bottomCrop] = find(resizedImage==0,1,'last');
% croppedImage = imcrop(resizedImage,[leftCrop topCrop rightCrop-leftCrop bottomCrop-topCrop]);

noiselessImageTest = imcrop(noiselessImage,[30 0 200 200]);
sidePanel = ones(200, 30);
noiselessImageTest = [noiselessImageTest sidePanel];

tempRotatedImage = imrotate(noiselessImageTest,90);
[auxl,leftCrop] = find(tempRotatedImage==0,1,'first');
[auxt,topCrop] = find(noiselessImageTest==0,1,'first');
[auxr,rightCrop] = find(tempRotatedImage==0,1,'last');
[auxb,bottomCrop] = find(noiselessImageTest==0,1,'last');
disp(leftCrop);
disp(topCrop);
disp(rightCrop);
disp(bottomCrop);
croppedImage = imcrop(noiselessImageTest,[leftCrop topCrop rightCrop bottomCrop]);

resizedImage = imresize(croppedImage, [imageSize imageSize]);

subplot(2,3,1);
imshow(inputImage,'InitialMagnification','fit');
title('Input Image');
axis on;
subplot(2,3,2);
imshow(noiselessImage,'InitialMagnification','fit');
title('Noiseless Image');
axis on;
subplot(2,3,3);
imshow(tempRotatedImage,'InitialMagnification','fit');
title('Rotated Image');
axis on;
subplot(2,3,4);
imshow(croppedImage,'InitialMagnification','fit');
title('Cropped Image');
axis on;
subplot(2,3,5);
imshow(resizedImage,'InitialMagnification','fit');
title('Resized Image');
axis on;
subplot(2,3,6);
imshow(noiselessImageTest,'InitialMagnification','fit');
title('Noiseless Test Image');
axis on;