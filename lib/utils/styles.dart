import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'globals.dart';

class Styles {

  static InputDecoration textFormFieldStyle({
    String labelText = '',
    IconData prefixIconData = Icons.person,
    IconData? suffixIconData,
    Function? onPressed,
    bool showVerify = false,
  }) {
    return InputDecoration(
      labelStyle: const TextStyle(
        color: Globals.primary,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      hintStyle: const TextStyle(
        color: Globals.primary,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      border: InputBorder.none,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      counterText: "",
      labelText: "$labelText\t",
      suffixIconConstraints: BoxConstraints(maxWidth: 50),
      suffixIcon: suffixIconData != null || showVerify
          ? GestureDetector(
        onTap: onPressed as void Function()?,
        child: suffixIconData is IconData
            ? Container(
          alignment: Alignment.center,
          child: Icon(
            suffixIconData,
            size: 18,
            color: Globals.primary,
          ),
        )
            : Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            'VERIFY',
            textAlign: TextAlign.center,
            style: Styles.headingStyle7(
              color: Colors.indigoAccent,
              isBold: true,
              underline: true,
            ),
          ),
        ),
      ) : null,
    );
  }

  static InputDecoration requestFormFieldStyle({
    String labelText = '',
    IconData? suffixIconData,
    Function? onPressed,
    bool showVerify = false,
  }) {
    return InputDecoration(
      labelStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      ),
      hintStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1.5,
          color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            width: 1.15,
            color: Colors.grey
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      counterText: "",
      labelText: "$labelText\t",
      suffixIconConstraints: const BoxConstraints(maxWidth: 50),
    );
  }

  static TextStyle whiteButtonStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle greenButtonStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle headingStyle1({Color color = Colors.black}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: 30,
    );
  }

  static TextStyle headingStyle2({Color color = Globals.dark}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );
  }

  static TextStyle headingStyle3({Color color = Globals.dark}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
  }

  static TextStyle headingStyle4(
      {Color color = Globals.dark, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
    );
  }

  static TextStyle headingStyle5(
      {Color color = Globals.dark, bool strike = false, bool isBold = false,double? fontSize}) {
    return TextStyle(
      color: color,
      fontSize: fontSize??14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
      decorationThickness: strike ? 1.5 : 0,
    );
  }

  static TextStyle subHeading1(
      {Color color = Globals.dark, bool strike = false, bool isBold = false,double? fontSize}) {
    return TextStyle(
      color: color,
      fontSize: fontSize??14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
      decorationThickness: strike ? 1.5 : 0,
    );
  }

  static TextStyle headingStyle6(
      {Color color = Globals.dark, bool isBold = false, bool strike = false}) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static TextStyle headingStyle7({
    Color color = Globals.dark,
    bool isBold = false,
    bool strike = false,
    bool underline = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: 10,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      decoration: strike
          ? TextDecoration.lineThrough
          : underline
          ? TextDecoration.underline
          : TextDecoration.none,
    );
  }

  static TextStyle headingStyle8(
      {Color color = Globals.dark, bool isBold = false, bool strike = false}) {
    return TextStyle(
      color: color,
      fontSize: 7,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static Widget dropDownHeaderText({String? text}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          text: '$text ',
          style: Styles.headingStyle5(),
          children: const[
            TextSpan(
              text: ' ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget starHeaderText({String? text,
    bool? isRequired = true,
    Color textColor = Globals.primary}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 15, 8),
      child: RichText(
        text: TextSpan(
          text: '$text ',
          style: Styles.headingStyle5(color: textColor,isBold: true),
          children: [
            TextSpan(
              text: isRequired==true ? '*': '',
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  static InputDecoration textFieldStyle(
      { String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        //color: Globals.purple,
        fontSize: 16,
      ),
      border: const OutlineInputBorder(), //InputBorder.none,
      counterText: '',
    );
  }




// static TextStyle homeCategoryNameStyle() {
//   return const TextStyle(
//     color: Globals.green, //Colors.black,
//     fontSize: 12,
//     fontWeight: FontWeight.w600,
//   );
// }
//
// static TextStyle tableHeadingStyle2({Color color = Colors.black,double size=20 }) {
//   return const TextStyle(
//     color: color,
//     fontWeight: FontWeight.w700,
//     fontSize: size,
//   );
// }
}
