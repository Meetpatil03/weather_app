import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WeatherCard extends StatelessWidget {
  final bool isLoading;
  final String? city;
  final String? weatherMain;
  final String? weatherDescription;
  final double? temperature;
  final VoidCallback onClose;

  const WeatherCard(
      {super.key,
      required this.isLoading,
      required this.city,
      required this.weatherMain,
      required this.weatherDescription,
      required this.temperature,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: List.generate(4, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                width: double.infinity,
                                height: 12.0,
                                color: Colors.white,
                              ),
                            );
                          }),
                        )),
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      city != null ? "City : $city" : "",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                          softWrap: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      weatherMain != null
                          ? "Weather Type: $weatherMain"
                          : 'Wrong-City-Name-Entered',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                          softWrap: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      weatherDescription != null
                          ? "Weather Description: $weatherDescription"
                          : "",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                          softWrap: true,

                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      temperature != null ? 'Temperature : $temperature °F' : '',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                          softWrap: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: onClose,
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
