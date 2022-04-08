import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/speech_to_text_service.dart';
import 'package:frontend/utils/speech_utilities.dart';
import 'package:frontend/views/screens/main_screens/search_screen.dart';
import 'package:frontend/views/widgets/substring_highlight_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  String text = 'Press the button and start speaking';
  bool _isListening = false;
  stt.SpeechToText _speech = SpeechToText();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Palette.appBarColor,
        title: const Text('Voice Search'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30).copyWith(bottom: 150),
        child: SubstringHighlight(
          text: text,
          terms: Command.all,
          textStyle: const TextStyle(
            fontSize: 32.0,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textStyleHighlight: const TextStyle(
            fontSize: 32.0,
            color: Palette.appBarColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        endRadius: 75,
        glowColor: Palette.appBarColor,
        duration: const Duration(milliseconds: 2000),
        child: FloatingActionButton(
            backgroundColor: Palette.appBarColor,
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              size: 30,
            ),
            onPressed: toggleRecording),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future toggleRecording() => SpeechService.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() {
            _isListening = isListening;
            print(isListening.toString());
          });

          if (!isListening) {
            Future.delayed(const Duration(seconds: 1), () async {
              SearchUtitlities.scanText(context, text);
            });
          }
        },
      );
}
