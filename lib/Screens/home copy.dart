import 'package:flutter/material.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/screens/profile/profile.dart';
import 'package:telsavideo/screens/search/search.dart';
import 'package:telsavideo/screens/subscription.dart';
import 'package:telsavideo/screens/trending.dart';
import 'package:telsavideo/common/icons.dart';
//https://stackoverflow.com/questions/50667783/show-bottomsheet-beneath-bottomnavigationbar

bool _initialUriIsHandled = true;

enum PlayerState {
  playing,
  stopped,
}

class Home1 extends StatefulWidget {
  static const String id = "Homepage";
  const Home1({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home1> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  TabController? _tabController;
  PageController? _pageController;
  final GlobalKey<ScaffoldState> _homeScaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "_homeScaffoldKey");
  final bool useRootNavigator = true;
  late Widget popup;
  final List<Tab> toptabs = <Tab>[
    Tab(
      child: Text('Following',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
    ),
    Tab(
      child: Text('For You',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: toptabs.length, vsync: this)
      ..addListener(() {
        if (_tabController!.indexIsChanging) {
          print(_tabController!.index);
          onPageChange(_tabController!.index, p: _pageController);
        }
      });
    //default tab
    _tabController!.animateTo(1);
    _pageController = new PageController(initialPage: 0, keepPage: true);
  }

  void onPageChange(int index, {PageController? p, TabController? t}) async {}

  @override
  void dispose() {
    _tabController!.dispose();
    _pageController!.dispose();
    super.dispose();
  }

  Widget get createHome => Stack(
        //fit: StackFit.expand,
        children: <Widget>[
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              Subscription(),
              PageView(
                allowImplicitScrolling: true,
                controller: _pageController,
                children: <Widget>[
                  Trending(
                    key: _homeScaffoldKey,
                  ),
                ],
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ],
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(
                      Icons.tv,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print('click live');
                    }),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        print('click search');
                      }),
                ],
                title: TabBar(
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0, color: Colors.white),
                      insets: EdgeInsets.symmetric(horizontal: 18.0)),
                  labelStyle: TextStyle(fontSize: 18),
                  isScrollable: true,
                  controller: _tabController,
                  tabs: toptabs,
                  onTap: (index) {
                    print(index);
                  },
                ),
              )
            ],
          ),
        ],
      );

  late List<Widget> _widgetOptions = <Widget>[
    createHome,
    Search(),
    Profile(),
    Profile(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _homeScaffoldKey,
      body: _widgetOptions.elementAt(currentIndex),
      bottomNavigationBar: bottomItems(_homeScaffoldKey, context),
      drawer: Container(),
    );
  }

  double createButtomWidth = 38.0;
  // ignore: non_constant_identifier_names
  double NavigationIconSize = 20.0;
  Widget get customCreateIcon => Container(
        width: 45.0,
        height: 27.0,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              width: createButtomWidth,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              width: createButtomWidth,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 32, 211, 234),
                  borderRadius: BorderRadius.circular(7.0)),
            ),
            Center(
              child: Container(
                height: double.infinity,
                width: createButtomWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Icon(
                  Icons.add,
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );

  BottomNavigationBar bottomItems(
      GlobalKey<ScaffoldState> _homeScaffoldKey, BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      elevation: 0.5,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
        // ignore: unnecessary_null_comparison
        /*  if (popup != null) {
          if (useRootNavigator) {
            showModalBottomSheet(
                useRootNavigator: useRootNavigator,
                context: context,
                isScrollControlled: true,
                builder: (BuildContext bc) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: popup,
                  );
                });
          } else {
            showModalBottomSheet(
                useRootNavigator: useRootNavigator,
                context: context,
                builder: (BuildContext bc) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: popup,
                  );
                });
          }
        } */
      },
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(DouyinIcons.home,
              color: Colors.white,
              size: NavigationIconSize), //SizedBox.shrink(),
          activeIcon: Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        BottomNavigationBarItem(
            icon: Icon(
              DouyinIcons.search,
              color: Colors.white,
              size: NavigationIconSize,
            ),
            activeIcon: Text(
              'Search',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ), //SizedBox.shrink(),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
          icon: customCreateIcon,
          activeIcon: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(DouyinIcons.messages,
              color: Colors.white,
              size:
                  NavigationIconSize), //SizedBox.shrink(), //Icon(DouyinIcons.messages),
          activeIcon: Text(
            'Messages',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(DouyinIcons.profile,
              color: Colors.white,
              size:
                  NavigationIconSize), //SizedBox.shrink(), //Icon(DouyinIcons.profile),
          activeIcon: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
