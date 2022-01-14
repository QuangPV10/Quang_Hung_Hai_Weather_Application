import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class MapWidget extends StatelessWidget {
  double lat;
  double lon;

  MapWidget({required this.lat, required this.lon});

  Color mapColor = ColorsApp.blurMapColor;

  @override
  Widget build(BuildContext context) {
    final mapController = MapController(
      location: LatLng(lat, lon),
    );
    return Map(
      controller: mapController,
      builder: (BuildContext context, int x, int y, int z) {
        return Container(
          child: Stack(
            children: [
              Image.network(
                '${MapImage(z: z, x: x, y: y).map}',
                fit: BoxFit.cover,
                color: mapColor,
                colorBlendMode: BlendMode.hardLight,
              ),
              Image.network(
                '${WeatherImage(z: z, x: x, y: y).map}',
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }
}
