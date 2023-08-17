// import 'dart:io';

 // Answer1 Read a local file directory and recursively print all file names along with their
 //parent folder names. Write the code in dart language.

// void printFiles(Directory directory, [String parentFolderName = 'demo_app']) {
//   for (var entity in directory.listSync()) {
//     if (entity is File) {
//       print('$parentFolderName - ${entity.path.split(Platform.pathSeparator).last}');
//     } else if (entity is Directory) {
//       final folderName = entity.path.split(Platform.pathSeparator).last;
//       final newParent = parentFolderName.isEmpty ? folderName : '$parentFolderName - $folderName';
//       printFiles(entity, newParent);
//     }
//   }
// }

// void main() {
//   final startDirectory = Directory('C:/Users/naimi/Desktop');
  
//   if (startDirectory.existsSync()) {
//     printFiles(startDirectory);
//   } else {
//     print('Directory not found.');
//   }
// }

//  <<===========================================Answer 2====================================================>>

import 'package:flutter/material.dart';

import 'screens/user_form_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User List App',
      theme: ThemeData(
      useMaterial3: true
      ),
      home: const UserFormScreen(),
    );
  }
}


