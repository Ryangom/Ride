import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_user/Pages/dashboard.page.dart';
import 'package:ride_user/controller/authController.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget implements PreferredSizeWidget {
  AuthController authController = AuthController();

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff198C8B),
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
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/auth/login.png'),
                  // backgroundImage: image == ''
                  //     ? const AssetImage('assets/auth/login.png')
                  //     : NetworkImage(image) as ImageProvider<Object>,
                ),
              ),
              accountName: Text('Hi, ryan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  )),
              accountEmail: Text('email'),
            ),
          ),
          CustomListTile('Home', 'assets/icons/home.svg', () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Dashboard()));
          }),
          CustomListTile('Profile', 'assets/icons/user.svg', () {
            Navigator.pushNamed(context, '/profile');
          }),
          CustomListTile('Ride history', 'assets/icons/clock.svg', () {
            Navigator.pushNamed(context, '/rideHistory');
          }),
          CustomListTile('Ride Now', 'assets/icons/clock.svg', () {
            Navigator.pushNamed(context, '/rideNow');
          }),
          CustomListTile('Rent Car', 'assets/icons/clock.svg', () {
            Navigator.pushNamed(context, '/rentCar');
          }),
          CustomListTile('Support', 'assets/icons/clock.svg', () {
            Navigator.pushNamed(context, '/rentCar');
          }),
          CustomListTile('Logout', 'assets/icons/logout.svg', () async {
            authController.logOut();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

Widget CustomListTile(String title, String icon, dynamic) {
  return ListTile(
    textColor: Colors.white,
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
