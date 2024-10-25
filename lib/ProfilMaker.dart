import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simplenotepad/ProfilePicture.dart';
import 'package:simplenotepad/Style/App_style.dart';

//FireBase ref of user profile
final userRef = FirebaseFirestore.instance.collection('Profile');

// var imageURL = Fire
class ProfilMaker extends StatefulWidget {
  const ProfilMaker({Key? key}) : super(key: key);

  @override
  State<ProfilMaker> createState() => _ProfilMakerState();
}

class _ProfilMakerState extends State<ProfilMaker> {
  //Variable for text form field
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPhoneNum = TextEditingController();
  TextEditingController _controllerHabbies = TextEditingController();
  String inputFullName = "Full Name";
  String inputMobilePhone = "Mobile Phone";
  String inputHobbies = "Hobbies";

  readData() async {
    final docRef = await userRef.doc('user_profile').get();
    Map<String, dynamic>? data = docRef.data();

    //this if function for avoid error from back to previous page
    if (this.mounted) {
      setState(() {
        fullName = data?['full_name'];
        mobile_phone = data?['mobile_phone'];
        hobbies = data?['hobbies'];
        url_image = data?['url_image'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    readData();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppStyle.backGroundCollor,
      body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                //Title of screen
                Container(
                  width: size.width,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hey, Hello 👋",
                    style: TextStyle(color: AppStyle.Headline, fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                //Content of Title screen
                Container(
                  width: size.width,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter the fields below to get started",
                    style:
                        TextStyle(fontSize: 12, color: AppStyle.SecondCollor),
                  ),
                ),
                const SizedBox(
                  height: 33.0,
                ),

                //Title of FullName Field
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  child: Text(
                    "Full Name",
                    style: TextStyle(color: AppStyle.Headline, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),

                //TextFormField of FullName
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 31,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: AppStyle.MainColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: _controllerName,
                      textCapitalization: TextCapitalization.words,
                      style:
                          TextStyle(fontSize: 14, color: AppStyle.ButtonText),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: AppStyle.Stroke,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
                const SizedBox(
                  height: 33.0,
                ),

                //Title of Mobile Number field
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  child: Text(
                    "Mobile number",
                    style: TextStyle(color: AppStyle.Headline, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 31,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: AppStyle.MainColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: _controllerPhoneNum,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.number,
                      style:
                          TextStyle(fontSize: 14, color: AppStyle.ButtonText),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: AppStyle.Stroke,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
                const SizedBox(
                  height: 33.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  child: Text(
                    "Hobbies",
                    style: TextStyle(color: AppStyle.Headline, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 31,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: AppStyle.MainColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: _controllerHabbies,
                      textCapitalization: TextCapitalization.words,
                      style:
                          TextStyle(fontSize: 14, color: AppStyle.ButtonText),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: AppStyle.Stroke,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
                const SizedBox(
                  height: 56.0,
                ),
                SizedBox(
                    width: size.width,
                    height: 31,
                    child: ElevatedButton(
                        onPressed: (_controllerName.text.isNotEmpty &&
                                _controllerPhoneNum.text.isNotEmpty &&
                                _controllerHabbies.text.isNotEmpty)
                            ? (() async {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return const ProfilePicture();
                                }), (route) => false);

                                //Firebase update document user profile
                                userRef.doc('user_profile').update({
                                  'full_name': inputFullName =
                                      _controllerName.text,
                                  'hobbies': inputHobbies =
                                      _controllerHabbies.text,
                                  'mobile_phone': inputMobilePhone =
                                      _controllerPhoneNum.text
                                }).then(
                                  (value) => print("user update"),
                                );
                              })
                            : null,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppStyle.Button),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0)))),
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                              color: AppStyle.ButtonText,
                              fontWeight: FontWeight.bold),
                        ))),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: size.width,
                  child: SvgPicture.asset(
                    "assets/svg/mobile_login.svg",
                    height: 300,
                    width: 300,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
