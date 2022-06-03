import 'package:cryptocurrency_tracker/constants/theme.dart';
import 'package:cryptocurrency_tracker/provider/theme_provider.dart';
import 'package:cryptocurrency_tracker/services/local_storage.dart';
import 'package:flutter/material.dart';

import 'pages/homepage.dart';
import 'package:provider/provider.dart';

import 'provider/market_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? 'light';
  runApp(App(
    theme: currentTheme,
  ));
}

class App extends StatelessWidget {
  final String theme;
  const App({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MarketProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider(theme)),
      ],
      child: Consumer<ThemeProvider>(
        builder: ((context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CryptoCurrency Tracker',
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const HomePage(),
          );
        }),
      ),
    );
  }
}
