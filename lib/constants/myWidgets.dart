import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grace_book_latest/Providers/MainProvider.dart';
import 'package:provider/provider.dart';
import 'my_colors.dart';

Widget textField(String hint, TextInputType type) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
    child: TextFormField(
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: clBlack,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
      keyboardType: type,
      inputFormatters: [
        type == TextInputType.number
            ? LengthLimitingTextInputFormatter(10)
            : FilteringTextInputFormatter.deny('')
      ],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
            color: clBlack),
        fillColor: const Color(0XFFF4FAFF),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: const BorderSide(
              color: Color(0XFFF4FAFF),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: const BorderSide(color: Color(0XFFF4FAFF))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: const BorderSide(
              color: Color(0XFFF4FAFF),
            )),
        hintText: hint,
      ),
    ),
  );
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height - 40);

    path.quadraticBezierTo(
        size.width / 4, size.height - 80, size.width / 2, size.height - 40);

    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DeliverDetailsTextForm extends StatelessWidget {
  final String hint;
  final bool color;
  final TextEditingController controller;

  const DeliverDetailsTextForm({
    super.key,
    required this.hint,
    required this.color, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, mainPro, _) {
      return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: color
                ? clE8AD14.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 7,
            offset: const Offset(0, 0), // Offset of the shadow
          ),
        ]),
        child: TextFormField(
          controller: controller,
          onTap: () {
            mainPro.textFieldColorChange(hint);
          },
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: cl404040,
              fontSize: 13,
              fontFamily: "PoppinsRegular"),
          cursorColor: clE8AD14,
          decoration: InputDecoration(
            labelText: hint,
            labelStyle: const TextStyle(
              color: cl7A7A7A,
              fontFamily: 'PoppinsRegular',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 0.4, color: clWhite)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 0.4, color: clWhite)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 0.4, color: clWhite)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite),
            ),
            hintText: hint,
            filled: true,
            fillColor: clWhite,
            hintStyle: const TextStyle(
                color: cl404040,
                fontSize: 12,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.w500),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please Enter $hint";
            } else {
              return null;
            }
          },
        ),
      );
    });
  }
}

class DeliverDetailsNumberTextForm extends StatelessWidget {
  final String hint;
  final bool color;
  final int inputCount;
  final TextEditingController controller;

  const DeliverDetailsNumberTextForm({
    super.key,
    required this.hint,
    required this.color,
    required this.inputCount, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, mainPro, _) {
      return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: color
                ? clE8AD14.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 7,
            offset: const Offset(0, 0), // Offset of the shadow
          ),
        ]),
        child: TextFormField(
          controller: controller,
          onTap: () {
            mainPro.textFieldColorChange(hint);
          },
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: cl404040,
              fontSize: 13,
              fontFamily: "PoppinsRegular"),
          cursorColor: clE8AD14,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: hint,
            labelStyle: const TextStyle(
              color: cl7A7A7A,
              fontFamily: 'PoppinsRegular',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 0.4, color: clWhite)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 0.4, color: clWhite)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 0.4, color: clWhite)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite),
            ),
            hintText: hint,
            filled: true,
            fillColor: clWhite,
            hintStyle: const TextStyle(
                color: cl404040,
                fontSize: 12,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.w500),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(inputCount)
          ],
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please Enter $hint";
            } else {
              return null;
            }
          },
        ),
      );
    });
  }
}

class ProfileTextFormWidget extends StatelessWidget {
  const ProfileTextFormWidget({
    super.key,
    required this.width,
    required this.label,
    required this.controller,
    required this.enable,
  });

  final double width;
  final String label;
  final TextEditingController controller;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 1.1,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),

          blurRadius: 7,

          offset: const Offset(0, 0), // Offset of the shadow
        ),
      ]),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: cl404040,
            fontSize: 13,
            fontFamily: "PoppinsRegular"),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: cl7A7A7A,
            fontFamily: 'PoppinsRegular',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite)),
          enabled: enable,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 0.4, color: clWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 0.4, color: clWhite),
          ),
          hintText: label,
          filled: true,
          fillColor: clWhite,
          hintStyle: const TextStyle(
              color: cl404040,
              fontSize: 12,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w500),
        ),
        validator: (value) {
          if (value!.trim().isEmpty) {
            return "Please Enter $label";
          } else {
            return null;
          }
        },
      ),
    );
  }
}

class ProfileTextFormWidgetNumber extends StatelessWidget {
  const ProfileTextFormWidgetNumber({
    super.key,
    required this.width,
    required this.label,
    required this.controller,
    required this.length,
    required this.enable, this.onChanged,
  });

  final double width;
  final String label;
  final int length;
  final TextEditingController controller;
  final bool enable;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    print("dmkmkmkNEW ");
    return Container(
      width: width / 1.1,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),

          blurRadius: 7,

          offset: const Offset(0, 0), // Offset of the shadow
        ),
      ]),
      child: TextFormField(
onChanged: onChanged,
        enabled: enable,
        keyboardType: TextInputType.number,
        controller: controller,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: cl404040,
            fontSize: 13,
            fontFamily: "PoppinsRegular"),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: cl7A7A7A,
            fontFamily: 'PoppinsRegular',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.4, color: clWhite)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 0.4, color: clWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 0.4, color: clWhite),
          ),
          hintText: label,
          filled: true,
          fillColor: clWhite,
          hintStyle: const TextStyle(
              color: cl404040,
              fontSize: 12,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w500),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(length),
        ],
        validator: (value) {
          if (value!.trim().isEmpty) {
            return "Please Enter $label";
          } else {
            return null;
          }
        },
      ),
    );
  }
}

class ProfileDetailWidget extends StatelessWidget {
  final double width;
  final double height;
  final String head;
  final String tail;

  const ProfileDetailWidget({
    super.key,
    required this.width,
    required this.height,
    required this.head,
    required this.tail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: width / 1.1,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: clWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 7,
            offset: Offset(0, 0),
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head,
            style: const TextStyle(
              color: Color(0xFF797979),
              fontSize: 9,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.27,
            ),
          ),
          SizedBox(height: height / 139.3333333333333),
          Text(
            tail,
            style: const TextStyle(
              color: Color(0xFF404040),
              fontSize: 12,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.36,
            ),
          ),
        ],
      ),
    );
  }
}


CircularProgressIndicator waitingIndicator = const CircularProgressIndicator(
    color: Colors.white,
    strokeCap: StrokeCap.round,
    strokeWidth: 4,
    strokeAlign: 0.01);
