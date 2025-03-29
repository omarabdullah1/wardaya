import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/core/blocs/general/cubit/general_state.dart';
import 'package:wardaya/core/helpers/shared_pref_helper.dart';

import '../../../networking/dio_factory.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralState.initial());
  String lang = 'en';
  Locale local = const Locale('en');

  /// Loads the saved language from SharedPreferences on startup.
  Future<void> loadLanguage() async {
    // You can choose to use a normal String method or the secured method.
    String lang = await SharedPrefHelper.getString('language_code');
    if (lang.isEmpty) {
      lang = 'en'; // Default to English if none is stored
    }
    this.lang = lang;
    local = Locale(lang);
    DioFactory.setLanguageParameter(lang);
    emit(GeneralState.changeLanguage(lang));
  }

  /// Changes the language, saves it to SharedPreferences, and updates the state.
  Future<void> changeLanguage(String languageCode) async {
    // Save the selected language. You can use setData or setSecuredString.
    await SharedPrefHelper.setData('language_code', languageCode);
    lang = languageCode;
    local = Locale(lang);

    DioFactory.setLanguageParameter(lang);
    // Emit the new state so the UI can rebuild with the new locale.
    emit(GeneralState.changeLanguage(languageCode));
  }
}
