import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:vysnc_app/model/feature_card.dart';
import 'package:intl/intl.dart';
import 'package:vysnc_app/model/time_table.dart';
import 'package:vysnc_app/screen/vtop_screen.dart';
import 'package:vysnc_app/screen/wifi_auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String currentDate = DateFormat('dd/MM/yy').format(DateTime.now());
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  Widget buildTimeItem(BuildContext context, int index) {
    TimeTable timeTable1 = timeTable[index];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.6,
      child: Card(
        elevation: 12,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03)),
          child: Column(
            children: [
              Image.asset(
                timeTable1.imagePath,
                height: screenHeight * 0.15,
                width: screenWidth * 0.4,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                timeTable1.title,
                style: TextStyle(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.015),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
                splashColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFeatureItem(BuildContext context, int index) {
    FeatureCard features1 = features[index];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => features1.screen));
      },
      child: SizedBox(
        height: screenHeight * 0.7,
        width: screenWidth * 0.48,
        child: Card(
          elevation: 12,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03)),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03),
                Image.asset(
                  features1.imagePath,
                  height: screenHeight * 0.15,
                  width: screenWidth * 0.4,
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  features1.title,
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.02),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: screenWidth * 0.07,
                  ),
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black87)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<TimeTable> timeTable = [
    TimeTable(imagePath: "assets/book-stack.png", title: "Coming Soon"),
    TimeTable(imagePath: "assets/book-stack.png", title: "Coming Soon"),
    TimeTable(imagePath: "assets/book-stack.png", title: "Coming Soon"),
    TimeTable(imagePath: "assets/book-stack.png", title: "Coming Soon"),
  ];

  List<FeatureCard> features = [
    FeatureCard(
        imagePath: "assets/book-stack.png",
        title: "My Curriculum",
        screen: const WifiAuthScreen()),
    FeatureCard(
        imagePath: "assets/faculty_ranking.png",
        title: "Faculty Ranking",
        screen: const WifiAuthScreen()),
    FeatureCard(
        imagePath: "assets/marketing.png",
        title: "GPA Calculator",
        screen: const WifiAuthScreen()),
    FeatureCard(
        imagePath: "assets/wifi_icon.png",
        title: "WIFI",
        screen: const WifiAuthScreen()),
    FeatureCard(
        imagePath: "assets/professor.png",
        title: "Faculty Info",
        screen: const WifiAuthScreen()),
    FeatureCard(
        imagePath: "assets/university.png",
        title: "VTOP",
        screen: const VtopScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int page = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
            style:
                TextStyle(color: Colors.black, fontSize: screenWidth * 0.05)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
        actions: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: CircleAvatar(
              backgroundImage: const AssetImage(
                "assets/image.png",
              ),
              radius: screenWidth * 0.05,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: CurvedNavigationBar(
          items: const <Widget>[
            Icon(
              Icons.home,
              size: 33,
            ),
            Icon(
              Icons.menu_book,
              size: 33,
            ),
            Icon(
              Icons.wifi,
              size: 33,
            ),
            Icon(
              Icons.person,
              size: 33,
            ),
          ],
          color: const Color.fromARGB(225, 93, 193, 243),
          backgroundColor: const Color.fromARGB(182, 255, 255, 255),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            borderOnForeground: true,
            margin: EdgeInsets.all(screenWidth * 0.04),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Hello! 👋\nAshwin',
                    style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: screenWidth * 0.05,
                  height: screenHeight * 0.1,
                ),
                Text(currentDate,
                    style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Card(
            borderOnForeground: true,
            margin: EdgeInsets.all(screenWidth * 0.04),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: const AssetImage("assets/tt.jpg"),
                  radius: screenWidth * 0.15,
                ),
                SizedBox(
                  height: screenHeight * 0.18,
                ),
                Text("Coming Soon...",
                    style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            height: screenHeight * 0.36,
            child: ScrollSnapList(
              itemBuilder: buildFeatureItem,
              itemCount: features.length,
              itemSize: screenWidth * 0.48,
              onItemFocus: (index) {},
              dynamicItemSize: true,
              initialIndex: 3,
              key: sslKey,
              dynamicItemOpacity: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
