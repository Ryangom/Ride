import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final controller;
  final prefixIcon;
  final keyboardType;

  const InputField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(18),
              focusColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              prefixIcon: prefixIcon,
              hintText: hintText,
              // if user not enter any value then return  null

              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            validator: (value) =>
                value!.isEmpty ? 'Please Enter $hintText' : null,
          ),
        ),
      ],
    );
  }
}


// TextFormField(
      
//       keyboardType: TextInputType.text,
//       decoration: const InputDecoration(
        
//         icon: Icon(Icons.lock),
//         hintText: 'Password',
//       ),
//       style: TextStyle(
//         fontSize: 16,
//         fontFamily: GoogleFonts.poppins().fontFamily,
//       ),
//     );