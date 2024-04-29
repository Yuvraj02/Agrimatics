import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageProvider extends ChangeNotifier{

  bool languageChange = false;

  Future<void> translate(String text, String languageCode) async {
    final translator = GoogleTranslator();

    final translation = await translator
        .translate("$text", from: 'en', to: languageCode);

    print("Translation is : $translation");
  }

}