# MinHash-Movie-Recommendations

The MinHash Movie Recommendations was the final project of the *Probabilistic Methods for Software Engineering* class, written in MATLAB.

# Introduction

The goal of this project is to develop an application in MATLAB that provides various functionalities of an online movie database system, similar to the well-known [IMDb website](https://www.imdb.com/).

The application must consider a list of users identified by an ID and a list of movies also identified by an ID. The *u.data* file, taken from the [MovieLens 100k dataset](http://grouplens.org/datasets/movielens/), has a series of lines. Each one of them has the ID of the user, the ID of the movie he saw and his review of the title. The *u_item.txt* file, generated from the same dataset, has the title of the movie in the 1st column and 19 more columns that identify the movie genre according to the presence of ones (belongs to that genre) and zeros (doesn't belong to that genre). The application must start by asking the user to choose an ID that can range from 1 to 943 and the choosen value becomes the current user ID.

## User options

**1st option:**
The application lists the titles of the movies the user already saw (one title per line).

**2nd option:**
The application asks the user to select a genre for which he wants to get movie suggestions:
1- Action, 2- Adventure, 3- Animation, 4- Children’s, 5- Comedy, 6- Crime, 7- Documentary, 8- Drama, 9- Fantasy, 10- Film-Noir, 11- Horror, 12- Musical, 13- Mystery, 14- Romance, 15- Sci-Fi, 16- Thriller, 17- War, 18- Western
And then the application determines, using the Jaccard Index, which of the 942 other users is the most similar to the current user (in terms of similar movies saw by each other) and, finally, it presents all of the movies of the selected genre that the most similar user saw but the current user didn't. If no movie suggestion is found, the application must tell the user it couldn't found any suggestion.

**3rd option:**
The application aks the user to insert a string and it presents a list of movies (5 movies max.), one per line, of the ones whose title is the most similar to the user's input and also indicating the estimative Jaccard distance between the movie and the user's string. This option is independent of the current user ID. The movie list must be presented in descendent order of Jaccard distance and it should only show movies whose distance is less or equal than 0.99. In this option, we have to develop a MinHash method adequate to the similarity of character vectors, choosing both the shingle size and the number of hash functions in a reasoned way.

**4th option:**
The application closes.

Final grade: 17/20

## Authors

- [João Reis](https://github.com/joaoreis16)
- [Ricardo Rodriguez](https://github.com/ricardombrodriguez)
