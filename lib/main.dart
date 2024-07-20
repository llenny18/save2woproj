import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:save2woproj/components/card.dart';
import 'package:save2woproj/components/history.dart';
import 'data/login.dart';

void main() {
  runApp(const DevMode());
}

// For development purposes
//
// So you don't have to go through login screen every start or reload
// change runApp([widget]) on deployment or if login is necessary
// ```dart
// void main(){
//  runApp(const Home());
// }
// ```
class DevMode extends StatelessWidget {
  const DevMode({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Panel());
  }
}

// Current index for pages
//
// Value of [_index] is changed on functions onTap() located at _navBarItems and _drawer
int _index = 0;

// This is will be the starting point of the App
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
                          Expanded(child: _Logo()),
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

// Components Start
class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

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
                      image: NetworkImage('assets/save2wo.png'),
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

// Widgets that is accessed by [Panel()] through [_index]
//
// List of Menu Items
final _tabs = [DashboardCardCarousel(), HistoryTab(), SampleChart()];
final List<String> _menuItems = ['Home', 'History'];

Widget _drawer(BuildContext context) => Drawer(
      backgroundColor: const Color(0xff108494),
      child: ListView(
        children: _menuItems.map((item) {
          IconData icon;
          if (item == 'Home') {
            icon = Icons.home;
          } else if (item == 'History') {
            icon = Icons.history;
          } else {
            icon = Icons.help; // Default icon if no match found
          }

          return ListTile(
            leading: Icon(icon, color: Colors.white),
            onTap: () {
              // _menuItems.indexWhere((_item) => _item == item) returns int
              // Whereas [_item] is our value in [_menuItems]
              // while [item] is selected [onTap()]
              // the [index] is returned by matching the onTapped item to our [_menuItems._item]
              _index = _menuItems.indexWhere((_item) => _item == item);

              // The existing page will be replaced by [Panel()]
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Panel()),
              );
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
                // _menuItems.indexWhere((_item) => _item == item)

                // _menuItems.indexWhere((_item) => _item == item) returns int
                //
                // Whereas [_item] is our value in [_menuItems]
                // while [item] is selected [onTap()]
                // the [index] is returned by matching the onTapped item to our [_menuItems._item]
                _index = _menuItems.indexWhere((_item) => _item == item);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Panel()),
                );
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

// Logout Dialog
class Logout extends StatelessWidget {
  const Logout({super.key});

// Pops a dialog prompting for logging out
//
// Creates two selection in [actions]
//
// When [TextButton.No] is pressed it will return to original position
// When [TextButton.Yes] is pressed it will push the existing page to the Login Page
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure to logout?'),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: () {
            // Just close the dialog
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            // Close the dialog and navigate to Home
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

enum Menu { itemOne, itemTwo, itemThree }

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
          _index = 3; // Navigate to ProfileTab
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Panel()),
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

// Components End

// Tabs/Forms Start
class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                // Returns [True] if input match the pattern
                // Else [False]
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  backgroundColor: const Color(0xff108494),
                ),
                // Here is the Sign In button
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Panel()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}

// Holds the components together
// Dynamically built for switching tabs
class Panel extends StatefulWidget {
  const Panel({super.key});
  @override
  PanelState createState() => PanelState();
}

class PanelState extends State<Panel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    final List<Widget> _allTabs = [
      ..._tabs,
      const ProfileTab(),
    ];

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
                                image: NetworkImage('assets/save2wo.png'),
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
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: _ProfileIcon()),
              )
            ],
          ),
          drawer: isLargeScreen ? null : _drawer(context),
          backgroundColor: const Color(0xffeaf4f7),
          body: Center(
            child: _allTabs[_index],
          )),
    );
  }
}

class CarouselDemo extends StatelessWidget {
  final List<String> imgList = [
    'https://www.aqueon.com/-/media/project/oneweb/aqueon/us/blog/ways-to-know-your-fish-are-happy/fish-are-happy-and-healthy-1.png',
    'https://c02.purpledshub.com/uploads/sites/62/2022/09/GettyImages-200386624-001-d80a3ec.jpg?w=1029&webp=1',
    'https://i.natgeofe.com/n/633757ae-c0c5-43e6-a1fe-11342b9b4b72/fish-hero_2x3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeaf4f7),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 400,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: imgList
              .map((item) => Container(
                    child: Center(
                        child: Image.network(item,
                            fit: BoxFit.cover, width: 1000)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

// Creates a scrollable page through [SingleChildScrollView]

// Tabs/Form End

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      drawer: (screenWidth > 800) ? null : _drawer(context),
      body: const Center(
        child: Text('Go back!s'),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [DashboardCardCarousel()],
          )
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade100, Colors.blue.shade900],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        image: DecorationImage(
          image: NetworkImage(
              'https://www.transparenttextures.com/patterns/connected.png'), // Subtle texture
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.05), BlendMode.dstATop),
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
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 16),
                Text(
                  'Allen Batong Bakal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                const Text(
                  'AllenJutay@example.com',
                  style: TextStyle(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
