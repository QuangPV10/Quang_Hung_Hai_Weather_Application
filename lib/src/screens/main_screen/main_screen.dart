import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/current_weather_bloc/current_weather_bloc.dart';
import '../../blocs/current_weather_bloc/current_weather_event.dart';
import '../../blocs/current_weather_bloc/current_weather_state.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_string.dart';
import '../../constants/app_theme.dart';
import '../../constants/routes_name.dart';
import '../../helper/day_format.dart';
import '../../models/city.dart';
import '../../widgets/day_temp_chart.dart';
import '../../widgets/map.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  City defaultCity =
      const City(name: "Hồ Chí Minh", longitude: 106.6667, latitude: 10.75);
  double heightOfLeadingLogoAppBar = 48;

  double heightOfActionLogoAppBar = 30;

  double heightOfMapDayForecast = 500;

  double heightOfMapWeekForecast = 150;

  double heightOfChart = 80;

  double widthOfLeadingLogoAppBar = 50;

  double widthOfActionLogoAppBar = 30;

  double paddingHorizontalOfTitle = 28;

  double paddingVerticalOfTitle = 20;

  double paddingOfDayAndMonth = 10;

  double paddingChartWithListView = 100;

  double paddingTopOfWeekForecast = 20;

  double paddingBottomCity = 30;

  Color backgroundColor = ColorsApp.backgroundColor;

  Color colorOfChart = ColorsApp.chartColor.withOpacity(0.8);
  @override
  void initState() {
    super.initState();
    context.read<CurrentWeatherBloc>().add(
          CurrentWeatherRequested(
              lat: defaultCity.latitude, lon: defaultCity.longitude),
        );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    TextStyle titleAppBarStyle = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.light,
        fontSize: 18,
        color: Colors.white);

    TextStyle subTitleAppBarStyle = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.light,
        fontSize: 18,
        color: ColorsApp.secondaryTextColor);

    TextStyle dateTime = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.thin,
        fontSize: 13,
        color: Colors.white.withOpacity(1));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.primaryBackgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(left: paddingHorizontalOfTitle),
          child: SizedBox(
              height: heightOfLeadingLogoAppBar,
              width: widthOfLeadingLogoAppBar,
              child: Image.asset(AppAsset.logoCloud)),
        ),
        toolbarHeight: 50,
        title: Center(
          child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
            builder: (context, state) {
              if (state is CurrentWeatherLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CurrentWeatherLoadSuccess) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.location,
                            arguments: defaultCity.name)
                        .then((result) {
                      if (result != null) {
                        City city = result as City;
                        setState(() {
                          defaultCity = city;
                        });
                        context.read<CurrentWeatherBloc>().add(
                            CurrentWeatherRequested(
                                lon: city.longitude, lat: city.latitude));
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        defaultCity.name,
                        style: titleAppBarStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.currentWeather.weatherStatus.weather,
                              style: subTitleAppBarStyle),
                          const SizedBox(width: 5),
                          Text(
                              '${state.currentWeather.temp.toInt().toString()}${AppString.degrees}',
                              style: subTitleAppBarStyle),
                        ],
                      )
                    ],
                  ),
                );
              }
              if (state is CurrentWeatherLoadFailure) {
                return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                );
              }
              return Container(
                color: Colors.orange,
              );
            },
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.weatherForecast,
                    arguments: defaultCity);
              },
              icon: Image.asset(AppAsset.logoSetting)),
        ],
      ),
      body: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, state) {
          if (state is CurrentWeatherLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CurrentWeatherLoadSuccess) {
            return Stack(
              children: [
                MapWidget(
                    lat: defaultCity.latitude, lon: defaultCity.longitude),
                SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: 25 -
                              CustomDateTimeFormat.unixTimeToHour(
                                  state.currentWeather.dateTime),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(
                                  CustomDateTimeFormat.unixTimeToHourUTC(state
                                      .currentWeather
                                      .weatherHourlyAlerts[index]
                                      .datetime),
                                  style: dateTime,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: screenWidth /
                                    (25 -
                                        CustomDateTimeFormat.unixTimeToHour(
                                            state.currentWeather.dateTime)),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: DayTempChart(
                          weatherTempAlert:
                              state.currentWeather.weatherHourlyAlerts,
                          weather: state.currentWeather,
                          color: colorOfChart,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          if (state is CurrentWeatherLoadFailure) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
            );
          }
          return Container(
            color: Colors.orange,
          );
        },
      ),
    );
  }
}
