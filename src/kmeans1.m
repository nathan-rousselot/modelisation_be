function [cluster_idx, centroids] = kmeans1(X, K)
%%% Fonction personelle kmeans. Utilise la norme l2 euclidienne pour le
%%% calcul de la distance. Ne prend en compte que la position. Centroïdes
%%% aléatoires.

max_iter = 200;     
tol = 1e-4;         

% Initialisation des centres de clusters
rnd_idx = randperm(size(X,1));
centroids = X(rnd_idx(1:K), :);
iter = 1;
new_centroids = zeros(K, size(X,2));

while iter < max_iter && norm(new_centroids - centroids) > tol
    
    % Assigner chaque point au centre de cluster le plus proche
    dist = pdist2(X, centroids);
    [min_dist, cluster_idx] = min(dist, [], 2);
    
    % Calculer les nouveaux centres de cluster
    k = 1;
    while k < K
        new_centroids(k,:) = mean(X(cluster_idx == k, :), 1);
        k = k+1 ; 
    end
    
 
    centroids = new_centroids;   
    iter = iter + 1;
end

end
