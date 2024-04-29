class WeatherDataHourly {
  final List<Hourly> hourly;

  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(hourly: List<Hourly>.from(json['hourly'].map((e) => Hourly.fromJson(e))));
}

class Hourly {
  int? dt;
  dynamic temp;
  List<Weather>? weather;

  Hourly({
    this.dt,
    this.temp,
    this.weather,
  });

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['temp'] = this.temp;
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}
