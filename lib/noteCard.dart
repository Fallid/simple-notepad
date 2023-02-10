import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simplenotepad/Style/App_style.dart';

var UIDNoteCard;

Widget noteCard(Function()? ontap, QueryDocumentSnapshot doc) {
  UIDNoteCard = doc["UID"];
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
          color: AppStyle.MainColor, borderRadius: BorderRadius.circular(7)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc["title_note"],
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppStyle.ButtonText,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                doc["time_note"],
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppStyle.ButtonText),
              ),
              const SizedBox(
                height: 4,
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
              const SizedBox(
                height: 6.5,
              ),
              SizedBox(
                height: 100,
                child: Text(
                  doc["content_note"],
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppStyle.ButtonText,
                      overflow: TextOverflow.fade),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
