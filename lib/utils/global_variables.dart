import 'package:cet_hostel/screens/home_screen.dart';
import 'package:cet_hostel/screens/search_screen.dart';
import 'package:cet_hostel/screens/profile/profile_screen.dart';
import 'package:cet_hostel/screens/search_screen.dart';
import 'package:cet_hostel/screens/notification.dart';
import 'package:flutter/material.dart';

const WebScreenSize = 600;
var homeScreenItems = [
  HostelHomePage(),
  SearchBar(),
  notificationHomeforstudents(),
  ProfileScreen(),
];
