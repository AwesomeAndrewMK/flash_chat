import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flash_chat_flutter/services/movieDB.dart';
import 'components/movie_tile.dart';

class MoviesScreen extends StatefulWidget {
  static const String id = 'movies_screen';

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  MovieDB movieDB = MovieDB();

  String _avatar;
  List<dynamic> movies;
  List<dynamic> favouritesMovies = [];

  Future getMovies() async {
    dynamic res = await movieDB.getMoviesList();
    setState(() {
      movies = res;
    });
  }

  Future getFavMovies() async {
    var favMovies = await movieDB.getFavouriteMovies();
    favouritesMovies = favMovies;
  }

  Future getUserImage() async {
    var userData = await FacebookAuth.instance.getUserData();
    setState(() {
      _avatar = userData['picture']['data']['url'];
    });
  }

  @override
  void initState() {
    super.initState();

    getUserImage();
    getFavMovies();
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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundImage: _avatar != null
                      ? NetworkImage(_avatar)
                      : AssetImage('images/avatar_placeholder.png'),
                ),
              )
            ],
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
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: getMovies,
                        child: ListView.builder(
                            itemCount: movies?.length,
                            itemBuilder: (context, index) {
                              var item = movies[index];

                              bool isItemInFavourites() {
                                var contain = favouritesMovies
                                    .where((el) => el['id'] == item['id']);
                                if (contain.isEmpty) {
                                  return false;
                                } else {
                                  return true;
                                }
                              }

                              return MovieTile(
                                  item: item,
                                  movieId: item['id'],
                                  isItemInFavourites: isItemInFavourites(),
                                  onAddToFavourites: () {
                                    if (isItemInFavourites()) {
                                      setState(() {
                                        favouritesMovies.removeAt(
                                            favouritesMovies.indexWhere((el) =>
                                                el['id'] == item['id']));
                                        movieDB.storeFavouriteMovies(
                                            favouritesMovies);
                                      });
                                    } else {
                                      setState(() {
                                        favouritesMovies.add(item);
                                        movieDB.storeFavouriteMovies(
                                            favouritesMovies);
                                      });
                                    }
                                  });
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
                    : RefreshIndicator(
                        onRefresh: getMovies,
                        child: ListView.builder(
                            itemCount: favouritesMovies?.length,
                            itemBuilder: (context, index) {
                              var item = favouritesMovies[index];
                              return MovieTile(
                                item: item,
                                isFavourite: true,
                              );
                            }),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
