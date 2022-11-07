
import 'package:flutter/material.dart';
import 'am_pm.dart';
import 'hours.dart';
import 'minuts.dart';
class HomePagew extends StatefulWidget {
  const HomePagew({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePagew> {
  late FixedExtentScrollController _controller;
  @override
  void initState() {
    super.initState();

    _controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content :Container(
          color: Color(0xff363636),
          height: 200,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Choose time",style: TextStyle(color: Colors.white),),
              Divider(thickness:2,color: Colors.white,),
              SizedBox(height:15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0xff272727),
                    height: 60,
                    width: 60,
                    child: ListWheelScrollView.useDelegate(
                      controller: _controller,
                      itemExtent:50,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 13,
                        builder: (context, index) {
                          return MyHours(
                            hours: index,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Color(0xff272727),
                    height: 60,
                    width: 60,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 50,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 60,
                        builder: (context, index) {
                          return MyMinutes(
                            mins: index,
                          );
                        },
                      ),
                    ),
                  ),
                 const SizedBox(
                    width: 15,
                  ),

                  Container(
                    color: Color(0xff272727),
                    height: 60,
                    width: 60,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 50,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 2,
                        builder: (context, index) {
                          if (index == 0) {
                            return AmPm(
                              isItAm: true,
                            );
                          } else {
                            return AmPm(
                              isItAm: false,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:10,),

            ],
          ),
        ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child:Text("Cancel",style: TextStyle(color: Colors.indigo),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child:Text("Edit"),
            )
          ],
        )
      ],
      );
  }
}