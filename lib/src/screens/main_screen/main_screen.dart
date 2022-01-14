import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_state.dart';
import 'package:quang_hung_hai_weather_application/src/constants/app_colors.dart';
import 'package:quang_hung_hai_weather_application/src/models/position.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/map_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WeatherBloc>().add(
          WeatherRequested(
            position: Position(lat: 10.75, lon: 106.6667, zoom: 11),
          ),
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.primaryBackgroundColor,
        leading: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoadSuccess) {
              if (state.weather.weatherConditionSymbol != null) {
                return Image(
                    image: MemoryImage(state.weather.weatherConditionSymbol!));
              } else {
                return const SizedBox.shrink();
              }
            }
            if (state is WeatherLoadFailure) {
              return Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(state.errorMessage!),
              );
            }
            return Container(
              color: Colors.orange,
            );
          },
        ),
        toolbarHeight: 50,
        title: Center(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is WeatherLoadSuccess) {
                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        state.weather.cityName,
                        style: const TextStyle(
                            fontSize: 15, color: ColorsApp.primaryTextColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.weather.weatherCondition,
                            style: const TextStyle(
                              fontSize: 13,
                              color: ColorsApp.primaryTextColor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            state.weather.temperature,
                            style: const TextStyle(
                              fontSize: 13,
                              color: ColorsApp.primaryTextColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              if (state is WeatherLoadFailure) {
                return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(state.errorMessage!),
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
            onPressed: () {},
            icon: const Image(
              image: AssetImage('assets/images/settings.png'),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WeatherLoadSuccess) {
            return MapView(
              position: state.weather.position,
            );
          }
          if (state is WeatherLoadFailure) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(state.errorMessage!),
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
