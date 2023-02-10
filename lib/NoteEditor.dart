// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simplenotepad/HomeScreen.dart';
import 'package:simplenotepad/Style/App_style.dart';

TextEditingController _TitleNoteController = TextEditingController();
TextEditingController _contentNoteController = TextEditingController();

String TitleNote = '';
String ContentNote = '';

class NoteEditor extends StatefulWidget {
  const NoteEditor({super.key});
  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  String _date = DateFormat.yMEd().add_jm().format(DateTime.now());
  getDocIndex() async {
    var idUser = FirebaseFirestore.instance.collection('Notes').doc().id;
    FirebaseFirestore.instance.collection('Notes').doc(idUser).set({
      'content_note': ContentNote,
      'time_note': _date,
      'title_note': TitleNote,
      'UID': idUser
    });
    Navigator.pop(context, MaterialPageRoute(builder: (BuildContext context) {
      return HomeScreen();
    }));
    print(idUser);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyle.backGroundCollor,
      appBar: AppBar(
          backgroundColor: AppStyle.backGroundCollor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppStyle.Button,
                size: 28,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                minLines: 1,
                maxLines: null,
                controller: _TitleNoteController,
                onChanged: (value) {
                  TitleNote = value;
                },
                onEditingComplete: () {
                  TitleNote = _TitleNoteController.text;
                },
                keyboardType: TextInputType.multiline,
                cursorColor: AppStyle.MainColor,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(fontSize: 24, color: AppStyle.Headline),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note Title",
                    hintStyle: TextStyle(color: AppStyle.Headline)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                _date,
                style: TextStyle(color: AppStyle.Headline, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        bottom: BorderSide(width: 2, color: AppStyle.Stroke)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                          color: Colors.black.withOpacity(0.4))
                    ]),
              ),
              TextFormField(
                maxLines: null,
                minLines: 1,
                controller: _contentNoteController,
                onChanged: (value) {
                  ContentNote = value;
                },
                onEditingComplete: () {
                  ContentNote = _contentNoteController.text;
                },
                cursorColor: AppStyle.MainColor,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 14, color: AppStyle.Headline),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Start writing",
                    hintStyle: TextStyle(color: AppStyle.Headline)),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
          height: 70.0,
          width: 70.0,
          child: FloatingActionButton(
            backgroundColor: AppStyle.Button,
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(3.5)),
            onPressed: () {
              TitleNote.isNotEmpty
                  ? getDocIndex()
                  : Navigator.pop(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                      return HomeScreen();
                    }));
            },
            child: Icon(
              Icons.save_as,
              size: 42,
              color: AppStyle.ButtonText,
            ),
          )),
    );
  }
}
