import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/app_user.dart';

class UserProvider extends ChangeNotifier {
  String? mobileNumber;
  String? otp;
  dynamic commentsList;

  void setNewUserPhone(String phoneNumber) {
    mobileNumber = phoneNumber;
    notifyListeners();
  }

  void addNewCommentToList(String newComment) {
    (commentsList as List).add(newComment);
    notifyListeners();
  }

  Future<void> createNewUserData({required AppUser user}) async {
    var members_ref = await FirebaseFirestore.instance.collection("members");
    if (user.mobileNumber!.isEmpty) {
      print("Data is not fulfilled");
    } else {
      await members_ref.add(user.getDataMap()).onError((error, stackTrace) {
        print(error.toString());
        print(stackTrace);
        return error as FutureOr<DocumentReference<Map<String, dynamic>>>;
      }).then((value) {
        print("Success added the user");
      });
    }
  }

  Future<void> addNewComment() async {
    AppUser user =
        AppUser(mobileNumber: mobileNumber, userComments: commentsList);
    await FirebaseFirestore.instance
        .collection("members")
        .get()
        .then((value) async {
      value.docs.forEach((doc) async {
        String docId = doc.id;
        await FirebaseFirestore.instance
            .collection("members")
            .doc(docId) //ID OF DOCUMENT
            .snapshots()
            .forEach((element) async {
          var document = element.data();
          String phone = document!["phone"];
          if (mobileNumber == phone) {
            await FirebaseFirestore.instance
                .collection("members")
                .doc(docId)
                .update(user.getDataMap())
                .onError((error, stackTrace) {
              print(error.toString());
              print(stackTrace);
            }).then((value) {});
          }
        });
      });
    });
  }
}
