import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:simplenotepad/HomeScreen.dart';
import 'package:simplenotepad/StorageService.dart';
import 'package:simplenotepad/Style/App_style.dart';
import 'package:quickalert/quickalert.dart';

var fileName;
var URL;
var confirm_image;
var confirm_name;
var confirm_mobileNum;
var confirm_hobbies;
final Storage _storage = Storage();

//for textfield value input
TextEditingController _controllerName = TextEditingController();
TextEditingController _controllerMobileNum = TextEditingController();
TextEditingController _controllerHobbies = TextEditingController();

String inputfullName = '';
String inputMobilePhone = '';
String inputhobbies = '';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future<void> adjustImage() async {
    setState(() {});
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const HomeScreen();
                }));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppStyle.Button,
                size: 28,
              )),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 13.0),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child:
                            // Text("Picture")
                            CachedNetworkImage(
                          imageUrl: _storage.readURL() != confirm_image &&
                                  confirm_image != null
                              ? confirm_image
                              : _storage.readURL(),
                          width: 115,
                          height: 115,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Image.asset('assets/images/blank_picture.png'),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: IconButton(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.image);

                            if (result != null) {
                              final filePath = result.files.single.path;
                              fileName = result.files.first.name;
                              File file = File(filePath!);
                              // Upload file

                              var uploadTask = await FirebaseStorage.instance
                                  .ref('files/$fileName')
                                  .putFile(file);
                              var downloadURL =
                                  await uploadTask.ref.getDownloadURL();
                              URL = downloadURL.toString();
                              print(URL);
                              setState(() {
                                _storage.writeURL(URL);
                                _storage.readURL();
                              });
                              userRef
                                  .doc('user_profile')
                                  .update({'url_image': '$URL'}).then(
                                      (value) => print("image_Update"));
                            }
                          },
                          icon: Icon(
                            Icons.edit,
                            color: AppStyle.MainColor,
                            size: 28,
                          ),
                          alignment: Alignment.bottomRight,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 42.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  height: 41.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppStyle.MainColor),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 14,
                        ),
                        const Icon(
                          Icons.person_outline,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          color: AppStyle.strokeLine,
                          height: 31,
                          width: 2.0,
                        ),
                        const SizedBox(
                          width: 11.0,
                        ),
                        SizedBox(
                          width: size.width - 105,
                          child: TextFormField(
                            readOnly: false,
                            controller: _controllerName,
                            decoration: InputDecoration(
                                hintText: _storage.readUserName(),
                                hintStyle: TextStyle(
                                    color: AppStyle.ButtonText,
                                    fontWeight: FontWeight.w500),
                                border: InputBorder.none),
                          ),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  height: 41.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppStyle.MainColor),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 14,
                        ),
                        const Icon(
                          Icons.phone_iphone_outlined,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          color: AppStyle.strokeLine,
                          height: 31,
                          width: 2.0,
                        ),
                        const SizedBox(
                          width: 11.0,
                        ),
                        SizedBox(
                          width: size.width - 105,
                          child: TextFormField(
                            controller: _controllerMobileNum,
                            readOnly: false,
                            decoration: InputDecoration(
                                hintText: _storage.readMobileNum(),
                                hintStyle: TextStyle(
                                    color: AppStyle.ButtonText,
                                    fontWeight: FontWeight.w500),
                                border: InputBorder.none),
                          ),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  height: 41.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppStyle.MainColor),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 14,
                        ),
                        Image.asset(
                          'assets/images/hobbies.png',
                          width: 28.0,
                          height: 28.0,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          color: AppStyle.strokeLine,
                          height: 31,
                          width: 2.0,
                        ),
                        const SizedBox(
                          width: 11.0,
                        ),
                        SizedBox(
                          width: size.width - 105,
                          child: TextFormField(
                            controller: _controllerHobbies,
                            readOnly: false,
                            decoration: InputDecoration(
                                hintText: _storage.readHobbies(),
                                hintStyle: TextStyle(
                                    color: AppStyle.ButtonText,
                                    fontWeight: FontWeight.w500),
                                border: InputBorder.none),
                          ),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 174.0,
                ),
                SizedBox(
                  width: size.width,
                  height: 45,
                  child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.sync,
                        color: AppStyle.ButtonText,
                        size: 28,
                      ),
                      onPressed: () async {
                        userRef.doc('user_profile').update({
                          'has_profile': true,
                          'full_name': inputfullName =
                              _controllerName.text.isEmpty
                                  ? _storage.readUserName()
                                  : inputfullName = _controllerName.text,
                          'mobile_phone': inputMobilePhone =
                              _controllerMobileNum.text.isEmpty
                                  ? _storage.readMobileNum()
                                  : inputMobilePhone =
                                      _controllerMobileNum.text,
                          'hobbies': inputhobbies =
                              _controllerHobbies.text.isEmpty
                                  ? _storage.readHobbies()
                                  : _storage.readHobbies(),
                        }).then((value) => print('valid user'));
                        setState(() {
                          confirm_image = URL;
                          confirm_name = inputfullName;
                        });

                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            borderRadius: 7);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppStyle.Button),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(7.0)))),
                      label: Text(
                        "UPDATE",
                        style: TextStyle(
                            color: AppStyle.ButtonText,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
