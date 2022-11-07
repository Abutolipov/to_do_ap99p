import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/db/notes_database.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/note_model.dart';
import '../wiget/flag.dart';
import 'home_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
int? id;
class Detail_page extends StatefulWidget {
  final int nodeId;
  const Detail_page({Key? key, required this.nodeId}) : super(key: key);

  @override
  State<Detail_page> createState() => _Detail_pageState();
}

class _Detail_pageState extends State<Detail_page> {

  //DateTime selectedDate = DateTime.now();

  late Note note;
  late bool isLoading=false;
   String title="";
   String description="";
   String category="";
   String categoryIcon="";
   int number=0;
   DateTime createdTime=DateTime.now();
  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future refresh()async{
    this.note=await NotesDatabase.instance.readNote(widget.nodeId);

    setState(() {
       title = note.title;
       description = note.description;
       createdTime=note.createdTime;
       number=note.number;
       category=note.category;
       categoryIcon=note.categoryIcon;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:createdTime,
      lastDate: DateTime(2100),
      firstDate: DateTime.now(),
      confirmText: "Choose time",
      helpText: "",
      initialDatePickerMode: DatePickerMode.day,

      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Color(0xff363636),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(
                0xff363636),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.indigo,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != createdTime) {
      setState(() {
        createdTime = picked;
        updateNoteTime();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Detail_page(nodeId:id!)));
      });
    }
  }




  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon:Icon(CupertinoIcons.xmark,color: Colors.white,),
        onPressed: (){},
      ),
      actions: [
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.repeat),
        )
      ],
    ),
    body:Container(
      padding: EdgeInsets.all(18),
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                  SizedBox(width:25,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title.length>20?title.substring(0,20):title,
                          style:GoogleFonts.lato(color: Colors.white,fontSize:20,fontWeight: FontWeight.w400)),
                      SizedBox(height: 5,),
                      Container(child: Text(description.length>20?description.substring(0,20):description,style:GoogleFonts.lato(color: Color(0xffAFAFAF),fontSize:16,fontWeight: FontWeight.w400))),
                    ],
                  ),
                ],
              ),
              IconButton(
                  onPressed:(){
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
                              Text("Edit Task title",style:TextStyle(color: Colors.white),),
                              Divider(thickness:1,color: Colors.white,),
                              SizedBox(height:12,),
                              buildTitle(),
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
                                          onPressed:(){},
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
                                           await updateNote();
                                           refresh();
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
               icon:Icon(Icons.edit_outlined,color: Colors.white,))
            ],
          ),
         SizedBox(height:50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(

                child: Row(
                  children: [
                    Icon(Icons.timer_outlined,color: Colors.white,),
                    SizedBox(width:25,),
                    Text("Task time",style:GoogleFonts.lato(color: Colors.white,fontWeight: FontWeight.w400,fontSize:16),)

                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff363636),
                ),
                  onPressed: () {
                    _selectDate(context);
                  },
                  child:Text(DateFormat.yMMMd().format(createdTime)),
              )
            ],
          ),
          SizedBox(height:20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.task_sharp,color: Colors.white,),
                  SizedBox(width:25,),
                  Text("Task Category",style:GoogleFonts.lato(color: Colors.white,fontWeight: FontWeight.w400,fontSize:16),)

                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff363636),
                ),
                onPressed:() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context,state){
                            return SizedBox(
                              width: 350,
                              height: 350,
                              child: AlertDialog(
                                backgroundColor: Color(0xff363636),
                                title: Column(
                                  children: [
                                    const Text(
                                      "Choose Category",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: 340,
                                      height: 2,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                content:Container(
                                  padding: EdgeInsets.only(left:12,right:12, top:25,bottom:3),
                                  width: 360,
                                  height: 450,

                                  child: GridView.builder(
                                      itemCount: 10,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing:20,
                                        mainAxisExtent: 120,
                                      ),
                                      itemBuilder:(BuildContext contex, int index) {
                                        return InkWell(
                                          onTap: (){
                                            category=list2[index];
                                            categoryIcon=list3[index];
                                            updateNoteCategory();
                                            refresh();
                                            Navigator.pop(context);
                                          },
                                          child: Category(
                                              list[index]as String,
                                              list2[index] as String),
                                        );
                                      }),
                                ),
                              ),
                            );
                          },
                        );
                      });
                },
                child:Text(category),
              )
            ],
          ),
          SizedBox(height:20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.flag,color: Colors.white,),
                  SizedBox(width:25,),
                  Text("Task Priority",style:GoogleFonts.lato(color: Colors.white,fontWeight: FontWeight.w400,fontSize:16),)

                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff363636),

                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context,state){
                            return SizedBox(
                              width: 350,
                              height: 350,
                              child: AlertDialog(
                                backgroundColor: Color(0xff363636),
                                title: Column(
                                  children: [
                                    const Text(
                                      "Task priority",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: 340,
                                      height: 2,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                content: Stack(
                                  children: [
                                    Container(
                                      width: 360,
                                      height: 270,
                                      // color: Colors.transparent,
                                      child: GridView.builder(
                                          itemCount: 10,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4),
                                          itemBuilder:
                                              (BuildContext contex, int index) {
                                            return InkWell(
                                              onTap: () {
                                                state(() {
                                                  nimadir=index;
                                                  number = index+1;
                                                  isOn=!isOn;
                                                });
                                              },
                                              child: Container(
                                                margin:const EdgeInsets.only(
                                                    left: 4, top: 4, right: 4),
                                                width: 64,
                                                height: 64,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(4),
                                                    color: nimadir==index ?const Color(0xff8875ff) : const Color(0xff272727)),
                                                child: Column(
                                                  children: [
                                                    const Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                            top: 6),
                                                        child:Icon(Icons.flag_outlined)
                                                    ),
                                                    const   SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      "${index + 1}",
                                                      style:const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    Positioned(
                                      bottom: 4,
                                      right: 10,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Container(
                                              width: 123,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(4),
                                                  color: Colors.transparent),
                                              child:const Center(
                                                  child: TextButton(
                                                      onPressed: null,
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color:
                                                            Color(0xff8577ff),
                                                            fontSize: 16),
                                                      ))),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          const    SizedBox(
                                            width: 30,
                                          ),
                                          InkWell(
                                            child: Container(
                                              width: 123,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(4),
                                                  color: Color(0xff8577ff)),
                                              child:const Center(
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  )),
                                            ),
                                            onTap: () {
                                              updateNotePriority();
                                              refresh();
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                },
                child:Text(number.toString()),
              )
            ],
          ),
          SizedBox(height:20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.category_sharp,color: Colors.white,),
                  SizedBox(width:25,),
                  Text("Sub-Task",style:GoogleFonts.lato(color: Colors.white,fontWeight: FontWeight.w400,fontSize:16),)

                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff363636),

                ),
                onPressed: (){

                },
                child:Text("Add Sub task"),
              )
            ],
          ),
          SizedBox(height:20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.delete,color: Colors.red,),
                  SizedBox(width:20,),
                 TextButton(onPressed: (){
                   dalete();
                   Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>MainPage()));
                 }, child: Text("Delate",style: TextStyle(color: Colors.red,fontWeight:FontWeight.w400,fontSize:18),))

                ],
              ),
            ],
          ),
        ],
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton:Container(
      margin: EdgeInsets.symmetric(horizontal:20),
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff8687e7)
        ),
        onPressed: (){
         updateNoteTime();
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>MainPage()));
        },
        child:Text("Submit"),
      ),
    ),
  );
  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue:note.title,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.w400,
      fontSize:15,
    ),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide:const  BorderSide(
          color: Colors.white,
          width:0.6,
        ),
      ),
      enabledBorder:InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.white70),
    ),
     onChanged: (titl){
      setState(() {
        this.title=titl;
      });
     },
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,

  );

  Widget buildDescription() => TextFormField(
    initialValue:note.description,
    style: TextStyle(color: Colors.white60, fontSize: 14),
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
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    onChanged: (desc){
      setState(() {
       this.description=desc;
      });
    },
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
  );

  Future updateNote()async{
    final update=note.copy(
      title:title,
      description:description,
    );
    await NotesDatabase.instance.update(update);
  }

  Future updateNoteTime()async{
    final updateNote=note.copy(
      createdTime:createdTime,
    );
    await NotesDatabase.instance.update(updateNote);
  }

  Future updateNotePriority()async{
    final updateNote=note.copy(
     number:number,
    );
    await NotesDatabase.instance.update(updateNote);
  }
  Future updateNoteCategory()async{
    final category2=note.copy(
      category:category,
      categoryIcon:categoryIcon

    );
    await NotesDatabase.instance.update(category2);
  }

  Future dalete()async{
    await NotesDatabase.instance.delete(widget.nodeId);
  }



  List list =[
    "assets/images/fi.svg",
    "assets/images/1.svg",
    "assets/images/ik.svg",
    "assets/images/u.svg",
    "assets/images/to.svg",
    "assets/images/5.svg",
    "assets/images/o.svg",
    "assets/images/y.svg",
    "assets/images/s.svg",
    "assets/images/t.svg",

  ];
  List list2 =[
    "Grocery",
    "Work",
    "Sport",
    "Design",
    "Unversity",
    "Social",
    "Music",
    "Health",
    "Movie",
    "Home",

  ];
  List list3 =[
    "assets/images/i1.svg",
    "assets/images/i2.svg",
    "assets/images/i3.svg",
    "assets/images/i4.svg",
    "assets/images/i5.svg",
    "assets/images/i6.svg",
    "assets/images/i7.svg",
    "assets/images/i8.svg",
    "assets/images/i9.svg",
    "assets/images/i10.svg",

  ];

  Widget Category(String image2, String text){
    return  Container(
      child: Column(
        children: [
          Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(4),
              ),
              child:SvgPicture.asset(image2,width:64,height:64,)

          ),
          SizedBox(height:5,),
          Text(text,style:TextStyle(color: Colors.white,fontSize:14,fontWeight: FontWeight.w500),),
          //  SizedBox(height:15,),
        ],
      ),
    );
  }
}
