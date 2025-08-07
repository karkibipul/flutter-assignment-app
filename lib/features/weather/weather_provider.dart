import 'package:flutter/material.dart';
import 'model/weather_model.dart';
import 'repo/weather_repository.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherRepository _repo = WeatherRepository();

  Weather? _weather;
  bool _isLoading = false;
  String? _error;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _weather = await _repo.fetchWeather(city);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
