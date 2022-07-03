import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/services.dart';


//adjust text alignment to general
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  runApp(const JoystickExampleApp());
}

class JoystickExampleApp extends StatelessWidget {
  const JoystickExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor:Colors.white,
      ),
      
      home: const MyHomePage(title: 'Dronensteuerung'),
      );
    
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)),

      body: Stack(
        children: const [
          JoystickExample(joystickMode: JoystickMode.vertical, xk: -0.85, yk: 0.0, nam:"height"),

          Align(
            alignment: Alignment(-0.7,0.95),
            child: Text('Höhe',
            style: TextStyle(color: Colors.black, fontSize: 30)
            ),
          
          ),
          
          JoystickExample(joystickMode: JoystickMode.all, xk: 0, yk: 0.0, nam:"direction"),

          Align(
            alignment: Alignment(0,0.95),
            child: Text('Richtung',
            style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          JoystickExample(joystickMode: JoystickMode.horizontal, xk: 0.85, yk: 0.0, nam:"rotation"),
          
          Align(
            alignment: Alignment(0.7,0.95),
            child: Text('Drehung',
            style: TextStyle(color: Colors.black, fontSize: 30),
          
            ),
          ),
        ]),    
    );
}
}


class JoystickExample extends StatefulWidget {
  const JoystickExample({Key? key,required this.joystickMode,required this.xk,required this.yk, required this.nam}) : super(key: key);
  final JoystickMode joystickMode;
  final double xk;
  final double yk;
  final String nam;
  @override
  _JoystickExampleState createState() => _JoystickExampleState();
}

class _JoystickExampleState extends State<JoystickExample> {

  @override
  Widget build(BuildContext context) {
    
    final JoystickMode _joystickMode = widget.joystickMode;
    final double x = widget.xk;
    final double y = widget.yk;
    final String name = widget.nam;
    //double xc = 0;
   // double yc = 0;
    return SafeArea(
        child: (
            Align(
              alignment:  Alignment(x, y),
              child: Joystick(
                onStickDragEnd: (){
                  print(name+": 0.0  0.0");
                  },
                mode: _joystickMode,
                period:  const Duration(milliseconds: 200),
                
                listener: (details) {   
                  print(name+": ${details.x}  ${details.y}");
                  print("\n");
                  
  
                },
                
              ),
            
            )  
        
        ),
        
      );
  
  }
  
}



