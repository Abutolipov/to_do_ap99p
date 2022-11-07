
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/screens/onBoarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
class MyCustomWidget extends StatefulWidget {
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}
String? userEmail;
String? userEmail2;
class _MyCustomWidgetState extends State<MyCustomWidget> {
  late bool isHome;
  late String asa;
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:2), () {
      dataa().whenComplete(()async{
        if( userEmail!=null || userEmail2!=null){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>MainPage()),(Route<dynamic> route) => false);
        }else{
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>PageOnBoarding()),(Route<dynamic> route) => false);
        }
      });
    });

  }
  Future dataa()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var obtain=await pref.getString('pass');
    var obtain2=await pref.getString('pass2');
    setState(() {
      userEmail=obtain;
      userEmail2=obtain2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/logo.svg",width:95,height:80,),
                Text("Up todo",style:GoogleFonts.lato(color: Colors.white,fontWeight: FontWeight.w700,fontSize:40,),),
              ],
            )
          ),
        ),
      ),
    );
  }
}

