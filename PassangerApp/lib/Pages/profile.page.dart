import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_user/Models/User.model.dart';
import 'package:ride_user/component/button.dart';
import 'package:ride_user/component/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Service/networkProvider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  final profileformKey = GlobalKey<FormState>();
  File imageFile = File('');

  User user = User();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fatchData();
    user.email = '';
    user.mobileNumber = '';
    user.name = '';
    user.role = '';
    user.image = '';
  }

  void fatchData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    var response = await NetworkProvider().get('/user/getSingleUser/$id');
    if (response['status'] == 'success') {
      user = User.fromJson(response['user']);
      nameController.text = user.name!;
      emailController.text = user.email!;
      phoneController.text = user.mobileNumber!;

      setState(() {
        isLoading = false;
      });
    }
  }

  void updateProfile() async {
    setState(() {
      isLoading = true;
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? id = prefs.getString('id');

    user.name = nameController.text;
    user.email = emailController.text;
    user.mobileNumber = phoneController.text;

    var response =
        await NetworkProvider().post('/user/userUpdateUserProfile/', user);

    var result = jsonDecode(response);
    if (result["status"] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Updated Successfully'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future chooseImage() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image!.path);
    });

    if (imageFile.path.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString('id');

      var response = await NetworkProvider()
          .postImages('/user/uploadFile/${id}', imageFile);

      if (response['status'] == 'success') {
        // fatchData();
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile Picture Updated Successfully'),
          ),
        );
        fatchData();
      }
      // print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    //make a form to update the user's profile
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  // profile picture
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: 70,
                            // backgroundImage: imageFile.path.isEmpty
                            //     ? const AssetImage(
                            //         'assets/auth/ForgotPassword.png')
                            //     : FileImage(imageFile) as ImageProvider),
                            backgroundImage: user.image == ''
                                ? const AssetImage(
                                    'assets/auth/ForgotPassword.png')
                                : NetworkImage(user.image!) as ImageProvider),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff02ADAB),
                              ),
                              child: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: chooseImage,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    child: Form(
                      key: profileformKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyText(name: 'Your Name:'),
                          InputField(
                              hintText: 'sd', controller: nameController),
                          const SizedBox(height: 10),
                          const MyText(
                            name: 'Email Address:',
                          ),
                          InputField(
                              hintText: 'sd', controller: emailController),
                          const SizedBox(height: 10),
                          const MyText(name: 'Phone Number:'),
                          InputField(
                              hintText: 'sd', controller: phoneController),
                          const SizedBox(height: 10),
                          const MyText(name: 'Address:'),
                          const InputField(hintText: 'sd'),
                          const SizedBox(height: 10),
                          Center(
                            child: MyButton(
                                text: 'Update',
                                onPressed: () {
                                  updateProfile();
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget bottom() {
    return Container(
      height: 190,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text('Choose Profile Picture',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            // onTap: takeImage,
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
            onTap: chooseImage,
          ),
        ],
      ),
    );
  }
}

//make a text widget to show the user's name

class MyText extends StatelessWidget {
  final name;

  const MyText({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(name,
          style: TextStyle(
            fontSize: 16,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}

// make a bottom sheet to choose between camera and gallery to upload the profile picture


