import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monkeytype_clone/presentation/views/typing_screen.dart';
import 'package:monkeytype_clone/presentation/viewmodels/typing_viewmodel.dart';
import 'package:provider/provider.dart';

import 'firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TypingViewModel(),
      child: MaterialApp(
        title: 'MonkeyType Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: const TypingScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
