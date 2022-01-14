class Position {
  final double lat;
  final double lon;
  late double? zoom = 1;

  set setZoom(double zoom) {
    this.zoom = zoom;
  }

  Position({required this.lat, required this.lon, this.zoom});
}
