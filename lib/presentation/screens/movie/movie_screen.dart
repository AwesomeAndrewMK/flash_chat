import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';

class MovieScreen extends StatefulWidget {
  static String id = 'movie';
  MovieScreen(this.item);
  final Map item;

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title'].toString()),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(
                height: 16,
              ),
              Image(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${widget.item['backdrop_path']}',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.name + ': ',
                    style: Fonts.FONT_LARGE,
                  ),
                  Expanded(
                    child: Text(
                      widget.item['title'].toString(),
                      style: Fonts.FONT_LARGE,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    t.averageScore + ': ',
                    style: Fonts.FONT_LARGE_BOLD,
                  ),
                  Text(
                    widget.item['vote_average'].toString(),
                    style: Fonts.FONT_LARGE,
                  ),
                ],
              ),
              Text(
                t.description + ':',
                style: Fonts.FONT_LARGE_BOLD,
              ),
              Text(
                widget.item['overview'].toString(),
                style: Fonts.FONT_MEDIUM,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
