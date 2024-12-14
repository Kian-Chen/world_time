import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late Future<String> _futureTime;

  Future<String> _setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Shanghai', flag: 'china.png', url: 'Asia/Shanghai');
    await instance.getTime();
    return instance.time ?? 'loading';
  }

  @override
  void initState() {
    super.initState();
    _futureTime = _setupWorldTime();  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: FutureBuilder<String>(
          future: _futureTime,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('loading');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(snapshot.data ?? 'loading');
            }
          },
        ),
      ),
    );
  }
}

