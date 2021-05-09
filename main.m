%% Script 2
clc;
load info

msg = "\--- LOGIN ---\nInsert User ID (1 to 943): ";
valid_user = 0;

while valid_user == 0
    user = input(msg, 's');
    user = str2double(user);
    
    if (isnan(user) || (user > 943 || user < 1))
        fprintf("ERROR: non-existent user, please try again \n");
    else
        valid_user = 1;
    end
end

%%%%%%%%%%%% MENU %%%%%%%%%%%%%%  
msg = "\n--- MENU ---\n1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit\nSelect choice: ";

while 1
    opt = input(msg,'s');
    opt = str2double(opt);
    
    if ~isnan(opt)
        switch opt
            case 1
                option1(user,movie_info,Set);
            case 2
                option2(user, Set, movie_info, movie_genre, MinHashValues);
            case 3
                option3(movie_info, MinHashMovies, k);
            case 4
                fprintf("\nBye!\n");
                return;
            otherwise
                fprintf("ERROR: non-existent option, please try again\n");
        end 
    else
        fprintf("ERROR: non-existent option, please try again\n");
    end
end

%%%%%%%%%%%% OPÇÕES %%%%%%%%%%%%%

function option1(user,movie_info,Set)

    fprintf("\n--- MOVIES YOU HAVE ALREADY WATCHED ---\n");
    for k = Set{user}
        fprintf("%s\n", movie_info{k});
    end
    fprintf("[TOTAL]: %d\n", length(Set{user}));
end

function option2(user, Set, movie_info, movie_genre, MinHashValues)

    msg = "\n--- SELECT A GENRE ---\n1- Action, 2- Adventure, 3- Animation, 4- Children’s\n5- Comedy, 6- Crime, 7- Documentary, 8- Drama\n9- Fantasy, 10- Film-Noir, 11- Horror, 12- Musical\n13- Mystery, 14- Romance, 15- Sci-Fi, 16- Thriller\n17- War, 18- Western\nSelect choice: ";
    
    valid_opt = 0;
    while valid_opt == 0
        opt = input(msg, 's');
        opt = str2double(opt);

        if (isnan(opt) || (opt > 18 || opt < 1))
            fprintf("ERROR: non-existent user, please try again \n");
        else
            valid_opt = 1;
        end
    end
    genre = opt + 1; 
    % genre será opt+1 porque a primeira coluna de movie_genre é da categoria "desconhecido" que não tem nas opções acima
    
    [N,K] = size(MinHashValues); 
    J = zeros(N,2); 
    for u = 1:N
        J(u,1)= sum(MinHashValues(user,:) ~= MinHashValues(u,:)) / K;
        J(u,2)= u; % salvaguardar a posição
    end
    
    J_sorted = sortrows(J, 1); 
    user_similar = J_sorted(2,2); % o primeiro valor do J_sorted irá ser o próprio user, ou seja, J_sorted(1,1) = 0
    
    index = find(movie_genre(Set{user_similar},genre) == 1); % descobrir os indices dos filmes do genero escolhido
    user_similar_movies = Set{user_similar}(index); % arrays dos id's dos filmes apenas do género escolhido
    
    index = find(movie_genre(Set{user},genre) == 1);
    user_movies = Set{user}(index);

    fprintf("\n--- SUGGESTIONS ---\n");
    total = 0;
    for k = 1:length(user_similar_movies)
        if ismember(user_similar_movies(k), user_movies) == 0
            fprintf("%s\n",movie_info{user_similar_movies(k)});
            total = total + 1;
        end
    end
    if total == 0
        fprintf("No suggestions :(\n");
    else
        fprintf("[TOTAL]: %d\n", total);
    end
end

function option3(movie_info ,MinHashMovies,k)

    string = input("\n--- SEARCH ---\n Write a string: ",'s');
    string = lower(string);
    
    [N,K] = size(MinHashMovies);
    MinHashString = inf(1,K);   % 1 x K  
    for i = 1:length(string)-k+1
        chave = string(i:i+k-1);
        h = zeros(1,K);
        for x = 1:K
            chave = [chave num2str(x)];
            h(x) = DJB31MA(chave,127);
        end
        MinHashString(1,:) = min([MinHashString(1,:);h]);
    end
    
    SimilarTitles = zeros(1,2);
    x = 1;
    for n = 1:N
        J = sum(MinHashString(1,:) ~= MinHashMovies(n,:)) / K;
        if J <= 0.99
            SimilarTitles(x,:)= [J n]; % guardar a posição do filme na coluna 2 da matriz
            x = x + 1;
        end
    end
    SimilarTitles = sortrows(SimilarTitles,1);
    
    if sum(SimilarTitles) == 0
        fprintf("No title found :(\n");
    else
        for k = 1:min([5 height(SimilarTitles)])
            fprintf("%s (%.3f)\n",movie_info{SimilarTitles(k,2)}, SimilarTitles(k,1));
        end
    end
end

