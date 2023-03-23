clear;
close all;
clc;
nb_images = 36; % Nombre d'images
%%
% chargement des images
for i = 1:nb_images
    if i<=10
        nom = sprintf('images/viff.00%d.ppm',i-1);
    else
        nom = sprintf('images/viff.0%d.ppm',i-1);
    end;
    % L'ensemble des images de taille : nb_lignes x nb_colonnes x nb_canaux
    % x nb_images
    im(:,:,:,i) = imread(nom); 
end;

% Affichage des images
figure; 
subplot(2,2,1); imshow(im(:,:,:,1)); title('Image 1');
subplot(2,2,2); imshow(im(:,:,:,9)); title('Image 9');
subplot(2,2,3); imshow(im(:,:,:,17)); title('Image 17');
subplot(2,2,4); imshow(im(:,:,:,25)); title('Image 25');
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A COMPLETER                                             %
% Calculs des superpixels                                 % 
% Conseil : afficher les germes + les régions             %
% à chaque étape / à chaque itération                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ........................................................%
m = length(im(:,1,1,1));
n = length(im(1,:,1,1));
% N = size(im,1)*size(im,2);
N = m*n;
K = 12^2;
S = round(sqrt(N/K));

% cx1 = linspace(1,S/2,sqrt(K));
% cx2 = linspace(1,S/2,sqrt(K));
% cx = meshgrid(cx1,cx2);

mv = 1:1:m;
nv = 1:1:n;
[X,Y] = meshgrid(mv,nv);
cp = [X(:),Y(:)];
im_mat = zeros(n*m,3,nb_images);
i = 1;
while (i <= nb_images)
    Ir = im(:,:,1,i);
    Ig = im(:,:,2,i);
    Ib = im(:,:,3,i);
    im_mat(:,1,i) = reshape(Ir',m*n,1);
    im_mat(:,2,i) = reshape(Ig',m*n,1);
    im_mat(:,3,i) = reshape(Ib',m*n,1);
    im_mat(:,4:5,i) = cp;

    i = i +1;
end 
im_rec=zeros(m,n,3,nb_images);
im_bin=zeros(m,n,nb_images);
    
z = 1;
while (z <= nb_images) 
    K = 200;
    lambda = 1;
    im_mat(:,1:3,z) = im_mat(:,1:3,z).*(S/(lambda*K));
    [idx,C] = kmeans(im_mat(:,:,z),K);
    superpixels = reshape(idx,size(im(:,:,1,1)'));
    superpixels = superpixels';
    
    
    
    for i=1:1:m
        for j=1:1:n
            im_rec(i,j,:,z)=((lambda*K)/S)*fix(C(superpixels(i,j),1:3))/255;
            im_bin(i,j,z) = 255*(int8(im_rec(i,j,1,z)>im_rec(i,j,3,z)));
        end
    end
    z = z+1;
end
%%
%im_rec = permute(im_rec,[2 1 3]);

figure
imshow(im_rec)
mask = boundarymask(superpixels);
% 
% hold on
% imshow(labeloverlay(im_rec,mask,'Transparency',0,'Colormap','autumn'))
% 
% imshow(mask);
% 
% colormap hsv

% rp = regionprops(superpixels,'Area','Perimeter');
aires_sp = aires_superpixels(superpixels,K);
permietre_sp = permietre_superpixels(superpixels,K);
% compacite = [rp.Perimeter].^2./[rp.Area];
compacite = permietre_sp.^2./aires_sp;

%figure;

% T = 1;
% while (T <= max(compacite))
%     seuil_compacite=4;
%     superpixels_exterieurs = superpixels;
%     superpixels_internes = superpixels;
%     for i=1:length(compacite)
%         if compacite(i) < seuil_compacite
%             superpixels_exterieurs(superpixels_exterieurs == i) = 0;
%         else
%             superpixels_internes(superpixels_internes == i) = 0;
%         end
%     end
%     title(["T=", num2str(T)]);
%     subplot(1,3,1); imshow(im(:,:,:,1)); title(['Image originale, T=',T]);
%     subplot(1,3,2); imshow(superpixels_exterieurs, []); title('Régions extérieures');
%     subplot(1,3,3); imshow(superpixels_internes, []); title('Régions intérieures');
%     drawnow
%     pause(.2)
%     T = T + 0.1;
% end

BW = imbinarize(rgb2gray(im(:,:,:,1)),graythresh(im(:,:,:,1)));

[xc,yc] = find_pixel_contour(im_bin);
B = bwtraceboundary(im_bin,[xc,yc],'S');

B(:,1) = sgolayfilt(B(:,1),3,13);
B(:,2) = sgolayfilt(B(:,2),3,13);

figure
subplot(121)
imshow(im(:,:,:,1))
title('Image originale')
subplot(122)
imshow(im_bin)
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
    elseif (im_bin(round(vy(1,i)),round(vx(1,i))) == 0 || im_bin(round(vy(2,i)),round(vx(2,i))) == 0 ...
        || is_perimeter(im_bin,round(vy(1,i)),round(vx(1,i))) || is_perimeter(im_bin,round(vy(2,i)),round(vx(2,i))))
        vx(:,i) = [];
        vy(:,i) = [];
    else 
        i = i + 1;
    end
end

plot(vx,vy);


% inside= inpolygon(vx,vy,[1 size(im_bin,2) size(im_bin,2) 1], [1 1 size(im_bin,1) size(im_bin,1)]);
% U = [];
% while i<length(inside)
%     if inside(i) && inside(i+1)
%         U = [U; vx(i) vy(i) vx(i+1) vy(i+1)];
%     end
%     i=i+1;
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A COMPLETER                                             %
% Binarisation de l'image à partir des superpixels        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ........................................................%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER ET COMPLETER                              %
% quand vous aurez les images segmentées                  %
% Affichage des masques associes                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% chargement des masques (pour l'elimination des fonds bleus)
% de taille nb_lignes x nb_colonnes x nb_images
% Affichage des masques associes
% figure;
% subplot(2,2,1); A COMPLETER ; title('Masque image 1');
% subplot(2,2,2); A COMPLETER ; title('Masque image 9');
% subplot(2,2,3); A COMPLETER ; title('Masque image 17');
% subplot(2,2,4); A COMPLETER ; title('Masque image 25');


%%%%%%%%%%%%%%%
% A COMPLETER %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul de l'axe médian %
%%%%%%%%%%%%%%%%%%%%%%%%%%

% ... 