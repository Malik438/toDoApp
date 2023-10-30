import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'common/homePage.dart';
import 'firebase_options.dart';


void main() async {



  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,

    home: Todo(),
  ));
}

