import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplenotepad/SplashScreen.dart';
import 'package:simplenotepad/StorageService.dart';
import 'package:simplenotepad/Style/App_style.dart';
import 'package:simplenotepad/UserProfile.dart';

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
    Size _size = MediaQuery.of(context).size;
    readData();
    return Scaffold(
      backgroundColor: AppStyle.backGroundCollor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: SafeArea(
          top: true,
          child: AppBar(
            elevation: 0,
            backgroundColor: AppStyle.backGroundCollor,
            flexibleSpace: SizedBox(
              width: double.infinity,
              height: double.infinity,
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
                            ? confirm_image
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
                      width: _size.width - 150,
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
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const UserProfile();
                  }));
                },
                icon: const Icon(
                  Icons.crop_square,
                  size: 28,
                ),
                highlightColor: AppStyle.backGroundCollor,
                splashColor: AppStyle.backGroundCollor,
              )
            ],
            actionsIconTheme: IconThemeData(color: AppStyle.Button, size: 28),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Container()],
        ),
      ),
    );
  }
}
