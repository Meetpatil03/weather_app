import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/functions/handle_fetch_weather.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/provider_service.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/responsive/reponsive.dart';
import 'package:weather_app/widgets/alert_dialog_box.dart';
import 'package:weather_app/widgets/card_widget.dart';
import 'package:weather_app/widgets/custom_button.dart';
import 'package:weather_app/widgets/custom_text_field.dart';
import 'package:weather_app/widgets/glowy_text.dart';
import 'package:weather_app/widgets/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController cityNameController = TextEditingController();
  bool isLoading = false;
  bool showCard = false;
  String? weatherMain;
  String? weatherDescription;
  double? temperature;
  String? city;

  // Access Provider instance

  void setLoading(bool loading, bool show) {
    setState(() {
      isLoading = loading;
      showCard = show;
    });
  }

  setData(String main, String description, double temp, String cityName) {
    setState(() {
      weatherMain = main;
      weatherDescription = description;
      temperature = temp;
      city = cityName;
    });
  }

  void onHandleError() {
    print("Failed to fetch Data");
  }

  @override
  void initState() {
    super.initState();
    cityNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherListProvider = context.watch<WeatherList>().weatherList;
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
 Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return IconButton(
          onPressed: () {
            themeProvider.toggleThemeMode(); // No need to call setState
          },
          icon: Icon(
            themeProvider.themeMode == ThemeMode.dark
                ? Icons.wb_sunny  // Show sun icon for dark mode
                : Icons.nights_stay, // Show moon icon for light mode
            size: 40,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.yellow  // Color for sun (light mode)
                : Colors.blue,    // Color for moon (dark mode)
          ),
        );
      },
    ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Responsive(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   SizedBox(
                    height: size.height*0.05,
                   ),
                    const GlowyText(
                      fontSize: 50,
                      text: "Weather",
                      shadowColor: Colors.blue,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        "assets/gif-images/rain.gif",
                        width: 180,
                        height: 180,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: GlowyText(
                          fontSize: 25,
                          text: "What's the Weather !",
                          shadowColor: Colors.red),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child:
                                CustomTextField(controller: cityNameController)),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          controller: cityNameController,
                          fontSize: 18,
                          text: "Get",
                          onPressed: () async {
                            if (cityNameController.text.isNotEmpty) {
                              await handleFetchWeather(
                                  cityName: cityNameController.text,
                                  setLoading: setLoading,
                                  setData: setData,
                                  onError: onHandleError,
                                  context: context);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertBox(
                                      message:
                                          'Please-Enter-City Before you Press Tap Button',
                                    );
                                  });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    const Text(
                      "Recents Searched Cities!",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height:   150,
                        child: Column(
                          children: [
                            Expanded(
                              child: weatherListProvider.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: weatherListProvider.length,
                                      itemBuilder: (context, index) {
                                        WeatherModel weather =
                                            weatherListProvider[index];
                
                                        return Card(
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          shadowColor:
                                              Colors.grey.withOpacity(0.5),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                                backgroundColor: Colors.green,
                                                child: Text(
                                                  "${index + 1}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            title: Text(
                                              weather.cityName,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              "weather : ${weather.weatherMain} \n description : ${weather.weatherDescription}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        );
                                      })
                                  : const CardWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showCard) ...[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            Center(
              child: WeatherCard(
                isLoading: isLoading,
                onClose: () {
                  setState(() {
                    showCard = false;
                    weatherMain = null;
                    weatherDescription = null;
                    temperature = null;
                    city = null;
                  });
                },
                city: city,
                weatherMain: weatherDescription,
                weatherDescription: weatherDescription,
                temperature: temperature,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
