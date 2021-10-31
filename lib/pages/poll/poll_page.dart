import 'package:election_exit_poll_07610567/pages/poll/poll_page_result.dart';
import 'package:flutter/material.dart';
import 'package:election_exit_poll_07610567/models/poll_item.dart';
import 'package:election_exit_poll_07610567/pages/poll/poll_list_page.dart';
import 'package:election_exit_poll_07610567/services/api.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  var _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outlined),
            label: 'โหวต',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_alt),
            label: 'คะแนนโหวต',
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _fetchFoods,
        child: Icon(Icons.add),
      ),*/
      body: _selectedBottomNavIndex == 0
          ? FoodListPage()
          : PollPageResult()
    );
  }

  _fetchFoods() async {
    try {
      var list = (await Api().fetch('exit_poll')) as List<dynamic>;
      var foodList = list.map((item) => FoodItem.fromJson(item)).toList();
      print('Number of foods: ${foodList.length}');
    } catch (e) {
      var msg = 'ERROR: $e';
      print(msg);
    }
  }
}
