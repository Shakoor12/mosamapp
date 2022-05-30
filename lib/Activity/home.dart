import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';
// import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    Map? info={};
    var city_name = ["Islamabad", "D i khan","Swat", "Peshawar", "Lahore", "Waziristan"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    info = ModalRoute.of(context)?.settings.arguments as Map ;
    String temp =  ((info['temp_value']).toString()); //.substring(0,4);
    String air = ((info['air_speed_value']).toString());//.substring(0,4);
    if(temp == "NA")
    {
      print("NA");
    }
    else
    {
      temp =  ((info['temp_value']).toString()).substring(0,4);
      air = ((info['air_speed_value']).toString()).substring(0,4);
    }
    String icon = info['icon_value'].toString();
    String getcity = info['city_value'];
    String hum = info['hum_value'];

    String des = info['des_value'];
    print("$icon");
    // Map info ={};
    //  info = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: NewGradientAppBar(
          gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blue.shade200,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,

                  colors:
                  [
                    Colors.blue.shade800,//[800],
                    Colors.blue.shade200//[300],

                  ]
              ),
            ),
            child: Column(
              children: [
                Container( //Search Wala Container

                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)
                  ),
                  child: Row(

                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") == "")
                          {
                            print("Blank search");
                          }else{
                            Navigator.pushReplacementNamed(context, "/loading",arguments: {
                              "searchText" : searchController.text,
                            });
                          }

                        },
                        child: Container(child: Icon(Icons.search,color: Colors.blueAccent,),margin: EdgeInsets.fromLTRB(3, 0, 7, 0),),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search $city"
                          ),
                        ),
                      )
                    ],
                  ),

                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          padding: const EdgeInsets.all(10),
                          child: Row(children: [
                            Image.network("http://openweathermap.org/img/wn/$icon@2x.png",fit: BoxFit.fill,),
                            //SizedBox(width: 10,),
                            Column(
                              children: [
                                Text("$des",style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),
                                Text("In $getcity",style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            )
                          ])),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(WeatherIcons.thermometer, size: 35,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$temp",style: const TextStyle(
                                    fontSize: 90
                                ),),
                                const Text("C",style: TextStyle(
                                    fontSize: 30
                                ),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(WeatherIcons.day_sunny, size: 35)
                              ],
                            ),
                            const SizedBox(height: 30,)
                            ,
                            Text("$air",style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),),
                            const Text("km/hr")
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: const EdgeInsets.all(26),
                        height: 200,
                        child:  Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(WeatherIcons.humidity, size: 35)
                              ],
                            ),
                            const SizedBox(height: 30,)
                            ,
                            Text("$hum",style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),),
                            const Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text("Made By Shakoor Khan"),
                      Text("Data Provided By Openweathermap.org")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
        // appBar: AppBar(
        //   title: Text("Home Activity"),
        // ),
        // body:
        // Column(
        //   children: <Widget>[
        //     FloatingActionButton(
        //       onPressed: () {},
        //     ),
        //     Text(info["main_value" ]),
        //     Text(info["air_speed_value" ]),
        //     Text(info["hum_value" ]),
        //     Text(info["temp_value" ]),
        //     Text(info["des_value" ]),
        //   ],
        // )



    );
  }
}