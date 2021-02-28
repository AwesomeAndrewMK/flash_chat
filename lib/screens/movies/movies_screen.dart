import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flash_chat_flutter/services/movieDB.dart';
import 'components/movie_tile.dart';
import 'package:flash_chat_flutter/services/handleMoviesList.dart';
import 'package:flash_chat_flutter/screens/movies//components/user_avatar.dart';
import 'package:flash_chat_flutter/components/loader.dart';

class MoviesScreen extends StatefulWidget {
  static const String id = 'movies_screen';
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  MovieDB movieDB = MovieDB();

  String _avatar;
  Map<String, List<dynamic>> movies;
  List<dynamic> favouritesMovies = [];
  List<String> moviesTitles;

  @override
  void initState() {
    super.initState();

    getUserAvatar();
    getFavouriteMovies();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainAppColor,
            actions: [UserAvatar(avatar: _avatar)],
            bottom: TabBar(
              indicatorColor: Colors.yellow,
              tabs: [
                Tab(
                  child: Text('FILMS'),
                ),
                Tab(
                  child: Text('FAVOURITES'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Tab(
                child: movies == null
                    ? Loader()
                    : RefreshIndicator(
                        onRefresh: getMovies,
                        color: mainAppColor,
                        child: ListView.builder(
                            itemCount: moviesTitles.length,
                            itemBuilder: (context, index) {
                              String item = moviesTitles[index];
                              bool isItemInFavourites(item) {
                                var contain = favouritesMovies.where(
                                    (favouriteMovie) =>
                                        favouriteMovie['id'] == item['id']);
                                if (contain.isEmpty) {
                                  return false;
                                } else {
                                  return true;
                                }
                              }

                              void onAddToFavourites(movie) {
                                if (isItemInFavourites(movie)) {
                                  setState(() {
                                    favouritesMovies.removeAt(favouritesMovies
                                        .indexWhere((favouriteMovie) =>
                                            favouriteMovie['id'] ==
                                            movie['id']));
                                    movieDB
                                        .storeFavouriteMovies(favouritesMovies);
                                  });
                                } else {
                                  setState(() {
                                    favouritesMovies.add(movie);
                                    movieDB
                                        .storeFavouriteMovies(favouritesMovies);
                                  });
                                }
                              }

                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 24, 8, 8),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: movies[item]
                                          .map<Widget>(
                                            (movie) => MovieTile(
                                                item: movie,
                                                isItemInFavourites:
                                                    isItemInFavourites(movie),
                                                onAddToFavourites: () {
                                                  onAddToFavourites(movie);
                                                }),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
              ),
              Tab(
                child: favouritesMovies.length == 0
                    ? Center(
                        child: Text(
                          'No favourite movies here!',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: favouritesMovies?.length,
                        itemBuilder: (context, index) {
                          var item = favouritesMovies[index];
                          return Dismissible(
                            key: Key(item['id'].toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                favouritesMovies.removeAt(index);
                                movieDB.storeFavouriteMovies(favouritesMovies);
                              });
                            },
                            background: Container(
                              child: Align(
                                alignment: Alignment(0.7, 0),
                                child: Icon(
                                  Icons.delete_forever,
                                  size: 32,
                                ),
                              ),
                              color: Colors.red,
                            ),
                            child: MovieTile(
                              item: item,
                              isFavourite: true,
                            ),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getMovies() async {
    List<dynamic> res = await movieDB.getMoviesList();
    HandleMoviesList groupedMovies = HandleMoviesList(moviesList: res);
    setState(() {
      movies = groupedMovies.getGroupedMovies();
      moviesTitles = getMoviesTitles();
    });
  }

  List getMoviesTitles() {
    List moviesTitles = movies.keys.map((el) => el).toList();
    moviesTitles.sort((a, b) => a.compareTo(b));
    return moviesTitles;
  }

  Future getFavouriteMovies() async {
    List<dynamic> favMovies = await movieDB.getFavouriteMovies();
    favouritesMovies = favMovies;
  }

  Future getUserAvatar() async {
    var userData = await FacebookAuth.instance.getUserData();
    setState(() {
      _avatar = userData['picture']['data']['url'];
    });
  }
}
