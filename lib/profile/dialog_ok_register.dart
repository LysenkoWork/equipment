import 'package:equipment/widgets/text_extension.dart';
import 'package:equipment/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Dialog dialogOkRegister(BuildContext context, String info, String error) {
  return Dialog(
    backgroundColor: const Color(0xFF2F2E41),
    insetPadding: const EdgeInsets.all(20),
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          SvgPicture.asset('assets/logo.svg'),
          const SizedBox(height: 20),
          Text(info).style16w700(color: Colors.white),
          const SizedBox(height: 20),
          Text(error).style16w700(color: Colors.white),
          const SizedBox(height: 20),
          AppFilledButton('Продолжить', backgroundColor: AppColor.blueColor, onPressed: () {
            Navigator.pop(context, 'Ok');
          }),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
