import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:simplenotepad/HomeScreen.dart';
import 'package:simplenotepad/Style/App_style.dart';

String TitleEditing = '';
bool readOnly = true;

// ignore: must_be_immutable
class NoteReader extends StatefulWidget {
  NoteReader(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  String _date = DateFormat.yMEd().add_jm().format(DateTime.now());
  deleteData(id) async {
    await FirebaseFirestore.instance.collection('Notes').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyle.backGroundCollor,
      appBar: AppBar(
        backgroundColor: AppStyle.backGroundCollor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 28,
              color: AppStyle.Button,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false);
            },
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Notes')
                    .doc(widget.doc['UID'])
                    .update({'time_note': _date});
                setState(() {
                  readOnly = false;
                });
              },
              icon: Icon(
                Icons.edit,
                size: 28,
                color: AppStyle.Button,
              )),
          IconButton(
              onPressed: () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  onConfirmBtnTap: () {
                    deleteData(widget.doc['UID']);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false);
                  },
                );
              },
              icon: Icon(
                Icons.delete_outline,
                size: 28,
                color: AppStyle.Button,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                readOnly: readOnly,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                cursorColor: AppStyle.MainColor,
                decoration: const InputDecoration(border: InputBorder.none),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppStyle.Headline,
                ),
                textCapitalization: TextCapitalization.words,
                controller: TextEditingController(
                  text: widget.doc['title_note'],
                ),
                onChanged: (value) {
                  TitleEditing = value;
                  print(TitleEditing);
                  FirebaseFirestore.instance
                      .collection('Notes')
                      .doc(widget.doc['UID'])
                      .update({'title_note': TitleEditing});
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                widget.doc['time_note'],
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppStyle.Headline),
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        bottom: BorderSide(width: 3, color: AppStyle.Stroke)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(0.0, 2.0))
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                readOnly: readOnly,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                cursorColor: AppStyle.MainColor,
                decoration: const InputDecoration(border: InputBorder.none),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppStyle.Headline),
                textAlign: TextAlign.justify,
                textCapitalization: TextCapitalization.words,
                controller: TextEditingController(
                  text: widget.doc['content_note'],
                ),
                onChanged: (value) {
                  TitleEditing = value;
                  print(TitleEditing);
                  FirebaseFirestore.instance
                      .collection('Notes')
                      .doc(widget.doc['UID'])
                      .update({'content_note': TitleEditing});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
