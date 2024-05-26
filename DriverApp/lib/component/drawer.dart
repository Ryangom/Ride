import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/User.model.dart';
import '../Pages/dashboard.page.dart';
import '../controller/authController.dart';
import '../controller/utilsController.dart';

class CustomDrawer extends StatefulWidget implements PreferredSizeWidget {
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AuthController authController = AuthController();
  User user = User();
  UtilsController _utilsController = UtilsController();

  bool isImage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _utilsController.getLocalStorage('user').then((value) {
      user = User.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 228, 226, 226),
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xff06122A),
              ),
              currentAccountPicture: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: CircleAvatar(
                  backgroundImage: isImage
                      ? AssetImage('assets/auth/login.png')
                      : NetworkImage(user.image.toString()) as ImageProvider<Object>,
                ),
              ),
              accountName: Text(user.name.toString(),
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 18,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  )),
              accountEmail: Text(user.email.toString()),
            ),
          ),
          CustomListTile('Home', 'assets/svgIcons/home.svg', () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Dashboard()));
          }),
          CustomListTile('Profile', 'assets/svgIcons/profile.svg', () {
            Navigator.pushNamed(context, '/profile');
          }),
          CustomListTile('Ride Requests', 'assets/svgIcons/RideRequest.svg', () {
            Navigator.pushNamed(context, '/rideRequests');
          }),
          CustomListTile('Intercity Rides', 'assets/svgIcons/scheduleRides.svg', () {
            Navigator.pushNamed(context, '/scheduleRides');
          }),
          CustomListTile('History', 'assets/svgIcons/history.svg', () {
            Navigator.pushNamed(context, '/history');
          }),
          CustomListTile('Support', 'assets/svgIcons/support.svg', () {
            Navigator.pushNamed(context, '/a');
          }),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          CustomListTile('Logout', 'assets/svgIcons/logout.svg', () async {
            authController.logOut();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }),
        ],
      ),
    );
  }

  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

Widget CustomListTile(String title, String icon, dynamic) {
  return ListTile(
    textColor: Colors.black,
    leading: SvgPicture.asset(
      icon,
      width: 25,
      height: 25,
    ),
    title: Text(title,
        style: const TextStyle(
          fontSize: 18,
        )),
    onTap: dynamic,
  );
}
