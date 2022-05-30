import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mousam/Worker/worker.dart';

import '../worker.dart';


class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String? city = "Islamabad";
  String? temp;
  String? hum;
  String? air_speed;
  String? des;
  String? main;
  String? icon;
  void startApp(String city) async
  {
    print("THIS IS CITY fro startpapp( ${city}");
    if(city.toString().isEmpty){
      city = "Islamabad";
    }
    worker instance  = worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon=instance.icon;
    Future.delayed(Duration(seconds: 3), () {
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      "temp_value" : temp,
      "hum_value" : hum,
      "air_speed_value" : air_speed,
      "des_value" : des,
      "main_value" : main,
      "icon_value" : icon,
      "city_value" : city,

    } );
    });

  }

  @override
  void initState() {
    // TODO: implement initState

    //startApp(city);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map search={};
    search = ModalRoute.of(context) !=null &&  ModalRoute.of(context)!.settings.arguments.toString() != "null"? ModalRoute.of(context)!.settings.arguments as Map: {};

    if(search.isNotEmpty)
    {
      print("$search");
      city = search['searchText'];
    }
    startApp(city!);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/mousam2.jpg", height: 240, width: 240,),
            const SizedBox(height: 10,),
            const Text('Mousam App',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),),
        const SizedBox(height: 10,),
            const Text("Made by Shakoor khan",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white)),
            const SizedBox(height: 15,),
        const SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
          ],
        ),
      ),
backgroundColor: Colors.blue[300],
    );

  }
}
