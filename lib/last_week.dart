// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home.dart';
import 'weekly_api.dart';

class weeklyPage extends StatefulWidget {
  weeklyPage(
      {Key? key,
      required WeeklyApi this.weeklyApi,
      required double this.lat,
      required double this.long})
      : super(key: key);

  WeeklyApi weeklyApi;
  double lat;
  double long;

  @override
  State<weeklyPage> createState() => _weeklyPageState();
}

class _weeklyPageState extends State<weeklyPage> {
  int _selectedIndex = 1;
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
              child: Text('Jonh Mayer', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Text('สภาพอากาศสัปดาห์ที่ผ่านมา',
              style: TextStyle(fontSize: 25, color: Colors.white)),
          Column(
            children: getForecast(),
          )
        ],
      )))),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => myHome()));
      }
    });
  }

  List<Widget> getForecast() {
    List<Widget> list = [];
    List<String> days = [
      "วันจันทร์",
      "วันอังคาร",
      "วันพุธ",
      "วันพฤหัสบดี",
      "วันศุกร์",
      "วันเสาร์",
      "วันอาทิตย์"
    ];
    int count = 0;
    for (var item in widget.weeklyApi.daily) {
      if(count <= 6){
      double min = item.temp.min, max = item.temp.max;
      int pressure = item.pressure, humid = item.humidity;
      list.add(SizedBox(
        height: 10,
      ));
      list.add(
        Container(
          width: 335,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: const Color(0xFFF1FAEE),
          ),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                days[count],
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1D3557),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
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
                              fontSize: 20, color: Color(0xFF1D3557))),
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
                              fontSize: 20, color: Color(0xFF1D3557))),
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
                              fontSize: 20, color: Color(0xFF1D3557))),
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
                              fontSize: 20, color: Color(0xFF1D3557))),
                    ],
                  ),
                ],
              )
            ],
          )),
        ),
      );
        count++;
    }
    }
    return list;
  }
}
