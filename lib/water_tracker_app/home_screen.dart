import 'package:flutter/material.dart';
import 'package:practice_with_ostad/water_tracker_app/water_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WaterTrack> waterTrackList = [];
  final TextEditingController _glassNoTEController = TextEditingController(
    text: "1",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
      ),
      body: _buildWaterTrackCounter(),
    );
  }

  Widget _buildWaterTrackCounter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          getTotalGlasses().toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text("Glass/s", style: TextStyle(fontSize: 16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _glassNoTEController,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
                onPressed: _addNewWaterTrack, child: const Text("Add")),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _buildWaterTrackList(),
        ),
      ],
    );
  }

  Widget _buildWaterTrackList() {

    return ListView.separated(

          itemBuilder: (context, index) {
            final WaterTrack waterTrack = waterTrackList[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text('${waterTrack.noOfGlasses}'),
              ),
              title:  Text("${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}"),
              subtitle:  Text("${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}"),
              trailing: IconButton(
                onPressed: _onTapDelete(index),
                icon: const Icon(Icons.delete),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
            );
          },
          itemCount: waterTrackList.length,
        );
  }

  void _addNewWaterTrack() {
    // check _glassNoTEController.text is empty. If it is empty, set it to 1
    if (_glassNoTEController.text.isEmpty) {
      _glassNoTEController.text = "1";
    }
    // number of glasses variable
    final int noOfGlasses = int.tryParse(_glassNoTEController.text) ?? 1;
    WaterTrack waterTrack =
        WaterTrack(noOfGlasses: noOfGlasses, dateTime: DateTime.now());

    waterTrackList.add(waterTrack);
    setState(() {});
  }

  // get total glasses number
  int getTotalGlasses() {
    int totalGlasses = 0;
    for (WaterTrack track in waterTrackList) {
      totalGlasses += track.noOfGlasses;
    }
    return totalGlasses;
  }

  _onTapDelete(int index) {
    return () {
      setState(() {
        waterTrackList.removeAt(index);
      });
    };
  }
}
