import 'package:flutter/material.dart';
import 'package:sms_maintained/sms.dart';
import 'package:my_money_manager/src/services/sms/smsservice.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<SmsMessage>>(
          future: getAllSmsMessages(),
          builder: (BuildContext context, AsyncSnapshot<List<SmsMessage>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text("SMS retrieval: Something went wrong"),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].body)
                        );
                      });
                }
                return Container();
              case ConnectionState.waiting:
                return Container(
                  child: Center(
                    child: Text("Waiting...."),
                  ),
                );
              case ConnectionState.none:
              case ConnectionState.active:
            }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<SmsMessage>> getAllSmsMessages() {
    return SmsService.getAllSmsMessages();
  }

}