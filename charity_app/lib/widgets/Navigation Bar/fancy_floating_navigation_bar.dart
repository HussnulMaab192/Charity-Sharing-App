// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';

Widget fancyBar({required void Function(int)? ontap}) {
  return CustomBottomNavigationBar(
    itemBackgroudnColor: Colors.black,
    backgroundColor: Colors.orange,
    unselectedItemColor: Colors.black,
    selectedItemColor: Colors.orange,
    itemOutlineColor: Colors.orange,
    items: [
      CustomBottomNavigationBarItem(
        icon: Icons.home,
        title: "Volunteer",
        titleTextColor: Colors.black,
      ),
      CustomBottomNavigationBarItem(
        icon: Icons.search,
        title: "Donee",
        titleTextColor: Colors.black,
      ),
      CustomBottomNavigationBarItem(
        icon: Icons.settings,
        title: "Donor",
        titleTextColor: Colors.black,
      ),
    ],
    onTap: ontap,
  );
}
