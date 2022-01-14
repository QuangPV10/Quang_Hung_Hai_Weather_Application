import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/src/provider.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/constants/app_colors.dart';
import 'package:quang_hung_hai_weather_application/src/models/position.dart';
import 'package:map/map.dart' as map;

class MapView extends StatefulWidget {
  late Position position;

  MapView({Key? key, required this.position}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  bool _isPinning = false;
  late LatLng _centerPoint;
  late map.MapController _controller;
  late LatLng _pinnedPos;

  void _gotoDefault() {
    _controller.center = LatLng(_pinnedPos.latitude, _pinnedPos.longitude);
    setState(() {});
  }

  void _zoomIn() {
    _controller.zoom = _controller.zoom + 1;
  }

  void _zoomOut() {
    _controller.zoom = _controller.zoom - 1;
  }

  void _onDoubleTap() {
    _zoomIn();
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;

  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      _controller.zoom += 1;
      setState(() {});
    } else if (scaleDiff < 0) {
      _controller.zoom -= 1;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      _controller.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _pinnedPos = LatLng(widget.position.lat, widget.position.lon);
    _controller = map.MapController(
      location: LatLng(_pinnedPos.latitude, _pinnedPos.longitude),
      zoom: widget.position.zoom!,
    );
  }

  Widget _buildMarkerWidget(
      {required Offset pos, Color? color, required IconData icon}) {
    return Positioned(
      left: pos.dx - 16,
      top: pos.dy - 16,
      width: 24,
      height: 24,
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        map.MapLayoutBuilder(
          controller: _controller,
          builder: (context, transformer) {
            final homeLocation = transformer.fromLatLngToXYCoords(
                LatLng(widget.position.lat, widget.position.lon));

            final homeMarkerWidget = _buildMarkerWidget(
              pos: homeLocation,
              color: Colors.blue,
              icon: Icons.my_location,
            );

            final centerLocation = Offset(
                transformer.constraints.biggest.width / 2,
                transformer.constraints.biggest.height / 2);

            final centerMarkerWidget = _buildMarkerWidget(
              pos: centerLocation,
              color: Colors.red,
              icon: Icons.location_on,
            );

            _centerPoint = transformer.fromXYCoordsToLatLng(
              Offset(
                transformer.constraints.biggest.width / 2,
                transformer.constraints.biggest.height / 2,
              ),
            );

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onDoubleTap: _onDoubleTap,
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              onTapUp: (details) {
                final location =
                    transformer.fromXYCoordsToLatLng(details.localPosition);

                final clicked = transformer.fromLatLngToXYCoords(location);
              },
              child: Listener(
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  children: [
                    map.Map(
                      controller: _controller,
                      builder: (context, x, y, z) {
                        final url =
                            'https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/$z/$x/$y?access_token=pk.eyJ1IjoiaGFpdHJhbjA1MDgiLCJhIjoiY2t5OGg0aHhwMHl2dTJvcW15c3g2Ymt5eiJ9.DO_CrhiqFNwDsDMwg0YrXw';

                        final url2 =
                            'https://tile.openweathermap.org/map/clouds_new/$z/$x/$y.png?appid=3ed0ef21dd370431bc47b7f67e06aca3';
                        return Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                            ),
                            CachedNetworkImage(
                              imageUrl: url2,
                              fit: BoxFit.cover,
                            ),
                          ],
                        );
                      },
                    ),
                    homeMarkerWidget,
                    if (_isPinning) centerMarkerWidget,
                  ],
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (!_isPinning) {
                      _isPinning = true;
                    } else {
                      _isPinning = false;
                      _pinnedPos =
                          LatLng(_centerPoint.latitude, _centerPoint.longitude);

                      context.read<WeatherBloc>().add(WeatherRequested(
                              position: Position(
                            lat: _pinnedPos.latitude,
                            lon: _pinnedPos.longitude,
                            zoom: _controller.zoom,
                          )));
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: ColorsApp.primaryBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    _zoomIn();
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: ColorsApp.primaryBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    _zoomOut();
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: ColorsApp.primaryBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    _gotoDefault();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: ColorsApp.primaryBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
