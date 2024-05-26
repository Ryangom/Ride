import 'package:flutter/material.dart';

import '../component/historyCard.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const HistoryCard(
                    id: '1',
                    date: '2021-10-10',
                    destinationPlace: 'Kathmandu',
                    fare: '1000',
                    type: 'Regular',
                    pickupPlace: 'Pokhara',
                  );
                }),
          ),
        ));
  }
}
