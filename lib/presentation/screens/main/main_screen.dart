import 'package:flutter/material.dart';
import '../movies/movies_screen.dart';
import '../chat/chat_screen.dart';
import 'package:flash_chat_flutter/presentation/screens/screens.dart';
import 'package:flash_chat_flutter/presentation/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    MoviesScreen(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _logOut,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: ProjectCodeColors.MAIN_COLOR,
          onTap: _onItemTapped,
        ),
      ),
    );
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
    return false;
  }
}
