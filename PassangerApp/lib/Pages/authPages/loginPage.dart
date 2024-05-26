import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_user/Pages/authPages/signUpPage.dart';
import 'package:ride_user/component/button.dart';
import 'package:ride_user/controller/utilsController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/input_field.dart';
import 'forgetPassPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obsecureText = true;

  //form key
  final _formKey = GlobalKey<FormState>();
  UtilsController utilsController = UtilsController();

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    checkAlreadyLoggedin();
  }

  void toggle() {
    setState(() {
      obsecureText = !obsecureText;
    });
  }

  //api call

  Future<void> login() async {
    // setState(() {
    //   isLoading = true;
    // });
    // var payload = {
    //   'mobileNumber': mobileController.text,
    //   'password': passwordController.text,
    //   'role': 'user'
    // };

    // if (_formKey.currentState!.validate()) {
    //   var response = await NetworkProvider().post('/auth/login', payload);
    //   var data = jsonDecode(response);
    //   if (data['message'] == 'success') {
    //     final name = data['user']['name'];
    //     final image = data['user']['image'];
    //     final role = data['user']['role'];
    //     final email = data['user']['email'];
    //     setState(() {
    //       isLoading = false;
    //     });
    //     Map<String, dynamic> decodedToken = JwtDecoder.decode(data['token']);

    //     SharedPreferences prefs = await SharedPreferences.getInstance();
    //     prefs.setString('token', data['token']);
    //     prefs.setString('id', decodedToken['id']);
    //     prefs.setString('name', name);
    //     prefs.setString('image', image);
    //     prefs.setString('role', role);
    //     prefs.setString('email', email);

    //     Navigator.pushReplacementNamed(context, '/');
    //   } else {
    //     setState(() {
    //       isLoading = false;
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(data['message']),
    //       ),
    //     );
    //   }
    // }

    if (_formKey.currentState!.validate()) {
      utilsController.setLocalStorage('isLogin', 'true');

      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

// get token from shared preference
  Future checkAlreadyLoggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/');
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Image.asset('assets/auth/login.png'),
                ),
              ),
              Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // create a login form with email and password validation
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        hintText: 'Mobile Number',
                        controller: mobileController,
                        prefixIcon: const Icon(Icons.person),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obsecureText,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(18),
                          focusColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xffB5B5B5),
                          ),
                          suffixIcon: IconButton(
                            onPressed: toggle,
                            icon: Icon(
                              obsecureText ? Icons.visibility : Icons.visibility_off,
                              color: const Color(0xffB5B5B5),
                            ),
                          ),
                          hintText: 'Password',
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
                        validator: (value) => value!.isEmpty ? 'Password is required' : null,
                      ),
                    ],
                  )),

              const SizedBox(
                height: 10,
              ),

              // create a forget password text on the right side
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff02ADAB),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // create a login button
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : MyButton(
                        text: 'Login',
                        onPressed: () {
                          login();
                        },
                      ),
              ),

              const SizedBox(
                height: 30,
              ),

              const Center(
                child: Text(
                  'or continue with',
                  style: TextStyle(
                      color: Color(0xffB5B5B5), fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // create a login with google, facebook, twitter using svg
              Center(
                child: SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        iconSize: 40,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/auth/facebook.svg',
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        iconSize: 40,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/auth/apple.svg',
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        iconSize: 40,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/auth/google.svg',
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have any account?',
                      style: TextStyle(
                        color: Color(0xff6F7073),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Color(0xff02ADAB),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                    ),
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
