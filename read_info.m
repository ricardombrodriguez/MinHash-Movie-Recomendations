%% Script 1
% ler e guardar informação

load u.data

all_info = u;
all_info = all_info(:,1:2);

movie_info = readcell('u_item.txt');
[N, M] = size(movie_info);

movie_genre = zeros(N, M-1);
for h = 1:N
    for k = 1:M-1
        x = k+1;
        movie_genre(h,k) = movie_info{h, x};
    end
end

users = unique(u(:,1));
N_users = length(users);

Set = cell(N_users,1);
for n = 1:N_users
    index = find(u(:,1) == users(n));
    Set{n} = [Set{n} all_info(index,2)];
end

%%%%%%%%%%% MIN HASH USERS %%%%%%%%%%%%%%%

K = 100; % Número de funções hash a utilizar

MinHashValues = inf(N_users,K);
for i = 1:N_users
    conjunto = Set{i};      % conjunto de filmes do utilizador
    for j = 1:length(conjunto)
        chave = char(conjunto(j));
        h = zeros(1,K);
        for x = 1:K
            chave = [chave num2str(x)];
            h(x) = DJB31MA(chave,127);
        end
        MinHashValues(i,:) = min([MinHashValues(i,:);h]);
    end
end

%%%%%%%%%%% MIN HASH MOVIES %%%%%%%%%%%%%%%

movie_titles = movie_info(:,1);
N = height(movie_titles);
k = 3;

MinHashMovies = inf(N,K); 
for i = 1:N
    movie = lower(movie_titles{i});
    for j = 1:length(movie)-k+1
        chave = movie(j:j+k-1);
        h = zeros(1,K);
        for x = 1:K
            chave = [chave num2str(x)];
            h(x) = DJB31MA(chave,127);
        end
        MinHashMovies(i,:) = min([MinHashMovies(i,:);h]);
    end
end

save info movie_info movie_genre Set MinHashValues MinHashMovies k

