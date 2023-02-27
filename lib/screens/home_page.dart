import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grootan_task/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/globals.dart';
import '../utils/styles.dart';
import '../utils/ui_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String ipAddress = "";
  String? _currentAddress = "";
  String? _currentDate = "";
  String? _currentTime = "";
  int? randomNumber = 0;
  bool _isInit = true,_isLoading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _reference = FirebaseFirestore.instance.collection('user_data');


  @override
  void didChangeDependencies() {
    if (_isInit) {
      getInitialData();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  getInitialData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await getLocation();
      getRandomNumber();
      final ipv6 = await Ipify.ipv64();
      ipAddress = ipv6;
      await submit();
      setState(() {
        _isLoading = false;
      });
      getRandomNumber();
    } catch (e) {
      print('Setting up -> ' + e.toString());
    }
  }

  Future<void> getLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.locality},'
            '${place.subLocality},${place.country}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var kHeight = UiHelper.getSize(context).height;
    return Scaffold(
      backgroundColor: Globals.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Globals.primary,
        actions: [
          InkWell(
            onTap: (){
              _logout(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0,right: 10),
              child: Text('Logout',
              style: Styles.headingStyle3(
                color: Colors.white
              ),),
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          :
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: kHeight,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: kHeight * 0.1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: QrImage(
                            backgroundColor: Colors.white,
                            data: randomNumber.toString(),
                            size: 150,
                            gapless: false,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: kHeight * 0.05,
                      ),
                      Text('Generated Number',
                          style: Styles.headingStyle4(
                              color: Colors.white
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(randomNumber.toString(),
                            style: Styles.headingStyle2(
                                color: Colors.white
                            )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.pushNamed(context, '/loginData');
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white)
                          ),
                          child: Center(
                            child: Text(
                              'Last Login at ${UiHelper.getFormattedDate(auth.currentUser!.metadata.lastSignInTime.toString())}',
                              style: Styles.headingStyle4(
                                  color: Colors.white,
                                  isBold:true
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        padding: 50,
                          text: "SAVE",
                          onTap: () async {
                             await submit();
                             getRandomNumber();
                             Fluttertoast.showToast(msg: "Updated Successfully!");
                          }
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 6),
                    child: Text("PLUGIN",
                      style: Styles.headingStyle5(
                          isBold: true,
                        color: Colors.white
                      ),),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<void> getRandomNumber() async {
    final random = Random();
    setState(() {
      randomNumber = random.nextInt(928392);
    });
  }

  Future<void> submit({int? generateNum}) async {
    var now = DateTime.now();
    setState(() {
      _currentDate = DateFormat('dd-MM-yyyy').format(now);
      _currentTime = DateFormat.jms().format(now);
    });
    Map<String, dynamic> dataToSend = {
      "qrData" : randomNumber,
      'ipAddress' : ipAddress,
      'location' : _currentAddress,
      'id' : auth.currentUser!.uid,
      'date' : _currentDate,
      'time' : _currentTime
    };
    _reference.add(dataToSend);
  }
}

Future<void> _logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).
    pushNamedAndRemoveUntil('/login', (Route route) => false);
  } catch (e) {
    print(e.toString());
  }
}