import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do_app/screens/detail_page.dart';
import 'package:to_do_app/screens/splash.dart';
import '../db/notes_database.dart';
import 'package:intl/intl.dart';
import '../model/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();
}
bool isLoading=false;
class _HomePageState extends State<HomePage> {

  late List<Note>notes;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }



  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  int index=0;
  int index2=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: IconButton(
          onPressed: ()async{
            SharedPreferences pref=await SharedPreferences.getInstance();
            pref.remove('pass');
            pref.remove('pass2');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MyCustomWidget()));
          },
          icon: Icon(Icons.exit_to_app_outlined),
        ),
        backgroundColor: Colors.black,
        title: Text("HomePage"),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body:SafeArea(
          child: isLoading
            ? Center(child: CircularProgressIndicator())
            : notes.isEmpty
            ? Center(
              child: Container(
          padding: EdgeInsets.all(18),
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/home_logo.svg"),
                  Text("What do you want to do today?",style:GoogleFonts.lato(color: Colors.white,fontSize:20,fontWeight:FontWeight.w400)),
                  SizedBox(height:10,),
                  Text("Tap + to add your tasks",style:GoogleFonts.lato(color: Colors.white,fontSize:16,fontWeight:FontWeight.w400)),

                ],
              ),
          ),
        ),
            ):SingleChildScrollView(
              child: Column(
                children: [
                  buildNotes(),
                  buildNotesC(),
                ],
              ),
            )
      ),
    );
  }
  Widget buildNotes() => ExpansionTile(
    iconColor: Colors.white,
    title: Text("Today's",style: TextStyle(color: Colors.white),),
    children: [
      StaggeredGridView.countBuilder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () {
              id=note.id!;
             Navigator.push(context, MaterialPageRoute(builder: (_)=>Detail_page(nodeId: note.id!)));
            },
            //ikki marta bosga
            onDoubleTap: (){

            },

            child:NoteCardWidget(note: note, index: index),
          );
        },
      ),
    ],
  );
  Widget buildNotesC() => ExpansionTile(
    iconColor: Colors.white,
    title: Text("Completed",style: TextStyle(color: Colors.white),),
    children: [
      StaggeredGridView.countBuilder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () {
              id=note.id!;
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Detail_page(nodeId: note.id!)));
            },

            child:NoteCardWidget(note: note, index: index),
          );
        },
      ),
    ],
  );
}



class NoteCardWidget extends StatefulWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  final _lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100
  ];

  @override
  Widget build(BuildContext context) {

    final color = _lightColors[widget.index % _lightColors.length];
    final time = DateFormat.yMMMd().format(widget.note.createdTime);


    return Card(
      color:Color(0xff363636),
      child: Container(
        constraints: BoxConstraints(minHeight:100,maxHeight:100),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width:25,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:10,),
                    Container(
                      child: Text(
                        widget.note.title.length>10?widget.note.title.substring(0,8):widget.note.title,
                        maxLines:5,
                        overflow:TextOverflow.clip,
                        style:const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          overflow:TextOverflow.fade,

                        ),
                      ),
                    ),
                    SizedBox(height:15),
                    Text(
                      time,
                      style: TextStyle(color: Colors.white,fontSize:16),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color:color,
                        borderRadius:BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(widget.note.categoryIcon,width:30,height:30,),
                            SizedBox(width:7,),
                            Text(widget.note.category,style: GoogleFonts.lato(color: Colors.white,fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width:12,),
                    Container(
                      width: 60,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color:Color(0xff8687e7),width:2),
                        borderRadius:BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.flag_outlined,color: Colors.white,),
                            SizedBox(width:3,),
                            Text(widget.note.number.toString(),style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}