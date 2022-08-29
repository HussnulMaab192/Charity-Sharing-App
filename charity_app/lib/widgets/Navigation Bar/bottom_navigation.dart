import 'package:flutter/material.dart';

BottomNavigationBar customNavigationBar(
    {required int selectedIndex, required void Function(int)? onItemTapped}) {
  return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.green),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            backgroundColor: Colors.yellow),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
          backgroundColor: Colors.blue,
        ),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      iconSize: 40,
      onTap: onItemTapped,
      elevation: 5);
}
