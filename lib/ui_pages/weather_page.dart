// ignore_for_file: non_constant_identifier_names

//ADD CLOUDS!!!

import 'package:flutter/material.dart';

import 'package:weather/weather.dart';
import 'package:weather_app/static/constatns_theme.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final COLOR_PRIMARY = Colors.white;
  final COLOR_SECONDARY = const Color.fromARGB(121, 212, 165, 238);
  bool tempIsCelsius = true;

  final WeatherFactory _weaterFactory = WeatherFactory(OPENWEATHER_API_KEY);
  late Weather? _todayWeather;
  List<Weather?>? _weather;
  @override
  void initState() {
    super.initState();
    setCityLocation("Moscow");
    //
  }

  void setCityLocation(String cityName) {
    _weaterFactory.fiveDayForecastByCityName(cityName).then((onValue) {
      setState(() {
        _weather = onValue;
        _todayWeather = _weather?[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_weather == null) {
      return Container(
        child: loadingWidget,
      );
    }
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          rowCityData,
          _cloud_and_wind_Row,
          dividerHorizontal,
          _dateData(),
          //dividerHorizontal,
          _addInformation(),
          //dividerHorizontal,
          _sunMove,
          dividerHorizontal,
          Flexible(child: _buildWeekWeatherList)
        ],
      ),
    );
  }

  Widget get loadingWidget {
    return Center(
      child: CircularProgressIndicator(
        color: COLOR_PRIMARY,
      ),
    );
  }

  Widget get dividerHorizontal {
    return Divider(
      color: COLOR_PRIMARY,
    );
  }

  Widget get rowCityData {
    return Row(children: [
      TextButton.icon(
          icon: Icon(
            Icons.location_on_rounded,
            color: COLOR_PRIMARY,
          ),
          onPressed: () {},
          label: Text(
            "${_todayWeather?.country}, ${_todayWeather?.areaName ?? ""}",
            style: _defaultTextStyle(),
          )),
    ]);
  }

  TextStyle _defaultTextStyle({double defaultFontSize = 22.0}) {
    return TextStyle(color: COLOR_PRIMARY, fontSize: defaultFontSize);
  }

  Widget get _cloud_and_wind_Row {
    return SizedBox(
      height: 300.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(child: _weatherIcon_temp_Column()),
          Flexible(child: _windColumn())
        ],
      ),
    );
  }

  Widget _weatherIcon_temp_Column() {
    return Column(
      children: [
        //Weather Icon
        // Icon(
        //   Icons.cloud,
        //   size: 150.0,
        //   color: COLOR_PRIMARY,
        // ),
        //Weather Image
        Container(
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "$URL_WEATHER_ICONS${_todayWeather?.weatherIcon}@4x.png"))),
        ),
        //Temp Actully
        Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tempIsCelsius
                    ? "${_todayWeather?.temperature?.celsius?.toStringAsFixed(0)}°С "
                    : "${_todayWeather?.temperature?.fahrenheit?.toStringAsFixed(0)}°F",
                style: _defaultTextStyle(defaultFontSize: 80),
              ),
              // dividerHorizontal,
              //Temp Feels Like
              Text(
                tempIsCelsius
                    ? "${_todayWeather?.tempFeelsLike?.celsius?.toStringAsFixed(0)}°С "
                    : "${_todayWeather?.tempFeelsLike?.fahrenheit?.toStringAsFixed(0)}°F",
                style: _defaultTextStyle(defaultFontSize: 24),
              )
            ]),
      ],
    );
  }

  Widget _windColumn() {
    return Column(
      children: [
        Flexible(
          child: Card(
            shape: _cardShape,
            color: COLOR_SECONDARY,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.wind_power_rounded,
                    color: COLOR_PRIMARY,
                    size: 100.0,
                  ),
                  Divider(
                    color: COLOR_PRIMARY,
                  ),
                  Text(
                    "${_todayWeather?.windSpeed?.toStringAsFixed(2)} м/с",
                    style: _defaultTextStyle(defaultFontSize: 30),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _dateData() {
    return Card(
      shape: _cardShape,
      color: COLOR_SECONDARY,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range_rounded,
                  size: 35,
                  color: COLOR_PRIMARY,
                ),
                Text(
                  "${_todayWeather?.date?.day}  ${MOUNTHS_NAME[_todayWeather?.date?.month ?? 0]} ${_todayWeather?.date?.year}",
                  style: _defaultTextStyle(defaultFontSize: 25),
                )
              ],
            ),
            Row(
              //Time
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row(
                //   children: [
                //     Icon(
                //       Icons.access_time_filled_rounded,
                //       size: 35,
                //       color: COLOR_PRIMARY,
                //     ),
                //     Text(
                //       "${_todayWeather?.date?.hour}:${_todayWeather?.date?.minute}",
                //       style: _defaultTextStyle(defaultFontSize: 35),
                //     ),
                //   ],
                // ),

                Divider(
                  thickness: 1.0,
                  color: COLOR_PRIMARY,
                ),
                Row(
                  //WeekDay
                  children: [
                    Icon(
                      Icons.today_rounded,
                      size: 35,
                      color: COLOR_PRIMARY,
                    ),
                    Text(
                      WEEKEDAYS[_todayWeather?.date?.weekday ?? 0],
                      style: _defaultTextStyle(defaultFontSize: 25),
                    )
                  ],
                )

                // Text(
                //   "Понедельник",
                //   style: _defaultTextStyle(defaultFontSize: 35),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _addInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_tempCard, _humidity_CloudnessCard],
    );
  }

  Widget get _tempCard {
    return Card(
      shape: _cardShape,
      color: COLOR_SECONDARY,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _maxTempRow,
            //Flexible(child: dividerHorizontal),
            _minTempRow
          ],
        ),
      ),
    );
  }

  RoundedRectangleBorder get _cardShape {
    return RoundedRectangleBorder(
        side: BorderSide(color: COLOR_PRIMARY),
        borderRadius: BorderRadius.circular(12));
  }

  Widget get _humidity_CloudnessCard {
    return Card(
        shape: _cardShape,
        color: COLOR_SECONDARY,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                Icon(
                  Icons.water_drop_rounded,
                  color: COLOR_PRIMARY,
                ),
                Text(
                  "Влажность ${_getHumidity()}%",
                  style: _defaultTextStyle(defaultFontSize: 16),
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.cloud_sharp,
                  color: COLOR_PRIMARY,
                ),
                Text(
                  "Облачность ${_getCloudness()}%",
                  style: _defaultTextStyle(defaultFontSize: 16),
                )
              ],
            ),
          ]),
        ));
  }

  Widget get _maxTempRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.thermostat_rounded,
          color: COLOR_PRIMARY,
        ),
        Text(
          "Макс. темп.: ${_getMaxTemp()}",
          style: _defaultTextStyle(defaultFontSize: 16),
        )
      ],
    );
  }

  Widget get _minTempRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.thermostat_rounded,
          color: COLOR_PRIMARY,
        ),
        Text(
          "Мин. темп.: ${_getMinTemp()}",
          style: _defaultTextStyle(defaultFontSize: 16),
        )
      ],
    );
  }

  String? _getMaxTemp() {
    if (tempIsCelsius) {
      return _todayWeather?.tempMax?.celsius?.toStringAsFixed(0);
    }
    return _todayWeather?.tempMax?.fahrenheit?.toStringAsFixed(0);
  }

  String? _getMinTemp() {
    if (tempIsCelsius) {
      return _todayWeather?.tempMin?.celsius?.toStringAsFixed(0);
    }
    return _todayWeather?.tempMin?.fahrenheit?.toStringAsFixed(0);
  }

  String? _getHumidity() {
    return _todayWeather?.humidity?.toStringAsFixed(0);
  }

  String? _getCloudness() {
    return _todayWeather?.cloudiness?.toStringAsFixed(0);
  }

  Widget get _sunMove {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _sunMoveCard(
            "Восход",
            "${_todayWeather?.sunrise?.hour}:${_todayWeather?.sunrise?.minute}",
            0),
        _sunMoveCard(
            "Закат",
            "${_todayWeather?.sunset?.hour}:${_todayWeather?.sunset?.minute}",
            1),
      ],
    );
  }

  Widget _sunMoveCard(
      String sunMoveName, String sunMoveTime, int sunMoveIconType) {
    var sunMoveIcons = [
      Image.asset(
        "assets/images/sunrise.png",
        color: COLOR_PRIMARY,
        height: 50,
      ),
      Image.asset(
        "assets/images/sunset.png",
        color: COLOR_PRIMARY,
        height: 50,
      )
    ];
    return SizedBox(
      width: 170,
      height: 90,
      child: Card(
        shape: _cardShape,
        color: COLOR_SECONDARY,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              sunMoveIcons[sunMoveIconType],
              // Icon(
              //   sunMoveIcons[sunMoveIconType],
              //   color: COLOR_PRIMARY,
              //   size: 50,
              // ),
              Column(
                children: [
                  Text(
                    sunMoveName,
                    style: _defaultTextStyle(defaultFontSize: 20),
                  ),
                  Text(sunMoveTime,
                      style: _defaultTextStyle(defaultFontSize: 20))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _weekDayCard(int weekdayWeather_) {
    weekdayWeather_++;
    final weekdayWeater = _weather?[weekdayWeather_];
    DateTime? _weekdayWeatherDate = _todayWeather?.date;
    _weekdayWeatherDate =
        _weekdayWeatherDate?.add(Duration(days: weekdayWeather_));

    return SizedBox(
      height: 170,
      width: 90,
      child: Card(
        shape: _cardShape,
        color: COLOR_SECONDARY,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "$URL_WEATHER_ICONS${weekdayWeater?.weatherIcon}@4x.png"))),
              ),
              //dividerHorizontal,
              //TEXT MAIN
              Column(
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thermostat,
                          color: COLOR_PRIMARY,
                          size: 20,
                        ),
                        Text(
                          tempIsCelsius
                              ? "${weekdayWeater?.temperature?.celsius?.toStringAsFixed(0)}°С "
                              : "${weekdayWeater?.temperature?.fahrenheit?.toStringAsFixed(0)}°F",
                          style: _defaultTextStyle(defaultFontSize: 20),
                        ),
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wind_power_rounded,
                          color: COLOR_PRIMARY,
                          size: 15,
                        ),
                        Text(
                          "${weekdayWeater?.windSpeed} м/с",
                          style: _defaultTextStyle(defaultFontSize: 12),
                        ),
                      ]),
                ],
              ),
              dividerHorizontal,
              Column(
                children: [
                  Text(
                    "${_weekdayWeatherDate?.day}.${_weekdayWeatherDate?.month}.${_weekdayWeatherDate?.year}",
                    style: _defaultTextStyle(defaultFontSize: 14),
                  ),
                  Text(WEEKEDAYS[_weekdayWeatherDate?.weekday ?? 0],
                      style: _defaultTextStyle(defaultFontSize: 10))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildWeekWeatherList {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      padding: const EdgeInsets.all(4.0),
      itemBuilder: (BuildContext context, int i) {
        return _weekDayCard(i);
      },
    );
  }
}

// ignore: must_be_immutable
class WeatherCard extends Card {
  WeatherCard({super.key, required child_});

  Widget? child_;
  final COLOR_PRIMARY = const Color.fromARGB(121, 212, 165, 238);

  @override
  // TODO: implement color
  Color? get color => COLOR_PRIMARY;
  @override
  // TODO: implement shape
  ShapeBorder? get shape => RoundedRectangleBorder(
      side: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(12));

  @override
  // TODO: implement child
  Widget? get child => child_;
}
