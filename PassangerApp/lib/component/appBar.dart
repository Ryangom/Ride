import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title = '';
  HomeAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsIconTheme: IconThemeData(color: Colors.black),
      title: title != ''
          ? Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu_sharp,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10, top: 5),
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/auth/login.png'),
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
