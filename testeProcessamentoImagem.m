clear all;
close all;
clc;

%inputImage = imread('Imagens/Formas_1/0_circle.png');
inputImage = imread('Imagens/Formas_3/square/215.png');
resizedImage = imresize(inputImage, [30 30]);

noisyImage = imnoise(inputImage,'salt & pepper',0.02);
Kaverage = filter2(fspecial('average',3),noisyImage)/255;
Kmedian = medfilt2(inputImage);

imshow(resizedImage,'InitialMagnification','fit');
axis on;