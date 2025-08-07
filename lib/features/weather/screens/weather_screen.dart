import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../weather_provider.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _controller = TextEditingController();

  void _searchWeather() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      context.read<WeatherProvider>().fetchWeather(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(WeatherIcons.day_sunny, size: 24),
      SizedBox(width: 8),
      Text('Weather App'),
    ],
  ),
  centerTitle: true,
  backgroundColor: Colors.blue[400],
  elevation: 0,
),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (_) => _searchWeather(),
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                hintText: 'e.g. Kathmandu',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final city = _controller.text.trim();
                    if (city.isNotEmpty) {
                      provider.fetchWeather(city);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),

            if (provider.isLoading)
              const CircularProgressIndicator()
            else if (provider.error != null)
              Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.red),
              )
            else if (provider.weather != null)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        provider.weather!.cityName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      BoxedIcon(
                        WeatherIcons.day_cloudy,
                        size: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${provider.weather!.temperature}°C',
                        style: const TextStyle(fontSize: 42),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        provider.weather!.description.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
