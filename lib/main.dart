import 'package:alarm/cubit/home_cubit.dart';
import 'package:alarm/service/DB.dart';
import 'package:alarm/service/notifcation.dart';
import 'package:alarm/views/alarm.dart';
import 'package:alarm/views/setting.dart';
import 'package:alarm/service/shared_preferences.dart';
import 'package:alarm/views/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotification().initialize();
  await AppPreferences().init();
  await AlarmDatabase.instance.database;
  
  runApp(const Home());
}

int currentindex = 0;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alarm',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.blueGrey[900],
          iconTheme: IconThemeData(color: Colors.blueGrey[900]),
        ),
        home: HomeScreen(), // Use a different widget for home screen
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeAlarm || state is HomeInitial) {
            return AlarmScreen();
          } else if (state is HomeClock) {
            return ClockScreen();
          } else if (state is HomeSetting) {
            return SettingsScreen();
          } else {
            return Container(
              color: Colors.blueGrey[900],
              child: Center(
                child: Text("Error"),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });

          if (index == 0) {
            BlocProvider.of<HomeCubit>(context).changeToAlarm();
          } else if (index == 1) {
            BlocProvider.of<HomeCubit>(context).changeToClock();
          } else if (index == 2) {
            BlocProvider.of<HomeCubit>(context).changeToSetting();
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: 'Alarm',
            icon: Icon(
              FontAwesomeIcons.bell,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Clock',
            icon: Icon(
              FontAwesomeIcons.clock,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(
              FontAwesomeIcons.cog,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
