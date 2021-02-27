import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'home.dart';
import 'calculate.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'dateCalc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Love Calculator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(index: 0),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.index}) : super(key: key);
  final int index;
  @override
  _MyHomePageState createState() => _MyHomePageState(currentIndex: index);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({this.currentIndex});
  int currentIndex;
  var currentPage;
  var datePage;

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'], childDirected: false);

  BannerAd myBanner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("Banner Reklam: $event");
    },
  );

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: InterstitialAd.testAdUnitId,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("Geçiş Reklam: $event");
    },
  );

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: '');
    super.initState();
    myBanner..load();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    myBanner..show(anchorType: AnchorType.top);
    return Scaffold(
      backgroundColor: Colors.white,
      body: <Widget>[
        HomePage(),
        datePage = DayCalculate(),
        currentPage = CalculatePage()
      ][currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          myInterstitial
            ..load()
            ..show();
          if (currentIndex == 1) {
            if (datePage == null) {
              datePage = DayCalculate();
            }
            var result = datePage.page.getDifference();
            var text =
                "Day: ${result.inDays}\n\nHours: ${result.inHours}\n\nSeconds: ${result.inSeconds}";
            datePage.page.showMaterialDialog(text);
          } else if (currentIndex == 2) {
            var result = await currentPage.getData();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  result: result,
                ),
              ),
            );
          }
        },
        child: Icon(Icons.calculate),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
            title: Text("Home"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            title: Text("Duration Calculate"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            title: Text("Name Calculate"),
          ),
        ],
      ),
    );
  }
}
