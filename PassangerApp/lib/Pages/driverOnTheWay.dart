import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_user/component/button.dart';
import 'package:ride_user/component/mapRouteBuilder.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../utility/ui_styles.dart';

class DriverOnTheWay extends StatefulWidget {
  const DriverOnTheWay({super.key});

  @override
  State<DriverOnTheWay> createState() => _DriverOnTheWayState();
}

class _DriverOnTheWayState extends State<DriverOnTheWay> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        appBar: AppBar(),
        body: SafeArea(
            child: Column(
          children: [
            Stack(
              //map
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 80,
                  width: MediaQuery.of(context).size.width,
                  child: MapRouteBuilder(
                    pickup: LatLng(23.70049097770006, 90.35004946033344),
                    destination: LatLng(23.67843214016422, 90.40373852430656),
                    points: [],
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red,
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Icon(
                                  Icons.warning_amber_sharp,
                                  color: Colors.yellow,
                                  size: 35,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => SizedBox(
                                      height: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: DropOffSheet(context),
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Drop Off',
                                    style: TextStyle(color: Colors.white, fontSize: 18)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
              // button group bottom
            )
          ],
        )));
  }
}

Widget DropOffSheet(BuildContext context) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Confirm that the driver drop you off in correct location?',
        style: kHeadLine1(fontSize: 22.0),
      ),
      Text(
        'If driver dropped you off at wrong location.\nThen let us by report the incident... ',
        style: kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.normal),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => Report(),
              );
            },
            text: 'Report',
            color: Colors.white,
            Bgcolor: Colors.red,
            fontSize: 20.0,
          ),
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => FeedbackSheet(),
              );
            },
            text: 'Yes',
            color: Colors.white,
            Bgcolor: Colors.green,
            fontSize: 20.0,
          ),
        ],
      ),
    ],
  ));
}

class FeedbackSheet extends StatefulWidget {
  const FeedbackSheet({super.key});

  @override
  State<FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<FeedbackSheet> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.8,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'How was your trip?',
                  style: kHeadLine1(fontSize: 22.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Your feedback will help us improve \napp experience better.',
                  style:
                      kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: (v) {
                    setState(() {
                      rating = v;
                    });
                  },
                  starCount: 5,
                  rating: rating,
                  size: 40.0,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.blur_on,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your feedback here...',
                        hintStyle: kHeadLine1(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MyButton(text: 'Submit', onPressed: () {})
              ]),
        ),
      ),
    );
  }
}

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // user can report the incident
              Text(
                'Report Incident',
                style: kHeadLine1(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Text(
                'Please describe the incident',
                style: kHeadLine1(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type here...',
                    hintStyle: kHeadLine1(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CustomButton(
                  onPressed: () {},
                  text: 'Submit',
                  color: Colors.white,
                  Bgcolor: Colors.green,
                  fontSize: 20.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color Bgcolor;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.Bgcolor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Bgcolor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: color, fontSize: fontSize)),
      ),
    );
  }
}
