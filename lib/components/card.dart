import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//Sa makakabasa ng code na to:
//Tsaka na ang documentation nito :P

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
  final List<Widget> cardList= [
    const DashboardCard(title:"Lelouch Vi Britannia", content:"ALL HEIL LELOUCH! ALL HEIL LELOUCH! ALL HAIL GREAT BRITANNIA!", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN62Y5Pm7ZRzEcpxqdyZRDrmeJZEKIi8OZAw&s"),
    const DashboardCard(title:"this is a warning", content:"using -> ", image:"https://www.usatoday.com/gcdn/authoring/authoring-images/2023/08/25/USAT/70680172007-alertsm.png?crop=1995,1499,x52,y0"),
    const DashboardCard(title:"this is a danger", content: "Reusable components", image: "https://image.similarpng.com/very-thumbnail/2021/06/Attention-sign-icon.png"),
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

class DashboardCard extends StatefulWidget{
  final String title;
  final String content;
  final String image;
  const DashboardCard({Key? key, required this.title, required this.content, required this.image}) :
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

    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Color(0xff088294),
      child: SizedBox(
        width: 800,
        height: 600,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: 
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 43, 211, 236),
                    radius: 108,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(image), //<- the image link is here
                      radius: 100,
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
                        const SizedBox(height: 10),
                        Text( //Content goes here
                        content,
                          style: const TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        )
      )
    );
  }
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