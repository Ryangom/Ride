import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_user/Models/User.model.dart';
import 'package:ride_user/Models/test.dart';
import 'package:ride_user/Pages/authPages/loginPage.dart';
import 'package:ride_user/component/input_field.dart';
import 'package:ride_user/controller/authController.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //model
  User user = User();
  TestModel testModel = TestModel();
  AuthController authController = AuthController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPassword = true;

  void isPasswordToggle() {
    setState(() {
      isPassword = !isPassword;
    });
  }

  //form submit and validation and get data
  Future<void> submit() async {
    // testModel.name = 'somthing';

    // testModel.address ??= Address();
    // testModel.address!.city = 'London';
    // print(testModel.toJson());
    // authController.register(testModel).then((value) {});
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
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
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Image.asset('assets/auth/login.png'),
                ),
              ),
              Text(
                'Sign up',
                style: GoogleFonts.poppins(
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

// create sign up form
              Form(
                key: formKey,
                child: Column(
                  children: [
                    InputField(
                      hintText: 'Full Name',
                      controller: fullNameController,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InputField(
                      hintText: 'Email address',
                      controller: emailController,
                      prefixIcon: const Icon(Icons.alternate_email),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InputField(
                      hintText: 'Mobile Number',
                      controller: mobileController,
                      prefixIcon: const Icon(Icons.phone),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: isPassword,
                      controller: passwordController,
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
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: isPasswordToggle,
                          icon: Icon(
                            isPassword ? Icons.visibility : Icons.visibility_off,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                'By signing up, you’re agree to our Terms of Service and Privacy Policy.',
                style: TextStyle(
                  color: Color(0xff6F7073),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // create a login button
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
                    onPressed: submit,
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xff02ADAB),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
