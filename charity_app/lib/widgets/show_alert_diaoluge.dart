import 'package:charity_app/controllers/add_donation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showAlertDialog({
  required BuildContext context,
  required int index,
}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Delete"),
    onPressed: () async {
      await Get.find<AddMoreList>().list.removeAt(index);
      Get.back();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert!"),
    content: Text("Are you sure you want to delete?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
