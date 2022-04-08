import 'package:meta/meta.dart';
import 'dart:convert';

PollutionApi pollutionApiFromJson(String str) => PollutionApi.fromJson(json.decode(str));

String pollutionApiToJson(PollutionApi data) => json.encode(data.toJson());

class PollutionApi {
    PollutionApi({
        required this.coord,
        required this.list,
    });

    Coord coord;
    List<ListElement> list;

    factory PollutionApi.fromJson(Map<String, dynamic> json) => PollutionApi(
        coord: json["coord"] == null
            ? Coord(lon: 0.0, lat: 0.0)
            : Coord.fromJson(json["coord"]),
        list: json["coord"] == null
            ? []
            :  List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
    };
}

class Coord {
    Coord({
        required this.lon,
        required this.lat,
    });

    double lon;
    double lat;

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}

class ListElement {
    ListElement({
        required this.main,
        required this.components,
        required this.dt,
    });

    Main main;
    Map<String, double> components;
    int dt;

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        main: Main.fromJson(json["main"]),
        components: Map.from(json["components"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        dt: json["dt"],
    );

    Map<String, dynamic> toJson() => {
        "main": main.toJson(),
        "components": Map.from(components).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "dt": dt,
    };
}

class Main {
    Main({
        required this.aqi,
    });

    int aqi;

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        aqi: json["aqi"],
    );

    Map<String, dynamic> toJson() => {
        "aqi": aqi,
    };
}