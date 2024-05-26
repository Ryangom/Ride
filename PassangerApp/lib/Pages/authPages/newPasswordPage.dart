import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_user/Service/networkProvider.dart';

class NewPasswordPage extends StatefulWidget {
  final String? mobileNumber;
  const NewPasswordPage({
    super.key,
    this.mobileNumber,
  });

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool obsecureText = true;
  String? mobileNumber = '';
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    mobileNumber = widget.mobileNumber;
  }

  void toggle() {
    setState(() {
      obsecureText = !obsecureText;
    });
  }

  void confirm() async {
    print(mobileNumber);
    var password = this.password.text;
    var confirmPassword = this.confirmPassword.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password does not match'),
        ),
      );
      return;
    } else {
      var response = await NetworkProvider().post('/auth/savePass',
          {"mobileNumber": mobileNumber, "password": confirmPassword});
      var data = jsonDecode(response);

      if (data['status'] == 'success') {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password changed successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Image.asset('assets/auth/ForgotPasswordVerify.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Enter new\npassword',
                style: GoogleFonts.poppins(
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),

              //add an icon before the text field using row
              Row(
                children: [
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/icons/key.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: password,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'New password',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: const Color(0xff7C879B)),
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/icons/key.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmPassword,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Confirm new password',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: const Color(0xff7C879B)),
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              Center(
                child: SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff02ADAB),
                      ),
                    ),
                    onPressed: () {
                      confirm();
                    },
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff0052CC),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
