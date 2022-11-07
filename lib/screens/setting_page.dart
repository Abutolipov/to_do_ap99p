import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/screens/splash.dart';
import 'package:easy_localization/easy_localization.dart';
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  String? name;


  @override
  void initState() {
    Name();
    super.initState();
  }
  Future Name()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      name=prefs.getString('pass');
    });
  }
  final nameController=TextEditingController();
  int index = 1;
  @override
  Widget build(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'us':
        index = 1;
        break;
      case 'ru':
        index = 2;
        break;
      case 'uz':
        index = 3;
        break;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("profile".tr(),style: GoogleFonts.lato(color: Colors.white,),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height:20,),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/300",
                    ),
                  ),
                  SizedBox(height:10,),
                  Text(name??"",style:GoogleFonts.lato(color: Colors.white,fontSize:20,fontWeight: FontWeight.w500),),






                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 154,
                        height: 58,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff363636)

                        ),
                        child:  Center(
                          child: Text("10 "+"task_done".tr(),style: TextStyle(color: Colors.white,fontSize:16),),
                        ),
                      ),
                      Container(
                        width: 154,
                        height: 58,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff363636)

                        ),
                        child:Center(
                          child: Text("5 "+"task_left".tr(),style: TextStyle(color: Colors.white,fontSize:16),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:25,),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("app_setting".tr(),style: GoogleFonts.lato(color: Color(0xffafafaf)),),
                  SizedBox(height:20,),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (_){
                        return AlertDialog(
                          backgroundColor: Colors.black,
                         content:Container(
                           height: 200,
                           child: Column(
                             children: [
                               RadioListTile(
                                 activeColor: Colors.indigo,
                                 title: Text("Engilish",style: TextStyle(color: Colors.white),),
                                 value: 1,
                                 groupValue: index,
                                 onChanged: (val) {
                                   setState(() {
                                     index = val as int;
                                     context.setLocale(Locale('en', 'US'));
                                   });
                                 },
                               ),
                               RadioListTile(
                                 activeColor: Colors.indigo,
                                 title: Text("Rus",style: TextStyle(color: Colors.white),),
                                 value: 2,
                                 groupValue: index,
                                 onChanged: (val) {
                                   setState(() {
                                     index = val as int;
                                     context.setLocale(Locale('ru', 'RU'));
                                   });
                                 },
                               ),
                               RadioListTile(

                                 activeColor: Colors.indigo,
                                 title: Text("Uzbek",style: TextStyle(color: Colors.white),),
                                 value: 3,
                                 groupValue: index,
                                 onChanged: (val) {
                                   setState(() {
                                     index = val as int;
                                     context.setLocale(Locale('uz', 'UZ'));
                                   });
                                 },
                               ),
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
                      });

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.settings,color: Colors.white,),
                            SizedBox(width:20,),
                            Text("app_setting".tr(),style: GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,size:16,)
                      ],
                    ),
                  ),
                  SizedBox(height:20,),
                  Text("account".tr(),style: GoogleFonts.lato(color: Color(0xffafafaf)),),

                  SizedBox(height:20,),
                  InkWell(
                    onTap:(){
                      showDialog(
                          context: context, builder: (_){
                        return AlertDialog(
                          insetPadding: EdgeInsets.all(25.0),
                          shape:const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(10.0)),
                          ),
                          backgroundColor: Color(0xff363636),
                          content: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xff363636),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Change account name",style:TextStyle(color: Colors.white),),
                                Divider(thickness:1,color: Colors.white,),
                                SizedBox(height:15),
                                buildDescription(),
                              ],
                            ),
                          ),
                          actions: [
                            Container(
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height:48,
                                      child: ElevatedButton(
                                          style:ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xff363636)
                                          ),
                                          onPressed:(){
                                            Navigator.pop(context);
                                          },
                                          child:Text("Cancel")),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height:48,
                                      child: ElevatedButton(
                                        style:ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff8687E7),
                                         ),
                                        onPressed:()async{
                                          await updateName();
                                          Navigator.pop(context);
                                        },
                                        child:Text("Edit"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person,color: Colors.white,),
                            SizedBox(width:20,),
                            Text("name".tr(),style: GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,size:16,)
                      ],
                    ),
                  ),

                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.vpn_key_outlined,color: Colors.white,),
                          SizedBox(width:20,),
                          Text("password".tr(),style: GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size:16,)
                    ],
                  ),

                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.camera_alt_outlined,color: Colors.white,),
                          SizedBox(width:20,),
                          Text("image".tr(),style: GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size:16,)
                    ],
                  ),



                  SizedBox(height:20,),
                  Text("Uptodo",style: GoogleFonts.lato(color: Color(0xffafafaf)),),

                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.receipt_outlined,color: Colors.white,),
                          SizedBox(width:20,),
                          Text("about".tr(),style: GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size:16,)
                    ],
                  ),

                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.ac_unit_sharp,color: Colors.white,),
                          SizedBox(width:20,),
                          Text("faq".tr(),style: GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size:16,)
                    ],
                  ),

                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.flash_on_outlined,color: Colors.white,),
                          SizedBox(width:20,),
                          Text("help".tr(),style: GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size:16,)
                    ],
                  ),

                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite,color: Colors.white,),
                          SizedBox(width:20,),
                          Text("sup".tr(),style: GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400),)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size:16,)
                    ],
                  ),

                  SizedBox(height:20,),
                  InkWell(
                   onTap: ()async{
                     SharedPreferences pref=await SharedPreferences.getInstance();
                     pref.remove('pass');
                     pref.remove('pass2');
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MyCustomWidget()));
                   },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.logout_rounded,color: Colors.red,),
                            SizedBox(width:20,),
                            Text("out".tr(),style: GoogleFonts.lato(color: Colors.red,fontSize:16,fontWeight:FontWeight.w400),)
                          ],
                        ),

                      ],
                    ),
                  ),
                 const  SizedBox(height:50,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget buildDescription() => TextFormField(
    controller: nameController,
    style: const TextStyle(color: Colors.white60, fontSize: 14),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.6,
        ),
      ),
      enabledBorder:InputBorder.none,
      hintText: 'Your name',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    onChanged: (desc){
      setState(() {
        this.name=desc;
      });
    },
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
  );

  Future updateName()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
      return pref.setString('pass', nameController.text.toString());
  }
}
