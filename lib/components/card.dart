import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//Sample Only
//Holds the data for datasource in Chart
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
//Sample Only for reference
//Dependencies used: Syncfusion [https://pub.dev/packages/syncfusion_flutter_charts]
//Documentations:https://help.syncfusion.com/flutter/introduction/overview
class SampleChart extends StatelessWidget{
  const SampleChart({super.key});
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
        child: Container(
          child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            //We have two components here:
            //Our ChartData which is [SalesData] and our x axis stored in string
            //
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // Bind data source
                dataSource:  <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales
              )
            ]
          )
        )
      )
  );
}
}


//Reference from CarouselDemo in main.dart
class DashboardCardCarousel extends StatelessWidget{
//Sample Only
//This is a List of widget that will be displayed through the carousel
  final List<Widget> cardList= [
    const DashboardCard(title:"Lelouch Vi Britannia", content:"ALL HEIL LELOUCH! ALL HEIL LELOUCH! ALL HAIL GREAT BRITANNIA!", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN62Y5Pm7ZRzEcpxqdyZRDrmeJZEKIi8OZAw&s"),
    const DashboardCard(title:"this is a warning", content:"using -> ", image:"https://www.usatoday.com/gcdn/authoring/authoring-images/2023/08/25/USAT/70680172007-alertsm.png?crop=1995,1499,x52,y0"),
    const DashboardCard(title:"this is a danger", content: "Reusable components", image: "https://image.similarpng.com/very-thumbnail/2021/06/Attention-sign-icon.png",innerRadius: 100, outerRadius: 108,),
     const ChartCard()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffeaf4f7),
      body: 
      Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 400,
            aspectRatio: 16/9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: cardList.map((item) =>
             Center(
              child: item
            ),
          ).toList(),
        ),
      ),
    );
  }
}

//DashboardCard that holds:
//[title] of the card
//[content] of the card
//[image] that will be a link for the image
//
// Some components are modifiable based on the requirements
//[Padding] the padding of the card
//[width] the maximum width of the card
//[height] the maximum height of the card
//[outerRadius] is the radius of the [CircleAvatar] on outside of the image
//[innerRadius] is the radius of the [CircleAvatar] that holds the image
class DashboardCard extends StatefulWidget{
  final String title;
  final String content;
  final String image;

  final double? padding;
  final double? width;
  final double? height;

  final double? outerRadius;
  final double? innerRadius;
  const DashboardCard({
  Key? key, 
  required this.title, 
  required this.content, 
  required this.image,
  this.padding,
  this.width,
  this.height,
  this.innerRadius,
  this.outerRadius
  }) :
    super(key:key);

@override
StateDashboardCard createState()=> StateDashboardCard();
}

class StateDashboardCard extends State<DashboardCard>{
  @override
  Widget build(BuildContext context){
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
          child: 
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 43, 211, 236),
                    radius: outerRadius,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(image), //<- the image link is here
                      radius: innerRadius,
                    ),
                  ),
                  const SizedBox(width: 10), // Changed from height to width for horizontal spacing
                   Expanded( // To ensure the text does not overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text( //Title goes here
                          title,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white38,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        _gap(),
                        Text( //Content goes here
                        content,
                          style: const TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        _gap(),
                      ],
                    ),
                  ),
                ],
              ),
              
              //->> you can add some components here
            ],
          )
        )
      )
    );
  }

  Widget _gap() =>  const SizedBox(height: 15);
}

//To be changed
class ChartCard extends StatefulWidget{
  const ChartCard ({super.key});

@override
StateChartCard createState()=> StateChartCard();
}

class StateChartCard extends State<ChartCard>{
  @override
  Widget build(BuildContext context){
    return const Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Color(0xff088294),
      child:SizedBox(
          width: 800,
          height: 600,
          child: Padding(
            padding: EdgeInsets.all(10.0),
          child: SampleChart(),
          )
    )
    );
  }
}