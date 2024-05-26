// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utility/ui_styles.dart';

class HistoryCard extends StatefulWidget {
  final id;
  final pickupPlace;
  final destinationPlace;
  final date;
  final fare;
  final type;
  const HistoryCard(
      {super.key,
      required this.id,
      this.pickupPlace,
      this.destinationPlace,
      this.date,
      this.fare,
      this.type});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monday 8-2-23 10:20 AM',
              style: kHeadLine1(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              height: 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 243, 241, 241),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 168, 168, 168),
                    blurRadius: 10.0,
                  ),
                ],
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
                          'assets/svgIcons/route-line.svg',
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: widget.type == 'Regular'
                                ? Color.fromARGB(255, 33, 14, 141)
                                : Color.fromARGB(255, 6, 144, 172),
                          ),
                          child: Text(
                            widget.type,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
          ],
        ));
  }
}
