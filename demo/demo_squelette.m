close all;clear;clc

load("data\im.mat");
load("data\im_bin.mat");
load("data\im_rec.mat");


z = 1;
nb_images = length(im_rec(1,1,1,:));
[m,n] = size(im_rec(:,:,1,1));


figure;
sgtitle('Median Axis Demo')
while (z <= nb_images)
    [xc,yc] = find_pixel_contour(im_bin(:,:,z));
    B = bwtraceboundary(im_bin(:,:,z),[xc,yc],'S');
    
    B(:,1) = sgolayfilt(B(:,1),3,13);
    B(:,2) = sgolayfilt(B(:,2),3,13);
    
    subplot(121)
    imshow(im(:,:,:,z))
    title('Image originale')
    subplot(122)
    imshow(im_bin(:,:,z))
    title('Image binarisée')
    hold on
    plot(B(:,2),B(:,1),'r');
    
    [vx,vy]= voronoi(B(:,2),B(:,1));
    i = 1;
    while (i <= length(vx))
        if (round(vx(1,i)) < 1 || round(vy(1,i)) < 1 || round(vx(1,i)) > n || round(vy(1,i)) > m ...
                || round(vx(2,i)) < 1 || round(vy(2,i)) < 1 || round(vx(2,i)) > n || round(vy(2,i)) > m)
            vx(:,i) = [];
            vy(:,i) = [];
        elseif (im_bin(round(vy(1,i)),round(vx(1,i)),z) == 0 || im_bin(round(vy(2,i)),round(vx(2,i)),z) == 0 ...
            || is_perimeter(im_bin(:,:,z),round(vy(1,i)),round(vx(1,i))) || is_perimeter(im_bin(:,:,z),round(vy(2,i)),round(vx(2,i))))
            vx(:,i) = [];
            vy(:,i) = [];
        else 
            i = i + 1;
        end
    end
    plot(vx,vy);
    pause(.1);
    z = z + 1;
end