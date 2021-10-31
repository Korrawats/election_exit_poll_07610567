import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:election_exit_poll_07610567/helpers/platform_aware_asset_image.dart';
import 'package:election_exit_poll_07610567/pages/poll/poll_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedDrawerItemIndex = 0;

  final _pageDataList = [
    {
      'title': 'Exit POLL',
      'page': FoodPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDataList[_selectedDrawerItemIndex]['title'] as String),
        /*actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
        ],*/
      ),
      body: Container(
        child: _pageDataList[_selectedDrawerItemIndex]['page'] as Widget,
      ),
    );
  }
}
