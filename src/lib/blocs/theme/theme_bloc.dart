/* import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeMode.light));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    print(event);
    if (event is ThemeLoadStarted) {
      yield* _mapThemeLoadStartedToState();
    } else if (event is ThemeChanged) {
      yield* _mapThemeChangedToState(event.value);
    } else if (event is FirstLaunchChanged) {
      yield* _mapFirstLaunchChangedToState(event.value);
    }
  }

  Stream<ThemeState> _mapThemeLoadStartedToState() async* {
    final sharedPrefService = await SharedPreferences.getInstance();
    final isDarkModeEnabled = sharedPrefService.isDarkModeEnabled;

    if (isDarkModeEnabled == null) {
      sharedPrefService.setDarkModeInfo(false);
      yield ThemeState(ThemeMode.light);
    } else {
      ThemeMode themeMode =
      isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;
      yield ThemeState(themeMode);
    }
  }


  Stream<ThemeState> _mapFirstLaunchChangedToState(bool value) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    await sharedPrefService.setIsFirstLaunchInfo(false);
  }

  Stream<ThemeState> _mapThemeChangedToState(bool value) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    final isDarkModeEnabled = sharedPrefService.isDarkModeEnabled;

    if (value && !isDarkModeEnabled) {
      await sharedPrefService.setDarkModeInfo(true);
      yield ThemeState(ThemeMode.dark);
    } else if (!value && isDarkModeEnabled) {
      await sharedPrefService.setDarkModeInfo(false);
      yield ThemeState(ThemeMode.light);
    }
  }
} */