import 'package:flutter/material.dart';
import 'package:weather_app/static/constatns_theme.dart';

class CityChangePage extends StatefulWidget {
  const CityChangePage({super.key});

  @override
  State<CityChangePage> createState() => _CityChangePageState();
}

class _CityChangePageState extends State<CityChangePage> {
  final Color COLOR_PRIMARY = Colors.white;
  final TextStyle _defTextStyle = TextStyle(fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: COLOR_PRIMARY,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, top: 24.0, right: 12.0, bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [cityTextFiled, Divider(), Expanded(child: _buildCityList)],
        ),
      ),
    );
  }

  Widget get cityTextFiled {
    return TextField(
      style: _defTextStyle,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        hintText: "Город",
        icon: const Icon(
          Icons.search_rounded,
          size: 34,
        ),
      ),
    );
  }

  Column _cityListTile(int cityID) {
    return Column(children: [
      ListTile(
        title: Text(
          "${CITY_LIST[cityID]}",
          style: _defTextStyle,
        ),
      ),
      const Divider()
    ]);
  }

  Widget get _buildCityList {
    return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: CITY_LIST.length,
        itemBuilder: (BuildContext context, int i) {
          return _cityListTile(i);
        });
  }
}
