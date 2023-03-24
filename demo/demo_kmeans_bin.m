close all;clear;clc

%%% Démonstration de la segmentation sur tous les images du dataset

load("data\im.mat");
load("data\im_bin.mat");
load("data\im_mat.mat");
load("data\im_rec.mat");

nb_images = length(im_rec(1,1,1,:));
z = 1;

figure;

sgtitle('Default kmeans, K=200, \lambda=1, naive binarization')
while (z <= nb_images)
    subplot(131)
    imshow(im(:,:,:,z),[]);
    title('Image originale')
    subplot(132)
    imshow(im_rec(:,:,:,z),[]);
    title('Image Sursegmentée')
    subplot(133)
    imshow(im_bin(:,:,z),[]);
    title('Image Binarisée')
    pause(.5);
    z = z + 1;
end