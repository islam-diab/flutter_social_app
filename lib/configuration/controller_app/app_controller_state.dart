import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppControllerState extends Equatable {
  const AppControllerState({
    this.brightness = Brightness.light,
    this.language = const Locale('en'),
  });
  final Brightness brightness;
  final Locale language;

  AppControllerState copyWith({
    Brightness? brightness,
    Locale? language,
  }) =>
      AppControllerState(
        brightness: brightness ?? this.brightness,
        language: language ?? this.language,
      );
  @override
  List<Object> get props => [
        brightness,
        language,
      ];
}
