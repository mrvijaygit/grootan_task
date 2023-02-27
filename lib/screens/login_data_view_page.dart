import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grootan_task/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/globals.dart';
import '../utils/styles.dart';
import '../utils/ui_helper.dart';

class LoginDataViewPage extends StatefulWidget {
  const LoginDataViewPage({Key? key}) : super(key: key);


  @override
  State<LoginDataViewPage> createState() => _LoginDataViewPageState();
}

class _LoginDataViewPageState extends State<LoginDataViewPage> {
  late Stream<QuerySnapshot> _firstStream;
  late Stream<QuerySnapshot> _secondStream;
  late Stream<QuerySnapshot> _thirdStream;
  final CollectionReference _reference = FirebaseFirestore.instance.collection(
      'user_data');

  @override
  void initState() {
    _firstStream = _reference.snapshots();
    _secondStream = _reference.snapshots();
    _thirdStream = _reference.snapshots();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var kHeight = UiHelper
        .getSize(context)
        .height;
    var now = DateTime.now();
    var yesterday = DateTime.now().subtract(const Duration(days: 1));
    return Scaffold(
        backgroundColor: Globals.primary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Globals.primary,
          actions: [
            InkWell(
              onTap: () {
                _logout();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 10),
                child: Text('Logout',
                  style: Styles.headingStyle3(
                      color: Colors.white
                  ),),
              ),
            )
          ],
        ),
        body: Stack(
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
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(kToolbarHeight),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TabBar(
                            isScrollable: true,
                            tabs: [
                              Text('Today',
                                style: Styles.headingStyle5(
                                    isBold: true,
                                    color: Colors.white
                                ),),
                              Text('Yesterday',
                                style: Styles.headingStyle5(
                                    isBold: true,
                                    color: Colors.white
                                ),),
                              Text('Others',
                                style: Styles.headingStyle5(
                                    isBold: true,
                                    color: Colors.white
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firstStream,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text(
                                  'Some error occurred ${snapshot.error}'));
                            }
                            if (snapshot.hasData) {
                              return snapshot.data!.docs.isNotEmpty ?
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return
                                      snapshot.data!.docs[index]["date"] ==
                                          DateFormat('dd-MM-yyyy').format(now)
                                          ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          color: Colors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ListTile(
                                              title: Text(snapshot.data!
                                                  .docs[index]['time'],
                                                style: Styles.headingStyle5(
                                                    color: Colors.white
                                                ),),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text('IP:${snapshot.data!
                                                      .docs[index]['ipAddress']}',
                                                    style: Styles.headingStyle5(
                                                        color: Colors.white
                                                    ),),
                                                  Text(snapshot.data!
                                                      .docs[index]['location'],
                                                    style: Styles.headingStyle5(
                                                        color: Colors.white
                                                    ),),
                                                ],
                                              ),
                                              trailing: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(5)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      1.0),
                                                  child: QrImage(
                                                    backgroundColor: Colors
                                                        .white,
                                                    data: snapshot.data!
                                                        .docs[index]['qrData']
                                                        .toString(),
                                                    gapless: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) : const SizedBox();
                                  }) : Center(
                                  child: Text('No data available',
                                    style: Styles.headingStyle5(
                                        isBold: true
                                    ),)
                              );
                            }
                            return Container();
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _secondStream,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text(
                                  'Some error occurred ${snapshot.error}'));
                            }
                            if (snapshot.hasData) {
                              return snapshot.data!.docs.isNotEmpty ?
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return
                                      snapshot.data!.docs[index]["date"] ==
                                          DateFormat('dd-MM-yyyy').format(
                                              yesterday)
                                          ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          color: Colors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ListTile(
                                              title: Text(snapshot.data!
                                                  .docs[index]['time'],
                                                style: Styles.headingStyle5(
                                                    color: Colors.white
                                                ),),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text('IP:${snapshot.data!
                                                      .docs[index]['ipAddress']}',
                                                    style: Styles.headingStyle5(
                                                        color: Colors.white
                                                    ),),
                                                  Text(snapshot.data!
                                                      .docs[index]['location'],
                                                    style: Styles.headingStyle5(
                                                        color: Colors.white
                                                    ),),
                                                ],
                                              ),
                                              trailing: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(5)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      1.0),
                                                  child: QrImage(
                                                    backgroundColor: Colors
                                                        .white,
                                                    data: snapshot.data!
                                                        .docs[index]['qrData']
                                                        .toString(),
                                                    gapless: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) : const SizedBox();
                                  }) : Center(
                                  child: Text('No data available',
                                    style: Styles.headingStyle5(
                                        isBold: true
                                    ),)
                              );
                            }
                            return Container();
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _thirdStream,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text(
                                  'Some error occurred ${snapshot.error}'));
                            }
                            if (snapshot.hasData) {
                              return snapshot.data!.docs.isNotEmpty ?
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return
                                      (snapshot.data!.docs[index]["date"] !=
                                          DateFormat('dd-MM-yyyy').format(
                                              now) &&
                                          snapshot.data!.docs[index]["date"] !=
                                              DateFormat('dd-MM-yyyy').format(
                                                  yesterday))
                                          ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          color: Colors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ListTile(
                                              title: Text(snapshot.data!
                                                  .docs[index]['time'],
                                                style: Styles.headingStyle5(
                                                    color: Colors.white
                                                ),),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text('IP:${snapshot.data!
                                                      .docs[index]['ipAddress']}',
                                                    style: Styles.headingStyle5(
                                                        color: Colors.white
                                                    ),),
                                                  Text(snapshot.data!
                                                      .docs[index]['location'],
                                                    style: Styles.headingStyle5(
                                                        color: Colors.white
                                                    ),),
                                                ],
                                              ),
                                              trailing: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(5)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      1.0),
                                                  child: QrImage(
                                                    backgroundColor: Colors
                                                        .white,
                                                    data: snapshot.data!
                                                        .docs[index]['qrData']
                                                        .toString(),
                                                    gapless: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) : const SizedBox();
                                  }) : Center(
                                  child: Text('No data available',
                                    style: Styles.headingStyle5(
                                        isBold: true
                                    ),)
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 6),
                      child: Text("LAST LOGIN",
                        style: Styles.headingStyle5(
                            isBold: true,
                            color: Colors.white
                        ),),
                    ),
                  ),
                )),
            Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    padding: 30,
                    onTap: (){},
                    text: "SAVE",
                  )
                ))
          ],
        )
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).
      pushNamedAndRemoveUntil('/login', (Route route) => false);
    } catch (e) {
      print(e.toString());
    }
  }
}