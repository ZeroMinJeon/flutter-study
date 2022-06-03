import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  List<String> btDeviceNames = [];
  List<BluetoothDevice> devices = [];

  late FlutterBluePlus flutterBluePlus;
  late StreamSubscription<BluetoothDeviceState> state;

  @override
  void initState() {
    flutterBluePlus = FlutterBluePlus.instance;
    super.initState();
  }

  void scan() async {
    // if (!(await flutterBluePlus.isAvailable)){
    //   await flutterBluePlus.turnOn();
    //   return ;
    // }
    // await flutterBluePlus.turnOn();
    await flutterBluePlus.startScan(timeout: Duration(seconds: 4));
    var subScription = flutterBluePlus.scanResults.listen((results) {
      btDeviceNames = [];
      devices = [];
      for (ScanResult result in results) {
        if (result.device.name.isEmpty) {
          continue;
        }
          devices.add(result.device);
          btDeviceNames.add(result.device.name);
      }
    });
    setState((){});
    await flutterBluePlus.stopScan();
    await subScription.cancel();
  }

  void connectDevice(BluetoothDevice device) async {
    await device.connect();
    state = device.state.listen((bluetoothDeviceState) {
      // print(bluetoothDeviceState.name);
      // print(bluetoothDeviceState.index);
    });
    print(device.name);
    // discover(device);
    await Future.delayed(const Duration(seconds: 2));
    // await device.disconnect();
  }

  void disconnectDevice(BluetoothDevice device) async {
    await device.disconnect();
    await state.cancel();
    // var d = device.state.listen((bluetoothDeviceState) {
    //   // print(bluetoothDeviceState.name);
    //   // print(bluetoothDeviceState.index);
    // });
    // print(device.name);
    // // discover(device);
    // await Future.delayed(const Duration(seconds: 2));
    // await d.cancel();
    // await device.disconnect();
  }

  void discover(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      print('service device id :${service.deviceId}');
      print('service device uuid:${service.uuid}');
      print('service device isPrimary:${service.isPrimary}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: btDeviceNames.map((name) => Text(name)).toList(),
              ),
              Column(
                children: devices
                    .map((bluetoothDevice) => GestureDetector(
                          onTap: () => connectDevice(bluetoothDevice),
                          onDoubleTap: () => disconnectDevice(bluetoothDevice),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 3, color: Colors.redAccent)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(bluetoothDevice.name),
                                Text(bluetoothDevice.id.id)
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              TextButton(onPressed: scan, child: Text('Search')),
            ],
          ),
        ),
      ),
    );
  }
}
