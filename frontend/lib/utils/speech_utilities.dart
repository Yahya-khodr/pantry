import 'package:flutter/material.dart';
import 'package:frontend/views/screens/main_screens/search_screen.dart';

class Command {
  static final all = [search, scan, shop];

  static const search = 'search';
  static const scan = 'open scan';
  static const shop = 'shop';
}

class SearchUtitlities {
  static Future<void> scanText(BuildContext context, String rawText) async {
    final text = rawText.toLowerCase();

    if (text.contains(Command.search)) {
      final body = _getTextAfterCommand(text: text, command: Command.search);

      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => SearchScreen(body: body)));
    }
  }

  static String _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return '';
    } else {
      return text.substring(indexAfter).trim();
    }
  }
}
