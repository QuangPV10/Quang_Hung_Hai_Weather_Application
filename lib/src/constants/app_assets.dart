class AppAsset {
  static const String logoCloud = 'assets/images/cloud.png';
  static const String logoSetting = 'assets/images/setting.png';
}

class MapImage {
  late int x, y, z;
  MapImage({required this.z, required this.x, required this.y});
  late String map =
      'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
}

class WeatherIcon {
  late String iconID;
  WeatherIcon({required this.iconID});
  late String weatherIcon = 'http://openweathermap.org/img/wn/$iconID.png';
}
