
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:selftable_task/ui_helpers/color_constants.dart';

class InputWidget extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final String? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final Function(String? value)? onFieldSubmitted;
  final Function(String? value)? onSaved;
  final Function(String value)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final AutovalidateMode? autoValidateMode;

  final Key? key;
  final bool? obscureText;
  final FocusNode? focusNode;
  final Color? boderColor;
  final bool showMaxCharCounter;
  final String? helperText;

  final Color? fillColor;
  final TextEditingController? controller;

  final int? maxLines;
  final int? maxCharacterLength;
  final TextStyle? textInputStyle;
  Color? textInputColor;

  InputWidget(
      {this.key,
      this.initialValue,
      this.hintText,
      this.title,
      this.suffixIcon,
      this.prefixIcon,
      this.keyboardType,
      this.textInputAction,
      this.validator,
      this.onFieldSubmitted,
      this.onSaved,
      this.onChanged,
      this.obscureText,
      this.focusNode,
      this.boderColor,
      this.controller,

      this.fillColor,
      this.readOnly = false,
      this.enabled = true,

      this.showMaxCharCounter = false,
      this.onTap,
      this.maxLines,
      this.autoValidateMode,
      this.maxCharacterLength,
        this.helperText,

        this.textInputStyle,
        this.textInputColor
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "$title",
                    ),
                  ),
            TextFormField(
              initialValue: initialValue,
              controller: controller,
              onTap: onTap,
              readOnly: readOnly,
              enabled: enabled,
              autovalidateMode: autoValidateMode,
              decoration: InputDecoration(
                counterText: "",
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                helperText: helperText, //pass empty string to minimize textfield jump on error
                errorMaxLines: 2,
                border: OutlineInputBorder(
                  borderSide: boderColor!=null ? BorderSide(
                      color: boderColor ?? Colors.transparent,
                      width: 1
                  ) : BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: boderColor!=null ? BorderSide(
                    color:   ColorConstants.primaryColor,
                    width: 1
                  ) : BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: prefixIcon,
                errorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color:  Color.fromRGBO(118, 32, 135, 0.5), width: 1.0),
                ),
                focusedErrorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: const Color(0x80a81c1c), width: 1.0),
                ),
                // focusedErrorBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Color(0x80a81c1c),width: 1)
                // ),

                // suffixStyle: UiStyles.suffixStyle,
                suffixIcon: suffixIcon,


                contentPadding:
               EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                filled: true,

                fillColor: Colors.grey[200],
                errorStyle:   TextStyle(
                  color: Colors.red,

                ),
              ),
              maxLines: maxLines != null ? maxLines : 1,
              keyboardType: keyboardType,
              validator: validator,
              maxLength: maxCharacterLength,
              obscureText: obscureText ?? false,
              focusNode: focusNode,
              autocorrect: false,
              toolbarOptions: ToolbarOptions(
                  paste: true, cut: true, selectAll: true, copy: true),
              onFieldSubmitted: onFieldSubmitted,
              onSaved: onSaved,
              onChanged: onChanged,


            )
          ],
        ));
  }
}
