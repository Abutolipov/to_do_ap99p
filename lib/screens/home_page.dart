import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/db/notes_database.dart';
import 'package:to_do_app/screens/setting_page.dart';
import 'package:to_do_app/screens/splash.dart';
import 'package:to_do_app/wiget/not.dart';
import '../model/note_model.dart';
import '../wiget/flag.dart';
import '../wiget/scroll_clock/am_pm.dart';
import '../wiget/scroll_clock/hours.dart';
import '../wiget/scroll_clock/minuts.dart';
import 'home_one.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
class MainPage extends StatefulWidget {
  final Note? note;

  const MainPage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late FixedExtentScrollController _controller;
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  late String category;
  late String categoryIcon;
  int index=0;
  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    category=widget.note?.category??'';
    categoryIcon=widget.note?.categoryIcon??'';

    _controller = FixedExtentScrollController();
  }
  int _selectedIndex = 0;
  String _time = "Not set";
  List<Widget> _pages = [
    HomePage(),
    Container(),
    Container(),
    Container(),
    Setting(),
  ];

  late List<Note>notes;
  bool isLoading=false;


  Future refreshNotes()async{
    setState(() {
      isLoading=false;
    });
    this.notes=await NotesDatabase.instance.readAllNotes();

    setState(() {
      isLoading=false;
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:selectedDate,
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  bool isSelceted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: Colors.black,

      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0),
              ),
            ),
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.335,
                  decoration: const BoxDecoration(
                    color: Color(0xff363636),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Add Task", style: GoogleFonts.lato(fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                      SizedBox(height:15,),
                      Form(
                       key: _formKey,
                        child: NoteFormWidget(
                          isImportant: isImportant,
                          number: number,
                          title: title,
                          description: description,
                              onChangedImportant: (isImportant) =>
                              setState(() => this.isImportant = isImportant),
                               onChangedNumber: (number) => setState(() => this.number = number),
                                onChangedTitle: (title) => setState(() => this.title = title),
                                onChangedDescription: (description) => setState(() => this.description = description),
                                onChangedCategory: (category) => setState(() => this.category = category),
                                onChangedCategoryIcon: (categoryIcon) => setState(() => this.categoryIcon = categoryIcon),

                        ),
                      ),
                      SizedBox(height:10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    showDialog(
                                        barrierColor: Color(0xff363636),
                                        context: context,
                                        builder:(context){
                                          return AlertDialog(
                                            backgroundColor: Colors.black,
                                            content :Container(
                                              padding: EdgeInsets.all(15),
                                              color: Color(0xff272727),
                                              height: 150,
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
                                    );
                                    _selectDate(context);
                                  },
                                  child: Icon(
                                    Icons.timer,
                                    color: Colors.white.withOpacity(0.87),
                                  )),
                              SizedBox(width: 20,),
                              InkWell(
                                  onTap: () {
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
                                                                 Navigator.pop(context);
                                                               },
                                                              child: Category(list[index]as String,
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
                                  child: Icon(
                                    Icons.pin_end,
                                    color: Colors.white.withOpacity(0.87),
                                  )),
                              SizedBox(width: 20,),
                              InkWell(
                                  onTap: () {
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
                                                                        ),),
                                                                ),
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
                                  child: Icon(Icons.flag,
                                    color: Colors.white.withOpacity(0.87),
                                  )),

                            ],
                          ),
                          IconButton(
                              onPressed:addOrUpdateNote,
                              icon:const  Icon(
                                Icons.send, color: Color(0xff8687E7),)),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
            height: 72,
            width: 72,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff8687E7),
            ),
            child: const Center(
              child: Text(
                "+",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          iconSize: 28,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.50),
          backgroundColor: Color(0xff363636),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Index',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(null),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch_later_outlined),
              label: 'Focus',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );


  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            MainPage()), (Route<dynamic> route) => false);
      } else {
        await addNote();
      }
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          MainPage()), (Route<dynamic> route) => false);

    }
  }
  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }
  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: selectedDate,
      category: category,
      categoryIcon: categoryIcon,
    );

    await NotesDatabase.instance.create(note);
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







