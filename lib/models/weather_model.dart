class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? feelsLike;
  int? pressure;
  String? country;
  Weather(
      {this.cityName,
      this.temp,
      this.wind,
      this.humidity,
      this.feelsLike,
      this.pressure,
      this.country});


  Weather.fromJson(Map<String, dynamic> json){
    cityName = json['name'];
    temp = json['main']['temp'];
    wind = json['wind']['speed'];
    pressure = json['main']['pressure'];
    humidity = json['main']['humidity'];
    feelsLike = json['main']['feels_like'];
    country = json['sys']['country'];
  }
}
