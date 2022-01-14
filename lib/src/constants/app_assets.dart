class AppAsset {
  static const String logoCloud = 'assets/images/cloud.png';
  static const String logoSetting = 'assets/images/setting.png';
  static const String data = 'assets/data/city_list.json';
}

class MapImage {
  late int x, y, z;
  MapImage({required this.z, required this.x, required this.y});
  late String map =
      'https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/$z/$x/$y?access_token=pk.eyJ1IjoiaGFpdHJhbjA1MDgiLCJhIjoiY2t5OGg0aHhwMHl2dTJvcW15c3g2Ymt5eiJ9.DO_CrhiqFNwDsDMwg0YrXw';
}

class WeatherImage {
  late int x, y, z;
  WeatherImage({required this.z, required this.x, required this.y});
  late String map =
      'https://tile.openweathermap.org/map/clouds_new/$z/$x/$y.png?appid=2a99675cf54960573fefa4a06f7030c6';
}

class WeatherIcon {
  late String iconID;
  WeatherIcon({required this.iconID});
  late String weatherIcon = 'http://openweathermap.org/img/wn/$iconID.png';
}


