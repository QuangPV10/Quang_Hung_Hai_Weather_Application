import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_state.dart';
import 'package:quang_hung_hai_weather_application/src/constants/app_assets.dart';
import 'package:quang_hung_hai_weather_application/src/constants/app_colors.dart';
import 'package:quang_hung_hai_weather_application/src/constants/app_string.dart';
import 'package:quang_hung_hai_weather_application/src/constants/app_theme.dart';
import 'package:quang_hung_hai_weather_application/src/constants/routes_name.dart';
import 'package:quang_hung_hai_weather_application/src/helper/day_format.dart';
import 'package:quang_hung_hai_weather_application/src/models/city.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/day_temp_chart.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/map.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  City defaultCity =
      City(name: "Hồ Chí Minh", longitude: 106.6667, latitude: 10.75);
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

  Color colorOfChart = ColorsApp.tempMinChartColor.withOpacity(0.8);
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

    TextStyle titleOfForecast = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.regular,
        fontSize: 18,
        color: Colors.white);

    TextStyle monthOfForecast = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.regular,
        fontSize: 18,
        color: ColorsApp.secondaryTextColor);

    TextStyle currentTemp = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.thin,
        fontSize: 100,
        color: Colors.white);

    TextStyle currentCity = _theme.textTheme.bodyText1!.copyWith(
        fontWeight: AppFontWeight.regular, fontSize: 38, color: Colors.white);

    TextStyle currentWeather = _theme.textTheme.bodyText2!.copyWith(
        fontFamily: AppFont.fontHelveticaNeue,
        fontWeight: AppFontWeight.regular,
        fontSize: 20,
        color: Colors.white);

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
                                  CustomDateTimeFormat.unixTimeToHourUTC(
                                      state
                                          .currentWeather
                                          .weatherHourlyAlerts[index]
                                          .datetime),
                                  style: dateTime,
                                ),
                              ],
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: screenWidth /
                                    (25 -
                                        CustomDateTimeFormat
                                            .unixTimeToHour(state
                                            .currentWeather
                                            .dateTime)),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: DayTempChart(
                          weatherTempAlert: state.currentWeather.weatherHourlyAlerts,
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
