import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new FirstRoute(),
    );
  }
}

class SecondRoute extends StatelessWidget {
  static bool blind = false;
  void playSound(int note) {
    final player = AudioCache();
    player.play('note$note.wav');
  }

  Expanded buildKey(int note, Color color) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        onPressed: () {
          playSound(note);
        },
        child: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (blind) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKey(1, Colors.grey.shade50),
                buildKey(2, Colors.grey.shade100),
                buildKey(3, Colors.grey.shade200),
                buildKey(4, Colors.grey.shade300),
                buildKey(5, Colors.grey.shade400),
                buildKey(6, Colors.grey.shade500),
                buildKey(7, Colors.grey.shade600),
              ],
            ),
          ),
        ),
      );
    } 
    else if(!blind) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKey(1, Colors.red),
                buildKey(2, Colors.orange),
                buildKey(3, Colors.yellow),
                buildKey(4, Colors.lightGreen),
                buildKey(5, Colors.green),
                buildKey(6, Colors.cyan),
                buildKey(7, Colors.blue),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            title: Text('Main Menu'),
          ),
          drawer: Container(
            width: 200,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: 70.0,
                    child: DrawerHeader(
                      child: Center(child: Text('Xylophone')),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Color'),
                    onTap: () {
                      SecondRoute.blind = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );

                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: Text('Blind'),
                    onTap: () {
                      SecondRoute.blind = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    padding: EdgeInsets.all(100),
                    child: Title(
                        color: Colors.indigoAccent,
                        child:
                            Text('Xylophone', style: TextStyle(fontSize: 30)))),
                Card(
                  child: Column(
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.accessibility),
                        title: Text('Are you Color Blind?'),
                        subtitle: Text('Your Preference Matters'),
                      ),
                      DropdownButton<String>(
                        items: <String>['Yes', 'No'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {
                          if (_ == "Yes") {
                            SecondRoute.blind = true;
                          } else if (_ == "No") {
                            SecondRoute.blind = false;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Play'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRoute()),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(100),
                    child: Text(
                      'We Believe that everyone should be equal and one should never let them down even if they are color blind or vision impared. We believe in you so you should believe in yourslef as well',
                      textAlign: TextAlign.justify,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
