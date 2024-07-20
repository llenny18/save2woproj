import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:save2woproj/components/charts.dart';



// Reference from CarouselDemo in main.dart
class DashboardCardCarousel extends StatefulWidget {
  @override
  _DashboardCardCarouselState createState() => _DashboardCardCarouselState();
}


class _DashboardCardCarouselState extends State<DashboardCardCarousel> {
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
    const ChartCard()
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
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
            );
  }
}

/// DashboardCard that holds:
/// 
/// 
/// [title] of the card
/// 
/// [content] of the card
/// 
/// [image] that will be a link for the image
///
/// Some components are modifiable based on the requirements:
/// 
/// 
/// [Padding] the padding of the card
/// 
/// [width] the maximum width of the card
/// 
/// [height] the maximum height of the card
/// 
/// [outerRadius] is the radius of the [CircleAvatar] on outside of the image
/// 
/// [innerRadius] is the radius of the [CircleAvatar] that holds the image
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
                          backgroundColor:
                              const Color.fromARGB(255, 43, 211, 236),
                          radius: outerRadius,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                image), // <- the image link is here
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Metropolis'),
                              ),
                              _gap(),
                              Text(
                                // Content goes here
                                content,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: 'Metropolis'),
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

/// Card for listing counts
/// 
/// CounterCards holds:
/// 
/// [dropdown] the dropdown for filtering values
/// 
/// [count] amount of count
/// 
/// [countName] the name of the count
/// 
/// [title] the title of the card
class CounterCard extends StatefulWidget {

  final int count;
  final String title;
  final String countName;

  const CounterCard(
      {super.key,
      required this.count,
      required this.countName,
      required this.title});

  @override
  StateCounterCard createState() => StateCounterCard();
}

class StateCounterCard extends State<CounterCard> {
  @override
  Widget build(BuildContext context) {
    final count = widget.count;
    final countName = widget.countName;
    final title = widget.title;


    return Card(
        elevation: 50,
        shadowColor: Colors.black,
        color: const Color(0xff088294),
        child: SizedBox(
            width: 250,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  //dropdown,
                  const SizedBox(width: 25),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'Metropolis'),
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
                                  color: Colors.white,
                                  fontFamily: 'Metropolis'),
                            ),
                            // You can adjust the fontSize and other styles as needed
                            Text(
                              countName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: 'Metropolis'),
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
