import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:save2woproj/components/charts.dart';
import 'package:save2woproj/data/contamination.dart';
import 'package:save2woproj/data/history.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
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
      content: ContaminationList(),
      color: const Color(0xfff5f5f5),
      textColor: const Color(0xfff5f5f5),
    ),
    DashboardCard(
      title: "List of Fish Kill per Cage",
      content: HistoryList(),
      color: const Color(0xfff5f5f5),
      textColor: const Color(0xfff5f5f5),
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

  final Color? color;
  final Color? textColor;
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
      this.outerRadius,
      this.color,
      this.textColor
      })
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
    final padding = widget.padding ?? 0;
    final height = widget.height ?? 400;
    final width = widget.width ?? 800;
    final innerRadius = widget.innerRadius ?? 50;
    final outerRadius = widget.outerRadius ?? 59;
    final enableImage = widget.enableImage ?? false;
    final color = widget.color ??  Color(0xff088294);
    final textColor = widget.textColor ?? Colors.black;
    double textScaleFactor = MediaQuery.textScalerOf(context).scale(1);
    return Card(
        elevation: 50,
        shadowColor: Colors.black,
        color: color,
        child: SizedBox(
            width: width,
            height: height,
            child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        enableImage
                            ? CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 43, 211, 236),
                                radius: outerRadius,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      image), // <- the image link is here
                                  radius: innerRadius,
                                ),
                              )
                            : const SizedBox(width: 0),
                        const SizedBox(
                            width:
                                0), // Changed from height to width for horizontal spacing
                        Expanded(
                          // To ensure the text does not overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: width,
                                decoration:  const BoxDecoration(
                                  color:Color(0xFF088395), //Color(0xFF071952)
                                  borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13)
                                )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text( title,
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Inter'
                                          ),
                                       textScaler: TextScaler.linear(textScaleFactor)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: content,
                    ),
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
  final IconData icon;
  const CounterCard(
      {super.key,
      required this.count,
      required this.countName,
      required this.title,
      required this.icon
      });

  @override
  StateCounterCard createState() => StateCounterCard();
}

class StateCounterCard extends State<CounterCard> {
  String parseCount (int count){
    if(count <=999) return '$count';

    return '${(count/1000).toStringAsFixed(1)}k';
  }
  
  Widget fishIcon(context,colors,isSmallScreen,icon)=> FaIcon(
                      icon,
                      color: colors["IconColor"],
                      size: isSmallScreen ? 80 : 120,

                );
              
  @override
  Widget build(BuildContext context) {
    final count = widget.count;
    final countName = widget.countName;
    final title = widget.title;
    final icon = widget.icon;
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 800;

    double textScaleFactor = MediaQuery.textScalerOf(context).scale(1);
    const Map<String, Color> colors = {
      "Background": Color(0xffF5F5F5),
      "TopColor": Color(0xff088395),
      "CountText": Color(0xff2D3436),
      "IconColor": Color(0xffB2BEC3)
    };
    //28BAF5
    //26A1DA

    return Container(
        decoration: BoxDecoration(
            color: colors["Background"], //background
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: colors["CountText"]!.withOpacity(0.5),
                spreadRadius: -12,
                blurRadius: 10,
                offset: const Offset(0, 25),
              ),
            ]),
        child: SizedBox(
          width: isSmallScreen ? size.width * 0.39194324358 : 373,
          height: isSmallScreen ? size.height * 0.22107829534 : 256,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: 0,
                  child: Container(
                      width: isSmallScreen ? size.width * 0.39194324358 : 373,
                      height: isSmallScreen ? size.height * 0.05252317105 : 50,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13)),
                          color: colors["TopColor"]),
                      child: Center(
                        child: Text(title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: colors["Background"])),
                      ))),
              Positioned(
                bottom: 50,
                left: 15,
                child: fishIcon(context, colors,isSmallScreen,icon),
              ),
              Positioned(
              bottom: count >= 100 ? -16 * MediaQuery.of(context).textScaleFactor : -20 * MediaQuery.of(context).textScaleFactor,
              right: 15,
              child: 
              Text(parseCount(count),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                fontSize: isSmallScreen ? (count >= 100 ?  60 : 70) : count >= 100 ? 95 : 120,
                color: colors["CountText"]
              ),
              textScaler: TextScaler.linear(textScaleFactor)
              )
              )
            ],
          ),
        ));
  }
}



class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}