import 'package:flutter/material.dart';
import 'package:save2woproj/components/card.dart';
import 'package:save2woproj/components/history.dart';
import 'package:save2woproj/model/model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:save2woproj/data/login.dart';
import 'package:save2woproj/model/globals.dart' as global;

void main() {
  runApp(const Home());
}

// For development purposes
class DevMode extends StatelessWidget {
  const DevMode({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Panel(),
    );
  }
}

int _index = 0;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

            return Center(
              child: isSmallScreen
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Logo(),
                        LoginScreen(), // Use the LoginScreen widget here
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(32.0),
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Row(
                        children: [
                          const Expanded(child: _Logo()),
                          Expanded(
                            child: Center(
                                child:
                                    LoginScreen()), // Use the LoginScreen widget here
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/save2wo.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "WELCOME TO SAVE2WO",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

final _tabs = [Dashboard(), HistoryTab()];
final List<String> _menuItems = ['Home', 'History'];
final Map<String, IconData> _iconList = {
  "Home": Icons.home,
  "History": Icons.history
};

Widget _drawer(BuildContext context) => Drawer(
      backgroundColor: const Color(0xff108494),
      child: ListView(
        children: _menuItems.map((item) {
          IconData icon = _iconList[item] ?? Icons.help;
          return ListTile(
            leading: Icon(icon, color: Colors.white),
            onTap: () {
              _index = _menuItems.indexWhere((_item) => _item == item);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Panel()),
                  (route) => false);
            },
            title: Text(item,
                style: const TextStyle(
                    fontSize: 27,
                    fontFamily: 'Montserrat',
                    color: Colors.white)),
          );
        }).toList(),
      ),
    );

Widget _navBarItems(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _menuItems
          .map(
            (item) => InkWell(
              onTap: () {
                _index = _menuItems.indexWhere((_item) => _item == item);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Panel()),
                    (route) => false);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
                child: Text(
                  item,
                  style:
                      const TextStyle(fontSize: 22, fontFamily: 'Montserrat'),
                ),
              ),
            ),
          )
          .toList(),
    );

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure to logout?'),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            global.isLoggedIn = false;
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
      ],
    );
  }
}

enum Menu {
  itemOne,
  itemTwo,
  itemThree,
}

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      icon: const Icon(Icons.person),
      offset: const Offset(0, 40),
      onSelected: (Menu item) {
        if (item == Menu.itemThree) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Logout();
            },
          );
        } else if (item == Menu.itemOne) {
          final userName = global.userName;
          final email = global.email;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileTab(
                  username: userName,
                  email: email,
                ),
              ),
            );
          
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.itemOne,
          child: ListTile(
            leading: Icon(Icons.account_circle, color: Colors.white),
            title: Text('Account',
                style: TextStyle(fontSize: 16, fontFamily: 'Montserrat')),
          ),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemTwo,
          child: ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text('Settings',
                style: TextStyle(fontSize: 16, fontFamily: 'Montserrat')),
          ),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemThree,
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text('Logout',
                style: TextStyle(fontSize: 16, fontFamily: 'Montserrat')),
          ),
        ),
      ],
    );
  }
}

class Panel extends StatefulWidget {



  const Panel({ super.key});
  @override
  State<Panel> createState() => PanelState();
}

class PanelState extends State<Panel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xff088294),
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/save2wo.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems(context))
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: _ProfileIcon(),
              ),
            )
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(context),
        backgroundColor: const Color(0xffeaf4f7),
        body: Center(
          child: _tabs[_index],
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeaf4f7),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME TO SAVE2WO",
                    style: TextStyle(
                      color: Color(0xff034c57),
                      fontFamily: 'Montserrat',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "A system made to monitor and conserve the Taal Lake",
                    style: TextStyle(
                      color: Color(0xff034c57),
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: DashboardCounter(
                      title: "Latest Fish Kill",
                      countName: "Fish Kill",
                      path: Uri.https('save2wo-api.vercel.app',
                          '/history/fish-kill/latest'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Center(
                    child: DashboardCounter(
                      title: "Total Fish Kill",
                      countName: "Fish Kill",
                      path: Uri.https(
                          'save2wo-api.vercel.app', '/history/fish-kill/total'),
                    ),
                  ),
                ],
              ),
            ),
            DashboardCardCarousel()
          ],
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final String username;
  final String email;

  const ProfileTab({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff088294),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 27,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade100, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child : Image(image: NetworkImage(global.profile_pic)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Mahilig mangisda, mahilig din sa sha..',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('Edit Profile'),
                    onPressed: () {
                      // Handle Edit Profile action
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardCounter extends StatefulWidget {
  final String countName;
  final String title;
  final Uri path;
  const DashboardCounter(
      {super.key,
      required this.countName,
      required this.title,
      required this.path});
  @override
  StateDashboardCounter createState() => StateDashboardCounter();
}

class StateDashboardCounter extends State<DashboardCounter> {
  Future<History?>? history;

  @override
  void initState() {
    super.initState();
    history = fetchFishKill();
  }

  Future<History> fetchFishKill() async {
    List<History> historyList = [];
    final response = await http.get(widget.path);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      historyList = jsonData.map((data) => History.fromJson(data)).toList();
      return historyList.isNotEmpty
          ? historyList[0]
          : throw Exception("History list is empty");
    } else {
      throw Exception("Failed to load data");
    }
  }

  Widget buildDataWidget(context, snapshot) => CounterCard(
      count: snapshot.data?.deadFish ?? 0,
      countName: widget.countName,
      title: widget.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<History?>(
      future: history,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Container();
        } else {
          if (snapshot.hasData) {
            return buildDataWidget(context, snapshot);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Container();
          }
        }
      },
    )
    );
  }
}
