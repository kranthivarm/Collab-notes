import 'package:bloc_sm/themes/dark_mode.dart';
import 'package:bloc_sm/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  bool _isDarkMode = false;

  ThemeCubit() : super(darkMode);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = !_isDarkMode;
    prefs.setBool("isDarkMode", _isDarkMode);
    if(isDarkMode) {
      emit(darkMode);
    }
    else {
      emit(lightMode);
    }
  }


  // function to load themes when app starts
  void checkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("isDarkMode")==null){
      await prefs.setBool("isDarkMode", false);
    }
    if(prefs.getBool("isDarkMode")!) {
      _isDarkMode = true;
      emit(darkMode);
    }
    else {
      _isDarkMode = false;
      emit(lightMode);
    }
  }

}