import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:training_app/screens/homeScreen.dart';
import 'package:training_app/screens/timerTrainingScreen.dart';
import 'package:training_app/theme/dark_theme.dart';
import 'package:training_app/theme/light_theme.dart';
import 'package:training_app/theme/themeState.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeState(),
      child: Consumer<ThemeState>(builder: (context, themeState, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'JustDoIt',
          theme: themeState.isDarkMode ? darkTheme : lightTheme,
          initialRoute: '/home',
          routes: {
            '/home': (context) => const HomeScreen(),
            '/training': (context) => TimerTrainingScreen(exerciseList: [], prepareTime: null, workTime: null, restTime: null,),
          },
        );
      }),
    );
  }
}



