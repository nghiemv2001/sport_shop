import 'package:demo_sogin_signup_firebase/constants/theme.dart';
import 'package:demo_sogin_signup_firebase/firebase/firebase_helper/firebase_auth_helper.dart';
import 'package:demo_sogin_signup_firebase/firebase_options.dart';
import 'package:demo_sogin_signup_firebase/provider/provider_model.dart';
import 'package:demo_sogin_signup_firebase/screens/auth_ui/sign_in/login.dart';
import 'package:demo_sogin_signup_firebase/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Demo with firebase",
          theme: themData,
          home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Login();
              } else {
                return CustomBottomBar();
              }
            },
          )),
    );
  }
}
