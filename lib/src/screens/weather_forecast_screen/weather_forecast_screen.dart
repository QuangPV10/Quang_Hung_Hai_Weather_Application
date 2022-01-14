import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/city.dart';
import '../../widgets/day_temp_chart.dart';
import '../../widgets/refresh_button.dart';
import '../../blocs/current_weather_bloc/current_weather_bloc.dart';
import '../../blocs/current_weather_bloc/current_weather_event.dart';
import '../../blocs/current_weather_bloc/current_weather_state.dart';
import '../../blocs/week_forecast_weather_bloc/week_forecast_weather_bloc.dart';
import '../../blocs/week_forecast_weather_bloc/week_forecast_weather_event.dart';
import '../../blocs/week_forecast_weather_bloc/week_forecast_weather_state.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_string.dart';
import '../../constants/app_theme.dart';
import '../../helper/day_format.dart';
import '../../widgets/week_temp_chart.dart';
import '../../widgets/map.dart';

class WeatherForecastScreen extends StatefulWidget {
  final City city;

  const WeatherForecastScreen({required this.city, Key? key}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  City get _city => widget.city;
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

  Color colorOfChart = ColorsApp.maxTempChartColor.withOpacity(0.8);

  @override
  void initState() {
    super.initState();
    context.read<CurrentWeatherBloc>().add(
        CurrentWeatherRequested(lat: _city.latitude, lon: _city.longitude));
    context.read<WeekForeCastWeatherBloc>().add(WeekForeCastWeatherRequested(
        lat: _city.latitude, lon: _city.longitude));
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
        backgroundColor: backgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(left: paddingHorizontalOfTitle),
          child: SizedBox(
              height: heightOfLeadingLogoAppBar,
              width: widthOfLeadingLogoAppBar,
              child: Image.asset(AppAsset.logoCloud)),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              AppString.weatherForecast,
              style: titleAppBarStyle,
            ),
            Text(
              _city.name,
              style: subTitleAppBarStyle,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: paddingHorizontalOfTitle),
            child: SizedBox(
                height: heightOfActionLogoAppBar,
                width: widthOfActionLogoAppBar,
                child: Image.asset(AppAsset.logoSetting)),
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontalOfTitle,
                    vertical: paddingVerticalOfTitle),
                child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                    builder: (context, state) {
                  if (state is CurrentWeatherLoadSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.dayForecast,
                          style: titleOfForecast,
                        ),
                        Row(
                          children: [
                            Text(
                              CustomDateTimeFormat.unixTimeToDay(
                                      state.currentWeather.dateTime)
                                  .toString(),
                              style: titleOfForecast,
                            ),
                            SizedBox(
                              width: paddingOfDayAndMonth,
                            ),
                            Text(
                              CustomDateTimeFormat.unixTimeToMonth(
                                      state.currentWeather.dateTime)
                                  .toString(),
                              style: monthOfForecast,
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
              ),
              SizedBox(
                height: heightOfMapDayForecast,
                child: Stack(
                  children: [
                    MapWidget(
                      lat: _city.latitude,
                      lon: _city.longitude,
                    ),
                    BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                        builder: (context, state) {
                      if (state is CurrentWeatherLoadInProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CurrentWeatherLoadSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${state.currentWeather.temp.toInt()}${AppString.degrees}',
                              style: currentTemp,
                            ),
                            Text(
                              _city.name,
                              style: currentCity,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.currentWeather.weatherStatus.weather,
                                  style: currentWeather,
                                ),
                                Image.network(WeatherIcon(
                                        iconID: state.currentWeather
                                            .weatherStatus.weatherIcon)
                                    .weatherIcon)
                              ],
                            ),
                            SizedBox(
                              height: paddingChartWithListView,
                            ),
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
                                      Container(
                                          height: paddingBottomCity,
                                          color: Colors.white),
                                      Image.network(WeatherIcon(
                                              iconID: state
                                                  .currentWeather
                                                  .weatherHourlyAlerts[index]
                                                  .weather
                                                  .weatherIcon)
                                          .weatherIcon),
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
                              height: heightOfChart,
                              child: DayTempChart(
                                weather: state.currentWeather,
                                weatherTempAlert:
                                    state.currentWeather.weatherHourlyAlerts,
                                color: colorOfChart,
                              ),
                            )
                          ],
                        );
                      }
                      if (state is CurrentWeatherLoadFailure) {
                        return Center(
                          child: RefreshButton(onPressed: () {
                            context.read<CurrentWeatherBloc>().add(
                                CurrentWeatherRequested(
                                    lat: _city.latitude, lon: _city.longitude));
                          }),
                        );
                      }
                      return const SizedBox();
                    })
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontalOfTitle,
                    vertical: paddingVerticalOfTitle),
                child: Text(
                  AppString.weatherForecast,
                  style: titleOfForecast,
                ),
              ),
              SizedBox(
                height: heightOfMapWeekForecast,
                child: Stack(
                  children: [
                    MapWidget(
                      lat: _city.latitude,
                      lon: _city.longitude,
                    ),
                    BlocBuilder<WeekForeCastWeatherBloc,
                        WeekForeCastWeatherState>(
                      builder: (context, state) {
                        if (state is WeekForeCastWeatherLoadSuccess) {
                          return Padding(
                            padding:
                                EdgeInsets.only(top: paddingTopOfWeekForecast),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: state.weekForeCastWeather
                                        .listWeekWeather.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Text(
                                            CustomDateTimeFormat.unixTimeToWeek(
                                                    state
                                                        .weekForeCastWeather
                                                        .listWeekWeather[index]
                                                        .dateTime
                                                        .toInt())
                                                .toUpperCase(),
                                            style: dateTime,
                                          ),
                                          Image.network(WeatherIcon(
                                                  iconID: state
                                                      .weekForeCastWeather
                                                      .listWeekWeather[index]
                                                      .weather
                                                      .weatherIcon)
                                              .weatherIcon),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Align(
                                        alignment: Alignment.topRight,
                                        child: SizedBox(
                                            width: screenWidth /
                                                state.weekForeCastWeather
                                                    .listWeekWeather.length),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: WeekTempChart(
                                        item: state.weekForeCastWeather
                                            .listWeekWeather)),
                              ],
                            ),
                          );
                        }
                        if (state is WeekForeCastWeatherLoadFailure) {
                          return Center(
                            child: RefreshButton(
                              onPressed: () {
                                context.read<WeekForeCastWeatherBloc>().add(
                                    WeekForeCastWeatherRequested(
                                        lat: _city.latitude,
                                        lon: _city.longitude));
                              },
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
