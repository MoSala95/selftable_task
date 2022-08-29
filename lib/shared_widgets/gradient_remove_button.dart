import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selftable_task/ui_helpers/ui_textStyles.dart';
class GradientRemoveButton extends StatelessWidget {
  final Function() onTap;
  const GradientRemoveButton({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all( Radius.circular(10)),

            gradient: LinearGradient(
              colors: [Color(0xffffffff), Color(0xffe0e0e0)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )


        ),
        child:  Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Remove",textAlign: TextAlign.center,style: UiTextStyles.addButtonTextStyle.copyWith(color: Colors.black),),
        ),
      ),
    );
  }
}
