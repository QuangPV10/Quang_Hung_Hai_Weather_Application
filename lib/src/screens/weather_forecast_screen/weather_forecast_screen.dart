import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/custom_app_bar.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/load_fail_widget.dart';

import '../../injection_container.dart';
import '../../models/city.dart';
import '../../widgets/day_temp_chart.dart';
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
  final _currentWeatherBloc =
      AppDependencies.injector.get<CurrentWeatherBloc>();
  final _weekWeatherBloc =
      AppDependencies.injector.get<WeekForeCastWeatherBloc>();
  final double _heightOfLeadingLogoAppBar = 48.0;

  final double _heightOfActionLogoAppBar = 30.0;

  final double _heightOfMapDayForecast = 500.0;

  final double _heightOfMapWeekForecast = 150.0;

  final double _heightOfChart = 80.0;

  final double _widthOfLeadingLogoAppBar = 50.0;

  final double _widthOfActionLogoAppBar = 30.0;

  final double _paddingHorizontalOfTitle = 28.0;

  final double _paddingVerticalOfTitle = 20.0;

  final double _paddingOfDayAndMonth = 10.0;

  final double _paddingChartWithListView = 100.0;

  final double _paddingTopOfWeekForecast = 20.0;

  final double _paddingBottomCity = 30.0;

  final Color _backgroundColor = ColorsApp.backgroundColor;

  final Color _colorOfChart = ColorsApp.maxTempChartColor.withOpacity(0.8);

  @override
  void initState() {
    super.initState();
    AppDependencies.injector.get<CurrentWeatherBloc>().add(
          CurrentWeatherRequested(lat: _city.latitude, lon: _city.longitude),
        );
    AppDependencies.injector.get<WeekForeCastWeatherBloc>().add(
          WeekForeCastWeatherRequested(
              lat: _city.latitude, lon: _city.longitude),
        );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
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
      appBar: CustomAppBar(
        widgetLeading: Padding(
          padding: EdgeInsets.only(left: _paddingHorizontalOfTitle),
          child: SizedBox(
              height: _heightOfLeadingLogoAppBar,
              width: _widthOfLeadingLogoAppBar,
              child: Image.asset(AppAsset.logoCloud)),
        ),
        title: AppString.weatherForecast,
        subtitle: _city.name,
        actionWidget: [
          Padding(
              padding: EdgeInsets.only(right: _paddingHorizontalOfTitle),
              child: SizedBox(
                  height: _heightOfActionLogoAppBar,
                  width: _widthOfActionLogoAppBar,
                  child: Image.asset(AppAsset.logoSetting))),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: _backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _paddingHorizontalOfTitle,
                    vertical: _paddingVerticalOfTitle),
                child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                    bloc: _currentWeatherBloc,
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
                                  width: _paddingOfDayAndMonth,
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
                height: _heightOfMapDayForecast,
                child: Stack(
                  children: [
                    MapWidget(
                      lat: _city.latitude,
                      lon: _city.longitude,
                    ),
                    BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                        bloc: _currentWeatherBloc,
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
                                      state
                                          .currentWeather.weatherStatus.weather,
                                      style: currentWeather,
                                    ),
                                    Image.network(WeatherIcon(
                                            iconID: state.currentWeather
                                                .weatherStatus.weatherIcon)
                                        .weatherIcon)
                                  ],
                                ),
                                SizedBox(
                                  height: _paddingChartWithListView,
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
                                            CustomDateTimeFormat
                                                .unixTimeToHourUTC(state
                                                    .currentWeather
                                                    .weatherHourlyAlerts[index]
                                                    .datetime),
                                            style: dateTime,
                                          ),
                                          Container(
                                              height: _paddingBottomCity,
                                              color: Colors.white),
                                          Image.network(WeatherIcon(
                                                  iconID: state
                                                      .currentWeather
                                                      .weatherHourlyAlerts[
                                                          index]
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
                                  height: _heightOfChart,
                                  child: DayTempChart(
                                    weather: state.currentWeather,
                                    weatherTempAlert: state
                                        .currentWeather.weatherHourlyAlerts,
                                    color: _colorOfChart,
                                  ),
                                )
                              ],
                            );
                          }
                          if (state is CurrentWeatherLoadFailure) {
                            return Center(
                              child: LoadFailWidget(
                                reload: () {
                                  context.read<CurrentWeatherBloc>().add(
                                      CurrentWeatherRequested(
                                          lat: _city.latitude,
                                          lon: _city.longitude));
                                },
                                title: AppString.loadFailureText,
                              ),
                            );
                          }
                          return const SizedBox();
                        })
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _paddingHorizontalOfTitle,
                    vertical: _paddingVerticalOfTitle),
                child: Text(
                  AppString.weatherForecast,
                  style: titleOfForecast,
                ),
              ),
              SizedBox(
                height: _heightOfMapWeekForecast,
                child: Stack(
                  children: [
                    MapWidget(
                      lat: _city.latitude,
                      lon: _city.longitude,
                    ),
                    BlocBuilder<WeekForeCastWeatherBloc,
                        WeekForeCastWeatherState>(
                      bloc: _weekWeatherBloc,
                      builder: (context, state) {
                        if (state is WeekForeCastWeatherLoadSuccess) {
                          return Padding(
                            padding:
                                EdgeInsets.only(top: _paddingTopOfWeekForecast),
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
                            child: LoadFailWidget(
                              reload: () {
                                context.read<WeekForeCastWeatherBloc>().add(
                                    WeekForeCastWeatherRequested(
                                        lat: _city.latitude,
                                        lon: _city.longitude));
                              },
                              title: AppString.loadFailureText,
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
