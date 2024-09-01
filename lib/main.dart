import 'package:auth_app/common/colors.dart';
import 'package:auth_app/common/repository/user_control_repository.dart';
import 'package:auth_app/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        String initialRoute =
            ref.read(userControlerRepositoryProvider).isUserSignedIn();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Firebase Auth',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            scaffoldBackgroundColor: scaffoldBGColor,
            useMaterial3: true,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                unselectedItemColor: greyColor,
                type: BottomNavigationBarType.fixed,
                backgroundColor: bottomNavigationBGColor),
          ),
          onGenerateRoute: AppRouter.generate,
          initialRoute: initialRoute,
        );
      },
    );
  }
}
