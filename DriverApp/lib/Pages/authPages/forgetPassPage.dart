import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgetOtp.page.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _SignForgetPassState();
}

class _SignForgetPassState extends State<ForgetPassPage> {
  bool obsecureText = true;
  bool isLoading = false;
  TextEditingController mobileNumberController = TextEditingController();
  void toggle() {
    setState(() {
      obsecureText = !obsecureText;
    });
  }

  void submit() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ForgetOtp(mobileNumber: '0000000', email: 'sadsad@adfaf');
    }));
    // var mobile = mobileNumberController.text;

    // var response = await NetworkProvider().post('/auth/forgotPassword', {'mobileNumber': mobile});
    // var data = jsonDecode(response);
    // if (data['status'] == 'success') {

    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(data['message']),
    //     ),
    //   );
    // }
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Image.asset('assets/auth/ForgotPassword.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Forgot \nPassword?',
                style: GoogleFonts.poppins(
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Don’t worry! It happens. Please enter the Email Address associated with your account.',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: mobileNumberController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Phone number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff02ADAB),
                          ),
                        ),
                        onPressed: () {
                          submit();
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
