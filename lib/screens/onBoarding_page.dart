import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/screens/login_page.dart';
import 'package:to_do_app/screens/start_page.dart';
class PageOnBoarding extends StatefulWidget {
  const PageOnBoarding({Key? key}) : super(key: key);

  @override
  State<PageOnBoarding> createState() => _PageOnBoardingState();
}
bool isLastIndex=false;
class _PageOnBoardingState extends State<PageOnBoarding> {
  final controller=PageController();
  int page_index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Stack(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.only(bottom:80),
            child: PageView(
              onPageChanged: (index){
                setState(()=>isLastIndex=index==2);
              },
              controller:controller,
              children: [
                buildPage(urlImage:"assets/images/on1.svg",title:"Manage your tasks",subTitle1:'You can easly manage all of your daily',subTitle2:'tasks in DoMe for free'),
                buildPage(urlImage:"assets/images/on2.svg",title:"Create daily routine ",subTitle1:'In Uptodo you can create your',subTitle2:'personalized routine to say productive ',),
                buildPage(urlImage:"assets/images/on3.svg",title:"Orgoniaze your tasks",subTitle1:'you can organize your daily task by',subTitle2:'additing your task into separete categories',),
              ],
            ),

          ),
          Column(
            children: [
              SizedBox(height:30,),
              TextButton(onPressed: (){
                controller.jumpToPage(2);
              }, child:Text("      SKIP",style: GoogleFonts.lato(fontWeight: FontWeight.w400,fontSize:16,color: Colors.white.withOpacity(0.44)),)),
            ],
          ),
          Center(
            child:SmoothPageIndicator(
              controller:controller,
              count:3,
              effect: const WormEffect(
                spacing: 8,
                dotColor: Color(0xffAFAFAF),
                dotWidth:20,
                dotHeight:4,
                activeDotColor: Color(0xffFFFFFF),
                type: WormType.thin,
              ),
              onDotClicked:(index)=>controller.animateTo(
                  index.toDouble(),
                  duration:Duration(milliseconds:500),
                  curve:Curves.easeIn
              ),
            ),
          ),

        ],
      ),
      bottomSheet:Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal:20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed:()=>controller.previousPage(duration:Duration(milliseconds:1000), curve:Curves.easeIn),
                child:Text("BACK",style:GoogleFonts.lato(fontWeight: FontWeight.w400,fontSize:16,color: Colors.white.withOpacity(0.44))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                 minimumSize:Size(90, 48),
                 maximumSize: Size(150, 48),
                 backgroundColor: Color(0xff8875FF),
              ),
                onPressed:()async{
                  if(isLastIndex){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Start()), (route) => false);
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginPage()));
                    SharedPreferences pref=await SharedPreferences.getInstance();
                    pref.setBool('showHome', true);
                  }
                  controller.nextPage(duration: Duration(milliseconds:500), curve:Curves.easeIn);
                 },
                 child:Text(isLastIndex?" GET STARTED ":"NEXT")
            )
          ],
        ),
      ),
    );
  }
  Widget buildPage({required String urlImage, required String title, required String subTitle1,required String subTitle2}){
    return Container(
      color: Colors.black,
       child:Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Column(
             children: [
                SizedBox(height:60,),
              // TextButton(onPressed: (){
              //  controller.jumpToPage(2);
              //}, child:Text("      SKIP",style: GoogleFonts.lato(fontWeight: FontWeight.w400,fontSize:16,color: Colors.white.withOpacity(0.44)),)),
             ],
           ),
           SizedBox(height:25,),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                   width:double.infinity,
                   padding: EdgeInsets.symmetric(horizontal:20),
                   child: SvgPicture.asset(urlImage,fit: BoxFit.fitHeight,width:213,height:277,)),
               SizedBox(height:30,),
               SizedBox(height:50,),
               Text(title,style: TextStyle(color: Colors.white,fontSize:32,fontWeight: FontWeight.bold),),
               SizedBox(height:40,),
               Container(
                 padding: EdgeInsets.symmetric(horizontal:20),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                       subTitle1,
                       style: TextStyle(color: Colors.white,fontSize:16),
                     ),
                     Text(
                       subTitle2,
                       style: TextStyle(color: Colors.white,fontSize:16),
                     ),
                   ],
                 ),
               )
             ],
           ),
         ],
       ),
    );
  }
}
