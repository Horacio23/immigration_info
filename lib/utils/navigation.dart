import 'package:flutter/material.dart';
import 'package:immigration_info/domain/selected_info.dart';
import 'package:immigration_info/views/contactus.dart';


  void navigateToContactUs(String status, String transaction, BuildContext context) async {
    SelectedInfo info = SelectedInfo(transaction, status);
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactUs(info)));
    debugPrint("Switching to navigation");
  }