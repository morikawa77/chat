import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/login.dart';
import 'package:chat/message_list.dart';
import 'package:chat/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print('Erro ao inicializar o Firebase: ${snapshot.error}');
            return const Center(
              child: Text("Erro ao inicializar o Firebase"),
            );
          }
    
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return MaterialApp(
            theme: ChatTheme.chatTheme.copyWith(
              textTheme: ChatTheme.chatTheme.textTheme.apply(
                fontFamily: 'Ubuntu',
              ),
            ),
            
            debugShowCheckedModeBanner: false,
            initialRoute: '/message_list',
            routes: {
              '/message_list': (context) => MessageListPage()
            },
          );
        },
      ),
    );
  }
}

Future<FirebaseApp?> _initializeFirebase() async {
  try {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    AnonymousAuth auth = AnonymousAuth();
    // ignore: unused_local_variable
    UserCredential? userCredential = await auth.signInAnonymously();
    return app;
  } catch (e) {
    // ignore: avoid_print
    print('Error initializing Firebase: $e');
    return null;
  } 
}
