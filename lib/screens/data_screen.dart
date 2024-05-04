import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:picture_ai/constants.dart';
import 'package:picture_ai/controller/app_controller.dart';
import 'package:picture_ai/screens/detail-data_screen.dart';
import 'package:picture_ai/screens/home_screen.dart';

import '../widgets/widgets.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

// Getting instance of the controller
AppController appController = Get.put(AppController());

class _DataScreenState extends State<DataScreen> {
  late Future<bool> fetchData;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // fetching the data
    fetchData = appController.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  height: 75,
                  width: 75,
                  child: const CircularProgressIndicator(
                    color: Color.fromRGBO(41, 132, 75, 1),
                  ),
                ),
              ),
            );
            // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.data!) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'No network connection. Please check your internet connection.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("Data"),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      ...List.generate(
                          appController.dataModel?.predictions?.length ?? 0,
                          (index) => GestureDetector(
                                onTap: () {
                                  // Get.to(() => const DetailsScreen());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Image.network(
                                                    "${appController.dataModel?.predictions?[index].imageUrl}"),
                                              ),
                                            ),
                                          ),
                                          sizeHor(MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                          Flexible(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "${index + 1}",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          sizeHor(MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                          Flexible(
                                            flex: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "${appController.dataModel?.predictions?[index].highestConfidenceClass}",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    successDialog(
                                                        "${appController.dataModel?.predictions?[index].id}",
                                                        context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  //delete data dialog
  Future<dynamic> successDialog(String id, BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible:
          true, // Set to true if you want to allow dismissing the dialog by tapping outside it
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 20, sigmaY: 20), // Adjust the blur intensity as needed
          child: Container(
            height: 100,
            child: AlertDialog(
              title: Center(
                  child: isLoading
                      ? Container(
                          height: 50,
                          width: 50,
                          child: const CircularProgressIndicator(
                            color: Color.fromRGBO(41, 132, 75, 1),
                          ),
                        )
                      : const Icon(
                          Icons.check_circle_outline,
                          size: 40,
                        )),
              content: Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Container(
                  height: 50,
                  child: const Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Are you sure you delete this prediction',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Center(
                  child: DialogGradientButton(
                    title: 'Yes, I want to delete',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      print(id);
                      bool cleared = await appController.deleteInfo(id);
                      if (cleared) {
                        print("cleared");
                        Navigator.pop(context);
                        SuccessSnackbar.show(context, "Successful");
                        Get.offAll(() => const HomeScreen());
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                        ErrorSnackbar.show(context, "Unsuccessful");
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  child: Center(
                    child: DialogWhiteButton(
                      title: 'No, go back',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
