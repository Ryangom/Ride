// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ride_user/component/historyCard.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return HistoryCard(
                    id: index.toString(),
                    pickupPlace: 'Dhaka',
                    destinationPlace: 'Chittagong',
                    date: '10/2/2023',
                    fare: '200',
                  );
                },
              ))),
    );
  }
}
