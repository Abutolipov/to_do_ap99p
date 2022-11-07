import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/screens/login_page.dart';
import 'package:to_do_app/screens/register_page.dart';
class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool tr=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.arrow_back_ios_new,size:18,),
        ),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Welcome to UpTodo",style:GoogleFonts.lato(color: Colors.white,fontWeight: FontWeight.w700,fontSize:32,),),
          const SizedBox(height:25,),
          Text("Please login to your account or create ",  style: TextStyle(color: Colors.white,fontSize:16),),
          const SizedBox(height:5,),
          Text("new account to continue",  style: TextStyle(color: Colors.white,fontSize:16),),
          const SizedBox(height: 340,),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left:20,right:20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff8875FF),
                  minimumSize:Size(327, 53),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                },
                child: Text("Login"),
              ),
            ),
          ),
          SizedBox(height:25,),
          InkWell(
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal:40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff8875FF))
              ),
              padding: EdgeInsets.only(left:40,right:40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize:Size(327, 53),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterPage()));
                },
                child: Text("CREATE ACCOUNT"),
              ),
            ),
          ),
          SizedBox(height:30,),
        ],
      ),
    );
  }
}
