import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:share/share.dart';

class MovieTile extends StatelessWidget {
  MovieTile({
    @required this.item,
    this.onAddToFavourites,
    this.isFavourite,
    this.isItemInFavourites,
    this.movieId,
  });

  final dynamic item;
  final VoidCallback onAddToFavourites;
  final bool isFavourite;
  final bool isItemInFavourites;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      title: PhysicalModel(
        color: Colors.white,
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${item['backdrop_path']}',
                        ),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(item['vote_average'].toString()),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(item['overview'].toString()),
                      SizedBox(height: 8),
                      Container(
                        child: isFavourite == true
                            ? Column()
                            : Column(
                                children: [
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => onAddToFavourites(),
                                        child: Text(
                                          isItemInFavourites == true
                                              ? 'IN FAVOURITES'
                                              : 'ADD TO FAVOURITES',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isItemInFavourites == true
                                                ? Colors.grey
                                                : mainAppColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Share.share(
                                              'https://www.themoviedb.org/movie/$movieId');
                                        },
                                        child: Text(
                                          'SHARE',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: mainAppColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
