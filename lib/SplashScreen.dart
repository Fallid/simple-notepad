import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simplenotepad/HomeScreen.dart';
import 'package:simplenotepad/ProfilMaker.dart';
import 'package:simplenotepad/StorageService.dart';
import 'package:simplenotepad/Style/App_style.dart';

final userRef = FirebaseFirestore.instance.collection('Profile');
var validation;
var url_image;
var fullName;
var mobile_phone;
var hobbies;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Storage _storage = Storage();
  double initial = 0.0;
  readData() async {
    //this if function for avoid error from back to previous page
    if (this.mounted) {
      setState(() {
        _storage.readDataBase();
      });
    }
  }

  void update() {
    Timer.periodic(Duration(milliseconds: 800), (timer) {
      setState(() {
        initial += 0.1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    update();
    readData();
    if (validation == false) {
      Timer(
          const Duration(milliseconds: 4500),
          (() => Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const ProfilMaker();
              }), (route) => false)));
    } else {
      Timer(
          const Duration(milliseconds: 4500),
          (() => Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const HomeScreen();
              }), (route) => false)));
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyle.backGroundCollor,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 45.0, right: 45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/svg/creative_writing.svg",
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: 30,
                width: size.width,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                child: LinearProgressIndicator(
                  value: initial,
                  minHeight: 18,
                  backgroundColor: AppStyle.MainColor,
                  valueColor: AlwaysStoppedAnimation(AppStyle.SecondCollor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
