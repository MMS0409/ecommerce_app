import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../ui/auth/auth_screen.dart';
import '../ui/tab/tab_box.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthProvider>().listenAuthState(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            print('error ga krdi');
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data == null) {
            print('authScreen ga krdi');
            return const AuthScreen();
          } else {
            print('tabbox ga krdi');
            return const TabBox();
          }
        },
      ),
    );
  }
}
