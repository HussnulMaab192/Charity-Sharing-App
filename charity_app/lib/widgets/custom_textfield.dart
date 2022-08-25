import 'package:flutter/material.dart';

Widget myTextField(
    String hintText, Icon preIcon, TextEditingController mycontroller) {
  return TextFormField(
    controller: mycontroller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: 16, fontFamily: "Rubik Medium", color: Colors.black),
      fillColor: Colors.orange,
      prefixIcon: preIcon,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.orange,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.orange,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    validator: ((value) {
      if (value!.isEmpty) {
        if (hintText == "Enter Email") {
          return "Enter Email Please";
        }
      }
      return null;
    }),
  );
}
