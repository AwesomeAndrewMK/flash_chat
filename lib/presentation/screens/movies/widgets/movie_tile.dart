import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:share/share.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_chat_flutter/common/utils/theme_cubit.dart';

class MovieTile extends StatelessWidget {
  MovieTile({
    required this.item,
    this.onAddToFavourites,
    this.isFavourite,
    this.isItemInFavourites,
    this.movieId,
    this.onMovieTap,
  });

  final dynamic item;
  final VoidCallback? onAddToFavourites;
  final VoidCallback? onMovieTap;
  final bool? isFavourite;
  final bool? isItemInFavourites;
  final int? movieId;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return ListTile(
      contentPadding: EdgeInsets.all(8),
      title: BlocBuilder<ThemeCubit, bool>(
        builder: (BuildContext context, value) {
          return PhysicalModel(
            color: value
                ? ProjectCodeColors.TRANSPARENT_COLOR
                : ProjectCodeColors.WHITE_COLOR,
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
                      child: GestureDetector(
                        onTap: onMovieTap,
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
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: onMovieTap,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'].toString(),
                                  style: Fonts.FONT_MOVIE_TITLE,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  item['overview'].toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Fonts.FONT_MOVIE_DESCRIPTION,
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                          Container(
                            child: isFavourite == true
                                ? Column()
                                : Column(
                                    children: [
                                      Divider(
                                        color: ProjectCodeColors.GREY_COLOR,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => onAddToFavourites!(),
                                            child: Text(
                                              isItemInFavourites == true
                                                  ? t.inFavourites.toUpperCase()
                                                  : t.addToFavourites
                                                      .toUpperCase(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    isItemInFavourites == true
                                                        ? ProjectCodeColors
                                                            .GREY_COLOR
                                                        : ProjectCodeColors
                                                            .MAIN_COLOR,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Share.share(
                                                  'https://www.themoviedb.org/movie/$movieId');
                                            },
                                            child: Text(
                                              t.share.toUpperCase(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ProjectCodeColors
                                                    .MAIN_COLOR,
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
          );
        },
      ),
    );
  }
}
