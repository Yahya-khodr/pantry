import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/views/widgets/custom_text_input_widget.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';

class UpdateProfileInfo extends StatefulWidget {
  const UpdateProfileInfo({Key? key}) : super(key: key);

  @override
  State<UpdateProfileInfo> createState() => _UpdateProfileInfoState();
}

class _UpdateProfileInfoState extends State<UpdateProfileInfo> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> genders = ['Male', 'Female', 'Other'];
    String? selectedGender = 'Male';
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20.0,
          ),
          CustomTextField(
            prefixIcon: const Icon( Icons.line_weight),
            controller: _weightController,
            labelText: "Weight",
            suffixText: "kg",
            keyboardType: TextInputType.number,
            size: size.width / 3,
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextField(
            prefixIcon: const Icon( Icons.height),
            controller: _heightController,
            labelText: "Height",
            suffixText: "cm",
            keyboardType: TextInputType.number,
            size: size.width * 0.4,
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextField(
            controller: _birthDateController,
            labelText: "Birth Date",
            suffixIcon: IconButton(
                onPressed: () {}, icon: const Icon(Icons.date_range)),
            keyboardType: TextInputType.datetime,
            size: size.width * 0.5,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: size.width / 3,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ThemeData()
                    .colorScheme
                    .copyWith(primary: Palette.appBarColor),
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: Palette.appBarColor, width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: Palette.appBarColor, width: 2.0)),
                ),
                value: selectedGender,
                items: genders
                    .map((gender) => DropdownMenuItem<String>(
                        value: gender,
                        child: Text(
                          gender,
                        )))
                    .toList(),
                onChanged: (gender) => setState(
                  () {
                    selectedGender = gender;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            width: size.width * 0.3,
            child: RoundedButton(
              text: "Save",
              onPressed: () {},
              width: size.width * 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
