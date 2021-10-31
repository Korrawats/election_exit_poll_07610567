import 'package:flutter/material.dart';
import 'package:election_exit_poll_07610567/models/poll_item.dart';
import 'package:election_exit_poll_07610567/pages/poll/food_details_page.dart';
import 'package:election_exit_poll_07610567/services/api.dart';
import 'package:google_fonts/google_fonts.dart';

class PollPageResult extends StatefulWidget {
  static const routeName = '/food_list_page';

  const PollPageResult({Key? key}) : super(key: key);

  @override
  _PollPageResultState createState() => _PollPageResultState();
}

class _PollPageResultState extends State<PollPageResult> {
  late Future<List<FoodItem>> _futureFoodList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<FoodItem>>(
        // ข้อมูลจะมาจาก Future ที่ระบุให้กับ parameter นี้
        future: _futureFoodList,

        // ระบุ callback function ซึ่งใน callback นี้เราจะต้อง return widget ที่เหมาะสมออกไป
        // โดยดูจากสถานะของ Future (เช็คสถานะได้จากตัวแปร snapshot)
        builder: (context, snapshot) {
          // กรณีสถานะของ Future ยังไม่สมบูรณ์
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // กรณีสถานะของ Future สมบูรณ์แล้ว แต่เกิด Error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ผิดพลาด: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureFoodList = _loadFoods();
                      });
                    },
                    child: Text('RETRY'),
                  ),
                ],
              ),
            );
          }

          // กรณีสถานะของ Future สมบูรณ์ และสำเร็จ
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var foodItem = snapshot.data![index];

                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: InkWell(
                    onTap: () => _handleClickFoodItem(foodItem),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          '${foodItem.number}',
                                          style: GoogleFonts.prompt(fontSize: 20.0),
                                        ),
                                        Text(
                                          ' ${foodItem.fullName}',
                                          style: GoogleFonts.prompt(fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(' ${foodItem.score}',
                          style: GoogleFonts.prompt(fontSize: 15.0),),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<List<FoodItem>> _loadFoods() async {
    List list = await Api().fetch('exit_poll/result');
    var foodList = list.map((item) => FoodItem.fromJson(item)).toList();
    return foodList;
  }

  @override
  initState() {
    super.initState();

    // เก็บ Future ที่ได้จาก _loadFoods ลงใน state variable
    // แล้วทำการ build widget จากตัวแปรนี้ โดยใช้ FutureBuilder มาช่วย
    _futureFoodList = _loadFoods();
  }

  _handleClickFoodItem(FoodItem foodItem) {
    Navigator.pushNamed(
      context,
      FoodDetailsPage.routeName,
      arguments: foodItem,
    );
  }
}
