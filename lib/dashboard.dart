import 'package:careercounselling/views/home.dart';
import 'package:careercounselling/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<GDPData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: appBar(context),
          backgroundColor: Colors.black12,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black87),
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
        ),
        body: Column(
          children: [
            SfCircularChart(
              title: ChartTitle(text: 'Overall Assessment Data'),
              // backgroundColor: Colors.amberAccent,
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              series: <CircularSeries>[
                PieSeries<GDPData, String>(
                  dataSource: _chartData,
                  xValueMapper: (GDPData data, _) => data.continent,
                  yValueMapper: (GDPData data, _) => data.gdp,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                )
              ],
            ),
            TextField(
            ),
          ],
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Science', 20),
      GDPData('Arts', 15),
      GDPData('Mathematics', 13),
      GDPData('Data Structures', 20),
      GDPData('Python', 7),
      GDPData('HTML', 8),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
