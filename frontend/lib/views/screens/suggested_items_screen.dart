import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/utils/suggestions.dart';
import 'package:frontend/views/widgets/suggested_card_wdiget.dart';

class SuggestedScreen extends StatefulWidget {
  const SuggestedScreen({Key? key}) : super(key: key);

  @override
  State<SuggestedScreen> createState() => _SuggestedScreenState();
}

class _SuggestedScreenState extends State<SuggestedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Items'),
        backgroundColor: Palette.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: suggestionsItems.length,
            itemBuilder: (BuildContext context, int index) {
              Map suggestions = suggestionsItems[index];
              return SuggestedCard(
                  image: AssetImage(suggestions['image']),
                  name: suggestions['name']);
            },
          ),
        ),
      ),
    );
  }
}
