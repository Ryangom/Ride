import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ride_Driver/controller/rideController.dart';
import 'package:ride_Driver/controller/utilsController.dart';
import 'package:ride_Driver/utility/ui_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../component/appBar.dart';
import '../component/button.dart';
import '../component/drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = true;

  RideController rideController = RideController();
  UtilsController utilsController = UtilsController();

  Map<String, dynamic> driverStats = {};

  @override
  void initState() {
    super.initState();
    _getDriverStats();
  }

  goOnline() {}

  _getDriverStats() async {
    var id = await utilsController.getLocalStorage('id');
    var data = await RideController().getDriverStats(id);
    if (data['status'] == 'success') {
      setState(() {
        driverStats = data['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(title: 'Dashboard'),
      drawer: CustomDrawer(),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: const Text('Tap back again to leave'),
          backgroundColor: Colors.red.withOpacity(0.8),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const Chart(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          reportBox('Earnings', 'assets/icons/earnings.svg',
                              driverStats['totalEarning'].toString(), context),
                          reportBox('Due', 'assets/icons/due.svg',
                              driverStats['adminDue'].toString(), context),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stats(
                        acceptanceRate: '${driverStats['acceptanceRate']}%',
                        lifeTimeRides: driverStats['totalRides'].toString(),
                        rating: '${driverStats['rating']}',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MyButton(text: 'Go Online', onPressed: goOnline),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
          ),
        )),
      ),
    );
  }
}

Widget reportBox(String title, String svg, String value, BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 2,
          offset: Offset(0, 2),
        ),
      ],
    ),
    height: 100,
    width: MediaQuery.of(context).size.width / 2.5,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                SvgPicture.asset(
                  svg,
                  height: 25,
                  width: 25,
                )
              ],
            ),
            Center(
                child: Text(
              value,
              style: kHeadLine1(),
            )),
          ],
        ),
      ),
    ),
  );
}

class Stats extends StatelessWidget {
  final String acceptanceRate;
  final String lifeTimeRides;
  final String rating;

  Stats({
    super.key,
    required this.acceptanceRate,
    required this.lifeTimeRides,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Stats',
                  style: kHeadLine1(),
                ),
                Column(
                  children: [
                    Text(
                      acceptanceRate,
                      style: kHeadLine1(fontWeight: FontWeight.w400, fontSize: 30.0),
                    ),
                    const Text(
                      'Acceptance Rate',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$rating⭐',
                          style: kHeadLine1(fontWeight: FontWeight.w400, fontSize: 30.0),
                        ),
                        const Text(
                          'Rating',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          lifeTimeRides,
                          style: kHeadLine1(fontWeight: FontWeight.w400, fontSize: 30.0),
                        ),
                        const Text(
                          'Lifetime Rides',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      // Earning line chart starts here
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),

        // Chart title
        title: ChartTitle(
            text: 'Earning',
            alignment: ChartAlignment.near,
            textStyle: kHeadLine1(fontWeight: FontWeight.bold, fontSize: 20.0)),
        // Enable legend
        legend: const Legend(isVisible: false),
        backgroundColor: Colors.white,

        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),

        series: <ChartSeries<EarningData, String>>[
          LineSeries<EarningData, String>(
              dataSource: <EarningData>[
                EarningData('Jan', 18885),
                EarningData('Feb', 28),
                EarningData('Mar', 34),
                EarningData('Apr', 32),
                EarningData('May', 40),
                EarningData('Jun', 4005),
                EarningData('Jul', 5008),
                EarningData('Aug', 50),
                EarningData('Sep', 55),
                EarningData('Oct', 60),
                EarningData('Nov', 65),
                EarningData('Dec', 10000),
              ],
              animationDelay: 2,
              color: Colors.blue,
              width: 3,
              xValueMapper: (EarningData earning, _) => earning.month,
              yValueMapper: (EarningData earning, _) => earning.earning,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: false))
        ],
      ),
    );
  }
}

class EarningData {
  EarningData(this.month, this.earning);
  final String month;
  final double earning;
}
