import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utility/ui_styles.dart';

class HistoryCard extends StatefulWidget {
  final id;
  final pickupPlace;
  final destinationPlace;
  final date;
  final fare;

  const HistoryCard(
      {super.key, required this.id, this.pickupPlace, this.destinationPlace, this.date, this.fare});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/rideHistoryDetails', arguments: widget.id.toString());
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 140,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffB9BCEC),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.pickupPlace.toString(),
                    style: kTextStyle2,
                  ),
                  SvgPicture.asset(
                    'assets/Dashboard/route-line.svg',
                    height: 50,
                    width: 50,
                  ),
                  Text(
                    widget.destinationPlace.toString(),
                    style: kTextStyle2,
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.date.toString(),
                    style: kTextStyle2,
                  ),
                  Text(
                    '৳ ${widget.fare}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 33, 14, 141),
                    ),
                  ),
                ],
              ),

              // Middle icon

              // Bottom Row
            ],
          ),
        ),
      ),
    );
  }
}
