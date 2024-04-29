class WeatherDataDaily {
  final List<Daily> daily;

  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(daily: List<Daily>.from(json['daily'].map((e) => Daily.fromJson(e))));
}


class Daily {
  int? dt;
  Temp? temp;
  List<Weather>? weather;

  Daily(
      {this.dt,
        this.temp,
        this.weather,
        });

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : null;

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

    if (this.temp != null) {
      data['temp'] = this.temp!.toJson();
    }

    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Temp {
  dynamic day;
  dynamic min;
  dynamic max;

  Temp({this.day, this.min, this.max});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['min'] = this.min;
    data['max'] = this.max;
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
