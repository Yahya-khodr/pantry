import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:intl/intl.dart';

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? size;
  final DateTime? time;
  BasicDateField({
    Key? key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.size,
    this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
                ThemeData().colorScheme.copyWith(primary: Palette.appBarColor),
          ),
          child: DateTimeField(
            controller: controller,
            initialValue: time,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffix: suffixIcon,
              focusColor: Palette.appBarColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(color: Palette.appBarColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(color: Palette.appBarColor, width: 2.0)),
            ),
            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
            },
          ),
        ),
      ),
    ]);
  }
}
