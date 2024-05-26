import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_user/Pages/authPages/newPasswordPage.dart';
import 'package:ride_user/Service/networkProvider.dart';

class ForgetOtp extends StatefulWidget {
  final String? mobileNumber;
  final String? email;
  const ForgetOtp({
    super.key,
    this.mobileNumber,
    this.email,
  });

  @override
  State<ForgetOtp> createState() => _ForgetOtpState();
}

class _ForgetOtpState extends State<ForgetOtp> {
  // get mobile number from previous page
  String? mobileNumber = '';
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  var isLoading = false;
// constructor

  @override
  void initState() {
    super.initState();
    mobileNumber = widget.mobileNumber;
  }

  void confirm() async {
    setState(() {
      isLoading = true;
    });
    var otp = otp1.text + otp2.text + otp3.text + otp4.text;

    var response = await NetworkProvider()
        .post('/auth/verifyOtp', {"otp": otp, "mobileNumber": mobileNumber});
    var data = jsonDecode(response);

    if (data['status'] == 'success') {
      setState(() {
        isLoading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NewPasswordPage(mobileNumber: mobileNumber);
      }));
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
        ),
      );
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
                  child: Image.asset('assets/auth/otp.png'),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'An 4 digit code has been sent to your email\n ${widget.email}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6F7073),
                ),
              ),

              // make 4 text field for otp
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: otp1,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: otp2,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: otp3,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: otp4,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 50,
              ),

              Center(
                child: SizedBox(
                  width: 300,
                  height: 45,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xff02ADAB),
                            ),
                          ),
                          onPressed: () {
                            confirm();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const NewPasswordPage(),
                            //   ),
                            // );
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
              const SizedBox(
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
