import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_application/constants/projectColors.dart';
import 'package:wallpaper_application/provider/authProvider.dart';
import 'package:wallpaper_application/screens/aboutthedev.dart';
import 'package:wallpaper_application/screens/authentication/authpage.dart';
import 'package:wallpaper_application/screens/myUploads.dart';
import 'package:wallpaper_application/screens/buttomNavPages/downloadPage.dart';
import 'package:wallpaper_application/screens/buttomNavPages/wallpaperpage/viewAllWallpaperPage.dart';
import 'package:wallpaper_application/screens/buttomNavPages/wallpaperpage/viewWallpaperPage.dart';
import 'package:wallpaper_application/utils%20/routers.dart';

class MainActivityPage extends StatefulWidget {
  const MainActivityPage({super.key});

  @override
  State<MainActivityPage> createState() => _MainActivityPageState();
}

class _MainActivityPageState extends State<MainActivityPage> {
  int pageIndex = 0;
  List<Map> bottomNavItems = [
    {'icon': Icons.home, 'title': 'Home'},
    {'icon': Icons.favorite, 'title': 'Liked'},
  ];

  List<Widget> bottomNavPages = [
    const WallpaperHomePage(),
    const DownloadPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          title: Text(
            'Pixilate',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
          ),
          //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          actions: [
            IconButton(
                onPressed: () {
                  AuthenticationProvider().signOut().then((value) {
                    nextPageOnly(page: AuthPage(), context: context);
                  });
                },
                icon: Icon(
                  Icons.exit_to_app_outlined,
                ))
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/appbarbg2.jpeg"),
                    fit: BoxFit.cover)),
          ),
          elevation: 5,
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_outlined),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.favorite_border_outlined),
                text: "Liked",
              )
            ],
            indicatorColor: Colors.white,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/appbarbg2.jpeg")),
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_mark_outlined,
                ),
                title: const Text('About the Developer'),
                onTap: () {
                  nextPage(context: context, page: AboutTheDev());
                },
              ),
              ListTile(
                leading: Icon(Icons.upcoming_outlined),
                title: Text("My Uploads"),
                onTap: () {
                  nextPage(page: MyUploads(), context: context);
                },
              )
              /*ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),*/
            ],
          ),
        ),
        /*body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: Text("Wallpaper"),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            )
            SliverToBoxAdapter(
              child: bottomNavPages[pageIndex],
            ),
          ],
        ),*/

        /*body: bottomNavPages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: ((value) {
            setState(() {
              pageIndex = value;
            });
          }),
          currentIndex: pageIndex,
          items: List.generate(bottomNavItems.length, (index) {
            final data = bottomNavItems[index];
            return BottomNavigationBarItem(
                icon: Icon(data['icon']), label: data['title']);
          }),
        ),*/
        body: TabBarView(children: [WallpaperHomePage(), DownloadPage()]),
      ),
    );
  }
}

//Image.network(widget.data!.get("wallpaperImage")