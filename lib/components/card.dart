import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:save2woproj/components/history.dart';
import 'package:save2woproj/components/charts.dart';
import 'package:save2woproj/main.dart';

// Sample Only
// Holds the data for datasource in Chart
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

// Sample Only for reference
// Dependencies used: Syncfusion [https://pub.dev/packages/syncfusion_flutter_charts]
// Documentations:https://help.syncfusion.com/flutter/introduction/overview
class SampleChart extends StatelessWidget {
  const SampleChart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    // We have two components here:
                    // Our ChartData which is [SalesData] and our x axis stored in string
                    series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              // Bind data source
              dataSource: <SalesData>[
                SalesData('Jan', 35),
                SalesData('Feb', 28),
                SalesData('Mar', 34),
                SalesData('Apr', 32),
                SalesData('May', 40)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]))));
  }
}

// Reference from CarouselDemo in main.dart
class DashboardCardCarousel extends StatefulWidget {
  @override
  _DashboardCardCarouselState createState() => _DashboardCardCarouselState();
}

final _tabs = [
  const CounterCard(
    title: 'Everytime',
    count: 99,
    countName: 'You farted',
  ),
  
  SampleChart()
];

int _index = 0;
class _DashboardCardCarouselState extends State<DashboardCardCarousel> {
  final List<Widget> _allTabs = [
      ..._tabs,
      const HistoryTab(),
      const ProfileTab(),
    ];
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  final List<Widget> cardList = [
    const DashboardCard(
        title: "Lelouch Vi Britannia",
        content:
            "ALL HEIL LELOUCH! ALL HEIL LELOUCH! ALL HAIL GREAT BRITANNIA!",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN62Y5Pm7ZRzEcpxqdyZRDrmeJZEKIi8OZAw&s"),
    const DashboardCard(
        title: "this is a warning",
        content: "using -> ",
        image:
            "https://www.usatoday.com/gcdn/authoring/authoring-images/2023/08/25/USAT/70680172007-alertsm.png?crop=1995,1499,x52,y0"),
    const DashboardCard(
      title: "this is a danger",
      content: "Reusable components",
      image:
          "https://image.similarpng.com/very-thumbnail/2021/06/Attention-sign-icon.png",
      innerRadius: 100,
      outerRadius: 108,
    ),
    const ChartCard()
  ];

@override
Widget build(BuildContext context) {
  
  return Scaffold(
    backgroundColor: const Color(0xffeaf4f7),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: _allTabs[_index],
                ),
                const SizedBox(width: 16),
                Center(
                  child: _allTabs[_index],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 500,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CarouselSlider(
                          items: cardList
                              .map(
                                (item) => Center(child: item),
                              )
                              .toList(),
                          carouselController: _controller,
                          options: CarouselOptions(
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        AnimatedSmoothIndicator(
                          activeIndex: _currentIndex,
                          count: cardList.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: Colors.blue,
                            dotColor: Colors.grey,
                          ),
                          onDotClicked: (index) {
                            _controller.animateToPage(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
 

      
      
    
    );
  }
}

// DashboardCard that holds:
// [title] of the card
// [content] of the card
// [image] that will be a link for the image
//
// Some components are modifiable based on the requirements
// [Padding] the padding of the card
// [width] the maximum width of the card
// [height] the maximum height of the card
// [outerRadius] is the radius of the [CircleAvatar] on outside of the image
// [innerRadius] is the radius of the [CircleAvatar] that holds the image
class DashboardCard extends StatefulWidget {
  final String title;
  final String content;
  final String image;

  final double? padding;
  final double? width;
  final double? height;

  final double? outerRadius;
  final double? innerRadius;
  const DashboardCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.image,
      this.padding,
      this.width,
      this.height,
      this.innerRadius,
      this.outerRadius})
      : super(key: key);

  @override
  StateDashboardCard createState() => StateDashboardCard();
}

class StateDashboardCard extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    // Access the variables passed to the state
    final title = widget.title;
    final content = widget.content;
    final image = widget.image;
    final padding = widget.padding ?? 20.0;
    final height = widget.height ?? 600;
    final width = widget.width ?? 800;
    final innerRadius = widget.innerRadius ?? 50;
    final outerRadius = widget.outerRadius ?? 59;

    return Card(
        elevation: 50,
        shadowColor: Colors.black,
        color: Color(0xff088294),
        child: SizedBox(
            width: width,
            height: height,
            child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 43, 211, 236),
                          radius: outerRadius,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(image), // <- the image link is here
                            radius: innerRadius,
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Changed from height to width for horizontal spacing
                        Expanded(
                          // To ensure the text does not overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                // Title goes here
                                title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white38,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              _gap(),
                              Text(
                                // Content goes here
                                content,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              _gap(),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // ->> you can add some components here
                  ],
                ))));
  }

  Widget _gap() => const SizedBox(height: 15);
}

// To be changed
class ChartCard extends StatefulWidget {
  const ChartCard({super.key});

  @override
  StateChartCard createState() => StateChartCard();
}

class StateChartCard extends State<ChartCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
        elevation: 50,
        shadowColor: Colors.black,
        color: Color(0xff088294),
        child: SizedBox(
            width: 800,
            height: 600,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ThresholdChart(),
            )));
  }
}

// Card for listing counts
// CounterCards holds:
// [dropdown] the dropdown for filtering values
// [count] amount of count
// [countName] the name of the count
// [title] the title of the card
class CounterCard extends StatefulWidget {
  final Widget? dropdown;
  final int count;
  final String title;
  final String countName;

  const CounterCard(
      {super.key,
      required this.count,
      required this.countName,
      required this.title,
      this.dropdown});

  @override
  StateCounterCard createState() => StateCounterCard();
}

class StateCounterCard extends State<CounterCard> {
  @override
  Widget build(BuildContext context) {
    final count = widget.count;
    final countName = widget.countName;
    final title = widget.title;
    final dropdown = widget.dropdown ?? const CardDropdown();

    return Card(
        elevation: 50,
        shadowColor: Colors.black,
        color: const Color(0xff088294),
        child: SizedBox(
            width: 300,
            height: 275,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  dropdown,
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 16, 71, 79),
                        radius: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the column inside the CircleAvatar
                          children: [
                            Text(
                              '$count',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 50,
                                  color: Colors.white),
                            ),
                            // You can adjust the fontSize and other styles as needed
                            Text(
                              countName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            )));
  }
}

const List<String> _months = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

class CardDropdown extends StatefulWidget {
  final String? hint;
  final List<String>? selectionList;
  const CardDropdown({this.selectionList, this.hint, super.key});

  @override
  State<CardDropdown> createState() => StateCardDropdown();
}

class StateCardDropdown extends State<CardDropdown> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    final hint = widget.hint ?? 'Select a value';
    final selectList = widget.selectionList ?? _months;
    return DropdownButtonFormField<String>(
      hint: Text(hint),
      value: dropdownValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: selectList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
