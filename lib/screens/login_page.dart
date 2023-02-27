import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grootan_task/utils/ui_helper.dart';
import 'package:grootan_task/widgets/custom_button.dart';
import '../utils/globals.dart';
import '../utils/styles.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? smsCode;
  String? verificationCode;
  String? number;
  bool? isShow = false;

  @override
  Widget build(BuildContext context) {
    var kHeight = UiHelper.getSize(context).height;
    return Scaffold(
      backgroundColor: Globals.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Globals.primary,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40)
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text('Phone Number',
                            style: Styles.headingStyle4(
                                isBold: true,
                                color: Colors.white
                            )),
                      ),
                      TextField(
                        maxLength: 10,
                        onChanged: (val){
                          setState(() {
                            number = val;
                          });
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Globals.primary,
                        ),
                      ),
                      if(isShow!)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text("OTP",
                              style: Styles.headingStyle4(
                                  isBold: true,
                                  color: Colors.white
                              )),
                        ),
                      if(isShow!)
                      TextField(
                        maxLength: 6,
                        onChanged: (val){
                          setState(() {
                            smsCode = val;
                          });
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Globals.primary,
                        ),
                      ),
                      SizedBox(
                        height: kHeight * 0.05
                      ),
                      CustomButton(
                        padding: 40,
                          text: !isShow! ? "Send OTP" : "LOGIN",
                          onTap: (){
                          !isShow! ? _submit() : signIn();
                      })
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 6),
                child: Text("LOGIN",
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


  Future<void> _submit() async {
    UiHelper.openLoadingDialog(context, "Please Wait....");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91 $number",
        timeout: const Duration(seconds: 5),
        verificationCompleted: (AuthCredential credential) {},
        verificationFailed: (FirebaseAuthException exception) {
          print("${exception.message}");
        },
        codeSent: (String? verId, int? forceCodeResend) {
          verificationCode = verId;
          Navigator.pop(context);
          setState(() {
            isShow = true;
          });
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationCode = verId;
        }
    );
  }

  void signIn() {
    UiHelper.openLoadingDialog(context, "Please Wait..");
    AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationCode!, smsCode: smsCode!);
    Navigator.pop(context);
    FirebaseAuth.instance.signInWithCredential(phoneAuthCredential)
        .then((user) =>  Navigator.of(context).
    pushNamedAndRemoveUntil('/home', (Route route) => false),
    ).catchError((e) => print(e));
  }

}