import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/User.model.dart';
import '../component/button.dart';
import '../component/input_field.dart';
import '../controller/userController.dart';
import '../controller/utilsController.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileformKey = GlobalKey<FormState>();
  bool isLoading = false;
  File imageFile = File('');
  User user = User();
  UtilsController _utilsController = UtilsController();
  UserController userController = UserController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String avatar = '';
  @override
  void initState() {
    super.initState();
    // fatchData();
    user.email = '';
    user.mobileNumber = '';
    user.name = '';
    user.role = '';
    user.image = '';
    fatchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fatchData() async {
    _utilsController.getLocalStorage('id').then((value) {
      userController.userGetProfile(value).then((value) {
        if (value['status'] == 'success') {
          setState(() {
            user = User.fromJson(value['data']);
            nameController.text = user.name!;
            emailController.text = user.email!;
            phoneController.text = user.mobileNumber!;
            isLoading = false;
          });
        }
      });
    });
  }

  void updateProfile() async {
    user.name = nameController.text;
    user.email = emailController.text;
    user.mobileNumber = phoneController.text;

    userController.userUpdateProfile(user, imageFile).then((value) {
      if (value['status'] == 'success') {
        _utilsController.removeLocalStorage('user');
        _utilsController.setLocalStorage('user', jsonEncode(value['user']));

        setState(() {
          user = User.fromJson(value['user']);
        });
        _utilsController.showSnackBar(context, 'Profile Updated Successfully', Colors.green);
      } else {}
    });
  }

  Future chooseImage() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        avatar = imageFile.path;
      });
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
                          backgroundImage: NetworkImage(user.image!),
                        ),
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
                          InputField(hintText: 'Enter Your Full Name', controller: nameController),
                          const SizedBox(height: 10),
                          const MyText(
                            name: 'Email Address:',
                          ),
                          InputField(hintText: 'Enter Your Email', controller: emailController),
                          const SizedBox(height: 10),
                          const MyText(name: 'Phone Number:'),
                          InputField(hintText: 'Phone Number', controller: phoneController),
                          const SizedBox(height: 10),
                          const MyText(name: 'Address:'),
                          const InputField(hintText: 'Address'),
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


