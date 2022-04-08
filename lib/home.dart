// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/last_week.dart';
import 'package:weather_app/waether_api.dart';

import 'pollution_api.dart';
import 'weather_detail.dart';
import 'weekly_api.dart';

class myHome extends StatefulWidget {
  myHome({Key? key}) : super(key: key);

  @override
  State<myHome> createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  final getSearch = TextEditingController();
  int _selectedIndex = 0;
  final String apiKey = "227f3793f1fa5a30d5678f61b098a999";
  late WeatherApi ApiDataLatLong;
  late WeatherApiDtails ApiDataDetail;
  late PollutionApi ApiPollution;
  late WeeklyApi ApiWeekly;
  late String icon = "04d";
  late double lat = 13.75,
      long = 100.5167,
      temp = 0.0,
      feelsLike = 0.0,
      min = 0.0,
      max = 0.0,
      no2 = 0.0,
      o3 = 0.0,
      pm10 = 0.0,
      pm25 = 0.0;
  late int pressure = 0, humid = 0;
  String city = "Bangkok";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF457B9D),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(getCurrentDate()),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1D3557),
              ),
              child: Text(
                'Jonh Mayer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: getDetail(lat, long),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 60,
                            padding: EdgeInsets.only(
                                top: 4, left: 20, right: 16, bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      city = getSearch.text;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                hintText: 'ชื่อประเทศหรือจังหวัด',
                                hintStyle: TextStyle(
                                    fontSize: 18, color: Colors.grey.shade600),
                              ),
                              style: TextStyle(fontSize: 18),
                              controller: getSearch,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('$city',
                              style:
                                  TextStyle(fontSize: 50, color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                padding: EdgeInsets.only(
                                    top: 4, left: 20, right: 16, bottom: 2),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: const Color(0xFFF1FAEE),
                                ),
                                child: Transform.scale(
                                    scale: 4,
                                    child: Image.network(
                                        'http://openweathermap.org/img/w/$icon.png')),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 75,
                                    height: 85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: const Color(0xFFF1FAEE),
                                    ),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('NO2',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('$no2',
                                            style: TextStyle(fontSize: 22))
                                      ],
                                    )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 75,
                                    height: 85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: const Color(0xFFF1FAEE),
                                    ),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('PM10',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('$pm10',
                                            style: TextStyle(fontSize: 22))
                                      ],
                                    )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 75,
                                    height: 85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: const Color(0xFFF1FAEE),
                                    ),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('O3',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('$o3',
                                            style: TextStyle(fontSize: 22))
                                      ],
                                    )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 75,
                                    height: 85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: const Color(0xFFF1FAEE),
                                    ),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('PM25',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('$pm25',
                                            style: TextStyle(fontSize: 22))
                                      ],
                                    )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 335,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: const Color(0xFFF1FAEE),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$temp°C',
                                      style: TextStyle(
                                          fontSize: 80,
                                          color: Color(0xFF1D3557))),
                                  Text('Feels like $feelsLike°C',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF1D3557))),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 335,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: const Color(0xFFF1FAEE),
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Min',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF1D3557),
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('$min°C',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF1D3557))),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Max',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF1D3557),
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('$max°C',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF1D3557))),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Prssure',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF1D3557),
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('$pressure',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF1D3557))),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Humidity',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF1D3557),
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('$humid%',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF1D3557))),
                                  ],
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'ข้อมูลย้อนหลัง',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  String getCurrentDate() {
    String date = DateFormat("EEEEE, MMMM dd, yyyy").format(DateTime.now());
    return date;
  }

  Future<WeatherApi> getLatLong(String city) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&APPID=$apiKey");
    var response = await http.get(url);
    ApiDataLatLong = weatherApiFromJson(response.body);
    lat = ApiDataLatLong.coord.lat;
    long = ApiDataLatLong.coord.lon;
    temp = ApiDataLatLong.main.temp;
    feelsLike = ApiDataLatLong.main.feelsLike;
    min = ApiDataLatLong.main.tempMin;
    max = ApiDataLatLong.main.tempMax;
    pressure = ApiDataLatLong.main.pressure;
    humid = ApiDataLatLong.main.humidity;
    if (!ApiDataLatLong.weather.isEmpty) {
      icon = ApiDataLatLong.weather[0].icon;
    }
    return ApiDataLatLong;
  }

  Future<WeatherApiDtails> getDetail(double lat, double long) async {
    Future<WeatherApi> weatherTemp = getLatLong(city);
    Future<PollutionApi> pollution = getPollution(lat, long);
    Future<WeeklyApi> weekly = getWeeklyApi(lat, long);
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&appid=$apiKey");
    var response = await http.get(url);
    ApiDataDetail = weatherApiDtailsFromJson(response.body);
    return ApiDataDetail;
  }

  Future<PollutionApi> getPollution(double lat, double long) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$long&appid=$apiKey");
    var response = await http.get(url);
    ApiPollution = pollutionApiFromJson(response.body);
    if (!ApiPollution.list.isEmpty) {
      no2 = ApiPollution.list[0].components["no2"] as double;
      o3 = ApiPollution.list[0].components["o3"] as double;
      pm10 = ApiPollution.list[0].components["pm10"] as double;
      pm25 = ApiPollution.list[0].components["pm2_5"] as double;
    }
    return ApiPollution;
  }

  Future<WeeklyApi> getWeeklyApi(double lat, double long) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&units=metric&appid=$apiKey");
    var response = await http.get(url);
    ApiWeekly = weeklyApiFromJson(response.body);
    return ApiWeekly;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => weeklyPage(
                      weeklyApi: ApiWeekly,
                      lat: lat,
                      long: long,
                    )));
      }
    });
  }
}
