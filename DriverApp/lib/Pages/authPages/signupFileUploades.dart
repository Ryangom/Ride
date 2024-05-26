// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_Driver/Models/User.model.dart';
import 'package:ride_Driver/component/button.dart';
import 'package:ride_Driver/controller/authController.dart';
import 'package:ride_Driver/controller/utilsController.dart';
import 'package:ride_Driver/utility/ui_styles.dart';

import '../../Models/Vehicle.model.dart';
import '../../component/input_field.dart';

class SignupFileUploades extends StatefulWidget {
  final User user;
  const SignupFileUploades({super.key, required this.user});

  @override
  State<SignupFileUploades> createState() => _SignupFileUploadesState();
}

class _SignupFileUploadesState extends State<SignupFileUploades> {
  File? idCard;
  String idCardName = '';
  File? drivingLicense;
  String drivingLicenseName = '';
  File? registration;
  String registrationName = '';
  File? vehicleImage;
  String vehicleImageName = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = User();
  AuthController authController = AuthController();
  UtilsController utilsController = UtilsController();

  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
  }

  Future chooseImage(String type) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      switch (type) {
        case 'idCard':
          setState(() {
            idCard = File(image.path);
            idCardName = image.name;
          });
          break;

        case 'drivingLicense':
          setState(() {
            drivingLicense = File(image.path);
            drivingLicenseName = image.name;
          });
          break;

        case 'registration':
          setState(() {
            registration = File(image.path);
            registrationName = image.name;
          });
          break;
        case 'vehicleImage':
          setState(() {
            vehicleImage = File(image.path);
            vehicleImageName = image.name;
          });
          break;
        default:
      }
    }
  }

  void submit() {
    //set vehicle information
    if (formKey.currentState!.validate() &&
        idCard != null &&
        drivingLicense != null &&
        registration != null &&
        vehicleImage != null) {
      user.vehicle ??= Vehicle();
      user.vehicle!.name = vehicleNameController.text;
      user.vehicle!.plateNumber = plateNumberController.text;
      user.vehicle!.color = colorController.text;
      user.location = Location();
      user.location!.type = 'Point';
      user.location!.coordinates = [0, 0];

      authController
          .driverRegister(
        user,
        vehicleImage!,
        idCard!,
        registration!,
        drivingLicense!,
      )
          .then((value) {
        if (value['status'] == 'success') {
          Navigator.pushNamed(context, '/login');
          utilsController.showSnackBar(context, 'Your account succesfully created!!', Colors.green);
        } else {
          utilsController.showSnackBar(context, 'Somthing Went Worng!', Colors.red);
        }
      });
    } else {
      utilsController.showSnackBar(
          context, 'Please fill all the fields and upload all the files..', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Form'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload documents',
                  style: kHeadLine1(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                fileUpload(
                  'ID Card',
                  Icon(Icons.drive_file_rename_outline),
                  () {
                    chooseImage('idCard');
                  },
                  idCardName,
                ),
                fileUpload(
                  'Driving License',
                  Icon(Icons.drive_file_rename_outline),
                  () {
                    chooseImage('drivingLicense');
                  },
                  drivingLicenseName,
                ),
                fileUpload(
                  'Registration ',
                  Icon(Icons.drive_file_rename_outline),
                  () {
                    chooseImage('registration');
                  },
                  registrationName,
                ),
                Text(
                  'Vehicle Information',
                  style: kHeadLine1(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                InputField(
                  hintText: 'Vehicle Name',
                  controller: vehicleNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                InputField(
                  hintText: 'Plate Number',
                  controller: plateNumberController,
                ),
                SizedBox(
                  height: 10,
                ),
                InputField(
                  hintText: 'Color',
                  controller: colorController,
                ),
                SizedBox(
                  height: 20,
                ),
                fileUpload(
                  'Vehicle Image ',
                  Icon(Icons.drive_file_rename_outline),
                  () {
                    chooseImage('vehicleImage');
                  },
                  vehicleImageName,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(child: MyButton(text: 'Submit', onPressed: submit)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget fileUpload(
  String fieldName,
  Icon icon,
  void Function() onPressed,
  String fileName,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 10,
              ),
              Text(
                fieldName,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: SizedBox(
              width: 130,
              height: 35,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 223, 223, 223),
                  ),
                ),
                child: Text(
                  'Choose File',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Text(fileName),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
