import 'package:chumaki/app_preferences.dart';
import 'package:flutter/material.dart';

class LocaleSelection extends StatefulWidget {
  final Function(Locale locale) onLocaleChanged;
  final Locale locale;

  LocaleSelection({required this.locale, required this.onLocaleChanged});

  @override
  _LocaleSelectionState createState() => _LocaleSelectionState();
}

class _LocaleSelectionState extends State<LocaleSelection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          value: 'uk',
          groupValue: widget.locale.languageCode,
          onChanged: _setNewLocale,
        ),
        Text('🇺🇦'),
        Radio(
          value: 'en',
          groupValue: widget.locale.languageCode,
          onChanged: _setNewLocale,
        ),
        Text('🇺🇸'),
        Radio(
          value: 'ru',
          groupValue: widget.locale.languageCode,
          onChanged: _setNewLocale,
        ),
        Text('Rus'),
      ],
    );
  }

  void _setNewLocale(String? newValue) async {
    try {
      await AppPreferences.instance.setUILanguage(newValue!);
    } catch (e) {
      print('Error saving new ui language to app preferences.');
    }
    widget.onLocaleChanged(Locale(newValue!));
  }
}
