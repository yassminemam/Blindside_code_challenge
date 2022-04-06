import 'package:flutter/foundation.dart';

class AppUser {
  String? mobileNumber;
  dynamic userComments = [];

  AppUser({
      this.mobileNumber,this.userComments});

  Map<String, dynamic> getDataMap() {
    return {
      "phone": mobileNumber,
    };
  }
}
