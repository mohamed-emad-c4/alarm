import 'dart:async';
import 'package:alarm/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen>
    with TickerProviderStateMixin {
  String _timeString = '';
  String _dateString = '';
  String location = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _dateString = 'Loading...';
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _updateTime();
    });
  }

  void _updateTime() async {
    final String formattedTime = _formatDateTime(DateTime.now());
    final String formattedDate = await _formatDate(DateTime.now());

    // تأكد من أن القيم قد تغيرت بالفعل قبل تحديث الواجهة
    if (formattedTime != _timeString || formattedDate != _dateString) {
      if (mounted) {
        setState(() {
          _timeString = formattedTime;
          _dateString = formattedDate;
        });
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss a').format(dateTime);
  }

  Future<String> _formatDate(DateTime dateTime) async {
    location = await FlutterTimezone.getLocalTimezone();
    location = location.split('/').last;
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Clock",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Center(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.2),
                          Colors.transparent,
                        ],
                        center: Alignment(0, 0),
                        radius: 2,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedDefaultTextStyle(
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[
                                Colors.blueAccent,
                                Colors.cyanAccent,
                              ],
                            ).createShader(
                                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.blueAccent,
                              offset: Offset(0, 0),
                            ),
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.cyanAccent,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: Text('$location'),
                      ),
                      SizedBox(height: 20),
                      AnimatedDefaultTextStyle(
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[
                                Colors.blueAccent,
                                Colors.cyanAccent,
                              ],
                            ).createShader(
                                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.blueAccent,
                              offset: Offset(0, 0),
                            ),
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.cyanAccent,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: Text(_timeString),
                      ),
                      SizedBox(height: 10),
                      AnimatedDefaultTextStyle(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.blueAccent,
                              offset: Offset(0, 0),
                            ),
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.cyanAccent,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: Text(_dateString),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
