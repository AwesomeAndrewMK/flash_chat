import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';

class MovieScreen extends StatefulWidget {
  static String id = 'movie_screen';
  MovieScreen(this.item);
  final Map item;

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title'].toString()),
        backgroundColor: mainAppColor,
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
                    'Name: ',
                    style: font_large_bold,
                  ),
                  Expanded(
                    child: Text(
                      widget.item['title'].toString(),
                      style: font_large,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Average score: ',
                    style: font_large_bold,
                  ),
                  Text(
                    widget.item['vote_average'].toString(),
                    style: font_large,
                  ),
                ],
              ),
              Text(
                'Description:',
                style: font_large_bold,
              ),
              Text(
                widget.item['overview'].toString(),
                style: font_medium,
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
