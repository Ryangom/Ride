import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xff02ADAB),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
