import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simplenotepad/NoteReader.dart';
import 'package:simplenotepad/StorageService.dart';
import 'package:simplenotepad/Style/App_style.dart';
import 'package:simplenotepad/UserProfile.dart';
import 'package:simplenotepad/noteCard.dart';

final userRef = FirebaseFirestore.instance.collection('Profile');
var fullName;
var mobile_phone;
var hobbies;
var url_image;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Storage _storage = Storage();
  readData() async {
    //this if function for avoid error from back to previous page
    if (this.mounted) {
      setState(() {
        _storage.readDataBase();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    readData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyle.backGroundCollor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: SafeArea(
          top: true,
          child: AppBar(
            elevation: 0,
            backgroundColor: AppStyle.backGroundCollor,
            flexibleSpace: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7.0),
                      child: CachedNetworkImage(
                        imageUrl: _storage.readURL() != confirm_image &&
                                confirm_image != null
                            ? confirm_image.toString()
                            : _storage.readURL(),
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            Image.asset('assets/images/blank_picture.png'),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      width: size.width - 150,
                      margin: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        _storage.readUserName() != confirm_name &&
                                confirm_name != null
                            ? confirm_name
                            : _storage.readUserName(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppStyle.Headline,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 11.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/UserProfile');
                  },
                  icon: const Icon(
                    Icons.crop_square,
                    size: 28,
                  ),
                  highlightColor: AppStyle.backGroundCollor,
                  splashColor: AppStyle.backGroundCollor,
                ),
              )
            ],
            actionsIconTheme: IconThemeData(color: AppStyle.Button, size: 28),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Notes').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      children: snapshot.data!.docs
                          .map((note) => noteCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NoteReader(note),
                                    ));
                              }, note))
                          .toList());
                }
                return const Text("Tidak ada Notes yang tersedia");
              },
            ))
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(3.5)),
          onPressed: () {
            Navigator.pushNamed(context, '/NoteEditor');
          },
          backgroundColor: AppStyle.Button,
          splashColor: AppStyle.Headline,
          child: Icon(
            Icons.add,
            color: AppStyle.ButtonText,
            size: 62,
            weight: 24,
            fill: 1,
          ),
        ),
      ),
    );
  }
}
