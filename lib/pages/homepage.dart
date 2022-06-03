import 'package:cryptocurrency_tracker/pages/crypto_market.dart';
import 'package:cryptocurrency_tracker/pages/favorites.dart';
import 'package:cryptocurrency_tracker/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
              top: 20.0, left: 20.0, right: 20.0, bottom: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: GoogleFonts.baloo2(
                    textStyle: const TextStyle(
                  fontSize: 18.0,
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Crypto Today',
                    style: GoogleFonts.greatVibes(
                        textStyle: const TextStyle(
                      fontSize: 40.0,
                    )),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    icon: (themeProvider.themeMode == ThemeMode.light)?const Icon(Icons.dark_mode_sharp):const Icon(Icons.light_mode),
                  ),
                ],
              ),
              TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'Markets',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favorite',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: const [
                      CryptoMarket(),
                      FavoritePage(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
