import 'dart:developer';
import 'package:alarm/service/DB.dart';
import 'package:flutter/material.dart';




class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<AlarmModel> alarms = [];

  @override
  void initState() {
    super.initState();
    getAlarms();
  }

  void getAlarms() async {
    alarms = await AlarmDatabase.instance.readAllAlarms();
    setState(() {
      // يتم استخدام setState لتحديث واجهة المستخدم
      alarms = alarms.reversed.toList();
    });
   
  }

  void _showAddAlarmDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddAlarmDialog(onAddAlarm: (AlarmModel newAlarm) {
          setState(() {
            alarms.add(newAlarm);
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alarms"),
      ),
      body: alarms.isEmpty
          ? Center(child: Text("No alarms added yet!"))
          : ListView.builder(
              itemCount: alarms.length,
              itemBuilder: (context, index) {
                final alarm = alarms[index];
                return AlarmTile(alarm: alarm);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAlarmDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

class AlarmTile extends StatelessWidget {
  final AlarmModel alarm;

  AlarmTile({required this.alarm});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        title: Text(
          "${alarm.label} - ${alarm.time}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Days: ${alarm.days}"),
        trailing: Switch(
          value: true, // Assume the alarm is active
          onChanged: (bool value) {
            // Handle toggle switch
          },
        ),
      ),
    );
  }
}

class AddAlarmDialog extends StatefulWidget {
  final Function(AlarmModel) onAddAlarm;

  AddAlarmDialog({required this.onAddAlarm});

  @override
  _AddAlarmDialogState createState() => _AddAlarmDialogState();
}

class _AddAlarmDialogState extends State<AddAlarmDialog> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String title = "";
  List<String> selectedDays = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            Text(
              "Add Alarm",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("Time: ${selectedTime.format(context)}"),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (time != null && time != selectedTime) {
                      setState(() {
                        selectedTime = time;
                      });
                    }
                  },
                  child: Text("Select Time"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Days: ${selectedDays.join(', ')}"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday",
                  "Saturday",
                  "Sunday"
                ].map((day) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(day),
                      selected: selectedDays.contains(day),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedDays.add(day);
                          } else {
                            selectedDays.remove(day);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (title.isNotEmpty) {
                  AlarmModel newAlarm = AlarmModel(
                    label: title,
                    time: selectedTime.format(context),
                    days: selectedDays.join(','),
                    sound: "alarm.mp3",
                  );
                  await AlarmDatabase.instance.create(newAlarm);
                  widget.onAddAlarm(newAlarm);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add Alarm"),
            ),
          ],
        ),
      ),
    );
  }
}
