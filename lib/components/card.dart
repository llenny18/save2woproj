import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:save2woproj/components/charts.dart';
import 'package:save2woproj/data/contamination.dart';
import 'package:save2woproj/data/history.dart';
// Reference from CarouselDemo in main.dart
class DashboardCardCarousel extends StatefulWidget {
  @override
  _DashboardCardCarouselState createState() => _DashboardCardCarouselState();
}


class _DashboardCardCarouselState extends State<DashboardCardCarousel> {
  
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  final List<Widget> cardList = [
     DashboardCard(
        title: "Top List of Contamination",
        content:
            ContaminationList(),
            enableImage: false,
        ),
       
     DashboardCard(
        title: "List of Fish Kill per Cage",
        content: HistoryList(),
       ),
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
                              autoPlay: false,
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
  final Widget content;
  final String? image;

  final bool? enableImage;

  final double? padding;
  final double? width;
  final double? height;

  final double? outerRadius;
  final double? innerRadius;
  const DashboardCard(
      {Key? key,
      required this.title,
      required this.content,
      this.image,
      this.enableImage,
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
    final image = widget.image ?? "";
    final padding = widget.padding ?? 20.0;
    final height = widget.height ?? 400;
    final width = widget.width ?? 800;
    final innerRadius = widget.innerRadius ?? 50;
    final outerRadius = widget.outerRadius ?? 59;
    final enableImage = widget.enableImage ?? false;

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
                        enableImage?CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 43, 211, 236),
                          radius: outerRadius,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                image), // <- the image link is here
                            radius: innerRadius,
                          ),
                        ) : const SizedBox(
                            width:
                                10)
                        ,
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
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(child:content ,),
                              _gap(),        
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

    //28BAF5
    //26A1DA
    return Container(
        decoration: BoxDecoration(
                    color: const Color(0xff088294), //36C2CE
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff088294).withOpacity(0.5),
                        spreadRadius: -12,
                        blurRadius: 10,
                        offset: const Offset(0, 25),
                      ),
                    ]),
        child: SizedBox(
            width: 250,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
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
                        backgroundColor: Color.fromARGB(255, 17, 108, 122),
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
