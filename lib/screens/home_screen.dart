import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:picture_ai/controller/app_controller.dart';

import '../widgets/widgets.dart';
import 'data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();
  File? imageFile;
  String? imageFilePath;
  bool isLoading = false;
  AppController appController = Get.put(AppController());

  Future<void> pickImage() async {
    // Request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      final result = await Permission.storage.request();
      if (result != PermissionStatus.granted) {
        print('Storage permission denied');
        return; // Exit the function if permission is denied
      }
    }

    // Show image source selection dialog
    final imageSource = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Select Image Source'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    ListTile(
                      title: Text('Camera'),
                      onTap: () => Navigator.pop(context, ImageSource.camera),
                    ),
                    ListTile(
                      title: Text('Gallery'),
                      onTap: () => Navigator.pop(context, ImageSource.gallery),
                    ),
                  ],
                ),
              ),
            ));

    if (imageSource != null) {
      try {
        final pickedFile = await picker.pickImage(source: imageSource);
        if (pickedFile != null) {
          setState(() {
            imageFile = File(pickedFile.path);
            imageFilePath = pickedFile.path;
          });
        }
      } catch (e) {
        print("Error picking image: $e");
      }
    }
  }

  String imageStatus =
      "Image should be 256x256 in dimensions, Upload file as PNG or JPEG.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Upload image"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.08,
                      top: MediaQuery.of(context).size.height * 0.08),
                  child: Column(
                    children: [
                      imageFile == null
                          ? GestureDetector(
                              onTap: () async {
                                pickImage();
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    width: 181.43, // Adjust as needed
                                    height:
                                        181.43, // Should be equal to width for a perfect circle
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffD9D9D9),
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          pickImage();
                                        },
                                        child: const Text(
                                          '+',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 50,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0, right: 10),
                                    child: GestureDetector(
                                      onTap: () async {
                                        pickImage();
                                      },
                                      child: Container(
                                        width: 40, // Adjust as needed
                                        height:
                                            40, // Should be equal to width for a perfect circle
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                              "assets/svgs/add_image.svg"),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                pickImage();
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    width: 181.43, // Adjust as needed
                                    height: 181.43,
                                    child: ClipOval(
                                      child: Image.file(
                                        fit: BoxFit.cover,
                                        imageFile!,
                                        width: 181.43, // Adjust as needed
                                        height: 181.43,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0, right: 10),
                                    child: GestureDetector(
                                      onTap: () async {
                                        pickImage();
                                      },
                                      child: Container(
                                        width: 40, // Adjust as needed
                                        height:
                                            40, // Should be equal to width for a perfect circle
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                              "assets/svgs/add_image.svg"),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: Container(
                          // width: 214,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 9),
                          decoration: ShapeDecoration(
                            color: Color(0xffD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            imageStatus,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              primaryButton(
                  "Log Data"
                  "", () async {
                setState(() {
                  isLoading = true;
                });
                bool sent = await appController.uploadPhoto(imageFile);
                if (sent) {
                  SuccessSnackbar.show(context, "Successful");
                  Get.to(() => const DataScreen());
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  ErrorSnackbar.show(context, "An error occured");
                }
              },
                  isLoading,
                  context,
                  imageFile != null ? Colors.blue : Colors.grey.shade400,
                  Colors.white,
                  Container()),
            ],
          ),
        ),
      ),
    );
  }
}
