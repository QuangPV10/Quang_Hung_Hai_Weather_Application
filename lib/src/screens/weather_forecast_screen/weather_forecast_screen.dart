import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/current_weather_bloc/current_weather_bloc.dart';
import '../../blocs/current_weather_bloc/current_weather_event.dart';
import '../../blocs/current_weather_bloc/current_weather_state.dart';
import '../../blocs/week_forecast_weather_bloc/week_forecast_weather_bloc.dart';
import '../../blocs/week_forecast_weather_bloc/week_forecast_weather_event.dart';
import '../../blocs/week_forecast_weather_bloc/week_forecast_weather_state.dart';
import '../../constants/app_assets.dart';
import '../../dependencies/app_dependentcies.dart';
import '../../helper/day_format.dart';
import '../../models/city.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/day_temp_chart.dart';
import '../../widgets/load_fail_widget.dart';
import '../../widgets/map.dart';
import '../../widgets/week_temp_chart.dart';

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
  final double _heightOfLeadingLogoAppBar = 50.0;

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

  final Color _backgroundColor = AppColors.backgroundColor;

  final Color _colorOfChart = AppColors.maxTempChartColor.withOpacity(0.8);

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
    double screenWidth = MediaQuery.of(context).size.width;
    TextStyle _titleOfForecast = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText2!
        .copyWith(fontSize: 18, color: Colors.white);

    TextStyle _monthOfForecast = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText2!
        .copyWith(
            fontWeight: AppFontWeight.regular,
            fontSize: 18,
            color: AppColors.secondaryTextColor);

    TextStyle _currentTemp = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText2!
        .copyWith(
            fontWeight: AppFontWeight.thin, fontSize: 100, color: Colors.white);

    TextStyle _currentCity = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText1!
        .copyWith(
            fontWeight: AppFontWeight.regular,
            fontSize: 38,
            color: Colors.white);

    TextStyle _currentWeather = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText2!
        .copyWith(
            fontWeight: AppFontWeight.regular,
            fontSize: 20,
            color: Colors.white);

    TextStyle _dateTime = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText2!
        .copyWith(
            fontWeight: AppFontWeight.thin,
            fontSize: 13,
            color: Colors.white.withOpacity(1));

    TextStyle _titleAppBarStyle = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText2!
        .copyWith(
            fontWeight: AppFontWeight.light, fontSize: 20, color: Colors.white);

    TextStyle _subTitleAppBarStyle = Theme.of(context)
        .textTheme
        .copyWith()
        .bodyText2!
        .copyWith(
            fontWeight: AppFontWeight.light,
            fontSize: 18,
            color: AppColors.secondaryTextColor);

    return Scaffold(
      appBar: CustomAppBar(
        widgetLeading: Padding(
          padding: EdgeInsets.only(left: _paddingHorizontalOfTitle),
          child: SizedBox(
              height: _heightOfLeadingLogoAppBar,
              width: _widthOfLeadingLogoAppBar,
              child: Image.asset(AppAsset.logoCloud)),
        ),
        title: Column(
          children: [
            Text(tr('weatherForecastScreen.weatherForecast'),
                style: _titleAppBarStyle),
            Text(
              _city.name,
              style: _subTitleAppBarStyle,
            ),
          ],
        ),
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
                              tr('weatherForecastScreen.dayForecast'),
                              style: _titleOfForecast,
                            ),
                            Row(
                              children: [
                                Text(
                                  CustomDateTimeFormat.unixTimeToDay(
                                          state.currentWeather.dateTime)
                                      .toString(),
                                  style: _titleOfForecast,
                                ),
                                SizedBox(
                                  width: _paddingOfDayAndMonth,
                                ),
                                Text(
                                  CustomDateTimeFormat.unixTimeToMonth(
                                          state.currentWeather.dateTime)
                                      .toString(),
                                  style: _monthOfForecast,
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
                                  '${state.currentWeather.temp.toInt()}${tr('appConstants.degrees')}',
                                  style: _currentTemp,
                                ),
                                Text(
                                  _city.name,
                                  style: _currentCity,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state
                                          .currentWeather.weatherStatus.weather,
                                      style: _currentWeather,
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
                                            style: _dateTime,
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
                                title: tr('appConstants.loadFailureText'),
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
                  tr('weatherForecastScreen.weatherForecast'),
                  style: _titleOfForecast,
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
                                            style: _dateTime,
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
                              title: tr('appConstants.loadFailureText'),
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
