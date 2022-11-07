import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';



class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool tr=true;
  bool tr2=false;
  bool tr3=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,size:18,),
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25,20, 25, 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Register",style:GoogleFonts.lato(fontSize:32,color: Colors.white,fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height:28,
                    ),

                    Text(
                        "Username",
                        style:GoogleFonts.lato(fontSize:14,color: Colors.white,fontWeight: FontWeight.w400)
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff979797)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: double.infinity,
                      child: TextFormField(
                        onChanged: (v){
                          setState(() {
                          });
                        },
                        cursorColor:Colors.white,
                        controller: emailController,
                        style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13,
                            color: Colors.white
                        ),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xff1d1d1d),
                          focusedBorder: InputBorder.none,
                          hintText: "Enter your Username",
                          hintStyle: TextStyle(color: Color(0xff535353)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Invalid email";
                          } else {
                            tr=true;
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    const Text(
                      " Password",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xff979797),
                        ),
                      ),
                      width: double.infinity,
                      child:TextFormField(
                        onChanged: (v){
                          setState(() {
                            passController.text.length>7?tr2=true:tr2=false;
                          });
                        },
                        cursorColor:Colors.white,
                        obscureText: true,
                        controller: passController,
                        style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13,
                            color: Colors.white),
                        decoration: const InputDecoration(
                          border:InputBorder.none,
                          filled: true,
                          fillColor:Color(0xff1d1d1d),
                          focusedBorder: InputBorder.none,
                          hintText: "Your password",
                          hintStyle:  TextStyle(color: Color(0xff535353)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Invalid password";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height:15,
                    ),
                    const Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xff979797),
                        ),
                      ),
                      width: double.infinity,
                      child:TextFormField(
                        onChanged: (v){
                          setState(() {
                            passController.text==codeController.text?tr3=true:tr3=false;
                            emailController.text.length>7?tr=false:true;
                          });
                        },
                        cursorColor:Colors.white,
                        obscureText: true,
                        controller: codeController,
                        style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13,
                            color: Colors.white),
                        decoration: const InputDecoration(
                          border:InputBorder.none,
                          filled: true,
                          fillColor:Color(0xff1d1d1d),
                          focusedBorder: InputBorder.none,
                          hintText: "Confirm password",
                          hintStyle:  TextStyle(color: Color(0xff535353)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Invalid password";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    const SizedBox(
                      height:35,
                    ),
                    InkWell(
                      child: Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:tr!=tr3?Color(0xff8875FF):Color.fromRGBO(134, 135, 231, 0.5),
                            minimumSize:Size(327, 48),
                          ),
                          onPressed: ()async{
                            if(emailController.text.length>2){
                              SharedPreferences pref=await SharedPreferences.getInstance();
                              pref.setString('pass2',emailController.text);
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  MainPage()), (Route<dynamic> route) => false);
                            }else {
                              final snackBar = SnackBar(
                                content: const Text('User name not found!'),
                                backgroundColor: (Color(0xff4157FF)),
                                action: SnackBarAction(
                                  label: 'dismiss',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                          },
                          child: Text("Register"),
                        ),
                      ),
                    ),
                    SizedBox(height:25),
                    SvgPicture.asset("assets/images/divider.svg"),
                    SizedBox(height:30),
                    InkWell(
                      child:Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Color(0xff8875FF))
                        ),
                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            backgroundColor: Colors.black,
                            minimumSize:Size(327, 48),
                          ),
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/google.svg"),
                              SizedBox(width:15,),
                              Text("Login with Google",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:20,),
                    InkWell(
                      child:Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Color(0xff8875FF))
                        ),
                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            backgroundColor: Colors.black,
                            minimumSize:Size(327, 48),
                          ),
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/apple.svg"),
                              SizedBox(width:15,),
                              Text("Login with Google",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:55,),
                    InkWell(
                      onTap: (){
                       // Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",style: TextStyle(color: Colors.grey),),
                          Text("Login",style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
