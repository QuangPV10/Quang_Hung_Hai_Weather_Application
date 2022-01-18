import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class MapWidget extends StatelessWidget {
  final double lat;
  final double lon;

  MapWidget({Key? key, required this.lat, required this.lon}) : super(key: key);

  Color mapColor = ColorsApp.blurMapColor;

  @override
  Widget build(BuildContext context) {
    final mapController = MapController(
      location: LatLng(lat, lon),
    );
    return Map(
      controller: mapController,
      builder: (BuildContext context, int x, int y, int z) {
        return Stack(
          children: [
            CachedNetworkImage(
              imageUrl:MapImage(z: z, x: x, y: y).map,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              color: mapColor,
              colorBlendMode: BlendMode.hardLight,
            ),
            CachedNetworkImage(
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl:WeatherImage(z: z, x: x, y: y).map,
              fit: BoxFit.cover,
            ),
          ],
        );
      },
    );
  }
}
