import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_project_uts_praktek/models/timedata.dart'; 

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Waktu di Europe/Amsterdam'),
        ),
        body: const Center(
          child: TimeDisplay(),
        ),
      ),
    );
  }
}

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({super.key});

  @override
  _TimeDisplayState createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  TimeData? timeData;

  @override
  void initState() {
    super.initState();
    fetchTime();
  }

  Future<void> fetchTime() async {
    final response = await http.get(Uri.parse(
        'https://timeapi.io/api/time/current/zone?timeZone=Europe/Amsterdam'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        timeData = TimeData.fromJson(data);
      });
    } else {
      setState(() {
        timeData = TimeData(
          date: 'Gagal load date',
          time: 'Gagal load waktu',
          timeZone: 'Gagal load zona waktu',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Attribute')),
        DataColumn(label: Text('Value')),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('Date')),
          DataCell(Text(timeData?.date ?? 'Menunggu...')),
        ]),
        DataRow(cells: [
          const DataCell(Text('Time')),
          DataCell(Text(timeData?.time ?? 'Menunggu...')),
        ]),
        DataRow(cells: [
          const DataCell(Text('TimeZone')),
          DataCell(Text(timeData?.timeZone ?? 'Menunggu...')),
        ]),
      ],
    );
  }
}
