clear;
close all;
clc;
nb_images = 36; % Nombre d'images

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
    im_mat(:,1,i) = reshape(Ir,m*n,1);
    im_mat(:,2,i) = reshape(Ig,m*n,1);
    im_mat(:,3,i) = reshape(Ib,m*n,1);
    im_mat(:,4:5,i) = cp;

    i = i +1;
end 

K = 100;
lambda = 20;
im_mat(:,1:3) = im_mat(:,1:3).*(S/(lambda*K));
[idx,C] = kmeans(im_mat(:,:,1),100);
superpixels = reshape(idx,size(im(:,:,1,1)));

im_rec=zeros(m,n,3);


for i=1:1:m
    for j=1:1:n
        im_rec(i,j,:)=((lambda*K)/S)*fix(C(superpixels(i,j),1:3))/255;
    end
end

figure
imshow(im_rec)
% colormap hsv

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


