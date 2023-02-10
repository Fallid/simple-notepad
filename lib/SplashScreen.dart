import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simplenotepad/HomeScreen.dart';
import 'package:simplenotepad/ProfilMaker.dart';
import 'package:simplenotepad/StorageService.dart';
import 'package:simplenotepad/Style/App_style.dart';
import 'package:percent_indicator/percent_indicator.dart';

final userRef = FirebaseFirestore.instance.collection('Profile');
//Change validation to true if want goes to HomeScreen immediately
bool validation = false;

var url_image;
var fullName;
var mobile_phone;
var hobbies;
var _timer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Storage _storage = Storage();

  @override
  void initState() {
    super.initState();
    loadingProfileMake();
    loadingHomeScreen();
  }

  void loadingProfileMake() async {
    await Future.delayed(const Duration(milliseconds: 4500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const ProfilMaker();
      }));
    });
  }

  void loadingHomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 4500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return const HomeScreen();
        }),
      );
    });
  }

  readData() async {
    //this if function for avoid error from back to previous page
    if (this.mounted) {
      setState(() {
        _storage.readDataBase();
      });
    }
  }

  @override
  void dispose() {
    // update();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    readData();

    _storage.readDataBase();
    if (validation == false) {
      if (mounted) {
        setState(() {
          loadingProfileMake();
        });
      }
    } else {
      if (mounted) {
        loadingHomeScreen();
        print(globValid);
      }
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
              LinearPercentIndicator(
                lineHeight: 18,
                barRadius: const Radius.circular(7),
                animation: true,
                animationDuration: 3500,
                percent: 100 / 100,
                backgroundColor: AppStyle.MainColor,
                progressColor: AppStyle.SecondCollor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
