import 'package:flash_chat_flutter/common/utils/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flash_chat_flutter/data/services/movie_db.dart';
import 'package:grouped_list/grouped_list.dart';
import 'widgets/widgets.dart';
import 'package:flash_chat_flutter/presentation/widgets/widgets.dart';
import 'package:flash_chat_flutter/presentation/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';

class MoviesScreen extends StatefulWidget {
  static const String id = 'movies_screen';
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final _auth = FirebaseAuth.instance;
  MovieDB movieDB = MovieDB();

  String? _avatar;
  List<dynamic> movies = [];
  List<dynamic> favouritesMovies = [];

  @override
  void initState() {
    super.initState();

    getUserAvatar();
    getFavouriteMovies();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                BlocBuilder<ThemeCubit, bool>(
                  builder: (context, value) {
                    return GestureDetector(
                      onTap: context.read<ThemeCubit>().switchTheme,
                      child: value
                          ? Icon(
                              Icons.nightlight_round,
                              color: ProjectCodeColors.WHITE_COLOR,
                            )
                          : Icon(
                              Icons.wb_sunny,
                              color: ProjectCodeColors.YELLOW_COLOR,
                            ),
                    );
                  },
                ),
              ],
            ),
            actions: [
              UserAvatar(_avatar),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: _logOut,
              ),
            ],
            bottom: TabBar(
              indicatorColor: ProjectCodeColors.YELLOW_COLOR,
              tabs: [
                Tab(
                  child: Text(t.films.toUpperCase()),
                ),
                Tab(
                  child: Text(t.favourites.toUpperCase()),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Tab(
                child: movies.isEmpty
                    ? Loader()
                    : RefreshIndicator(
                        onRefresh: getMovies,
                        color: ProjectCodeColors.MAIN_COLOR,
                        child: GroupedListView(
                          elements: movies,
                          useStickyGroupSeparators: true,
                          itemComparator: (dynamic a, dynamic b) =>
                              b['vote_average']
                                  .toDouble()
                                  .compareTo(a['vote_average'].toDouble()),
                          groupComparator: (dynamic a, dynamic b) {
                            return a.compareTo(b);
                          },
                          groupBy: (dynamic item) =>
                              formatDate(item['release_date']),
                          stickyHeaderBackgroundColor: Colors.transparent,
                          groupSeparatorBuilder: (String val) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(8, 24, 8, 8),
                              child: Text(
                                Jiffy(val).format('MMM y').toUpperCase(),
                                style: Fonts.FONT_MEDIUM_BOLD,
                              ),
                            );
                          },
                          itemBuilder: (context, dynamic element) {
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
                                          favouriteMovie['id'] == movie['id']));
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

                            return MovieTile(
                              item: element,
                              isItemInFavourites: isItemInFavourites(element),
                              onAddToFavourites: () {
                                onAddToFavourites(element);
                              },
                              onMovieTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MovieScreen(element);
                                    },
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
              ),
              Tab(
                child: favouritesMovies.isEmpty
                    ? Center(
                        child: Text(
                          t.noFavourites,
                          style: Fonts.FONT_TITLE,
                        ),
                      )
                    : ListView.builder(
                        itemCount: favouritesMovies.length,
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
                              color: ProjectCodeColors.RED_COLOR,
                              child: Align(
                                alignment: Alignment(0.7, 0),
                                child: Icon(
                                  Icons.delete_forever,
                                  size: 32,
                                ),
                              ),
                            ),
                            child: MovieTile(
                              item: item,
                              isFavourite: true,
                              onMovieTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MovieScreen(item);
                                    },
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
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
    List<dynamic> res = await movieDB.getMoviesList(showErrorSnackBar);
    setState(() {
      movies = res;
      // Uncomment it if you want to render further releases

      // movies = res
      //     .where((dynamic el) =>
      //         DateTime.parse(el['release_date']).isAfter(DateTime.now()))
      //     .toList();
    });
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

  String formatDate(String date) {
    return Jiffy(date).format('y-MM-01').toUpperCase();
  }

  void showErrorSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        'Oops, data loading error! Please check your internet connection or try later.',
      ),
      backgroundColor: ProjectCodeColors.RED_COLOR,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> _logOut() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AppExitAlertDialog(
            onExitPress: () async {
              try {
                await _auth.signOut();
                await Navigator.pushNamedAndRemoveUntil(
                  context,
                  WelcomeScreen.id,
                  (route) => false,
                );
              } catch (e) {
                print(e);
              }
            },
          );
        });
    return true;
  }
}
