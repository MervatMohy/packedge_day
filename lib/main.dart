import 'package:flutter/material.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtual Keyboard',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Virtual Keyboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //text user typed.
  String text = '';
  bool shiftEnabled = false;




  bool isNumericMode = false;
  late TextEditingController _controllerText;

  @override
  void initState() {

    _controllerText = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SwitchListTile(
              title: Text(
                'Keyboard Type = ' +
                    (isNumericMode
                        ? 'Numeric'
                        : 'Alphanumeric'),
              ),
              value: isNumericMode,
              onChanged: (val) {
                setState(() {
                  isNumericMode = val;
                });
              },
            ),
            Text(
              text,
            style: TextStyle( fontSize: 25,color: Colors.black87 ),

            ),


            Expanded(
              child: Container(),
            ),
            Container(
              color: Colors.deepOrange,
              child: VirtualKeyboard(
                  height: 300,
                  //width: 500,
                  textColor: Colors.white,
                  textController: _controllerText,

                  defaultLayouts: [
                    VirtualKeyboardDefaultLayouts.Arabic,
                    VirtualKeyboardDefaultLayouts.English,
                  ],
                  reverseLayout :true,
                  type: isNumericMode
                      ? VirtualKeyboardType.Numeric
                      : VirtualKeyboardType.Alphanumeric,
                  onKeyPress: _onKeyPress),
            ),
          ],
        ),
      ),
    );
  }

  //  when the virtual keyboard key is pressed.
  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      text = text + (shiftEnabled ? key.capsText : key.text)!;
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          text = text + '\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          text = text + key.text!;
          break;
        case VirtualKeyboardKeyAction.Shift:
          shiftEnabled = !shiftEnabled;
          break;
        default:
      }
    }
    // Update screen
    setState(() {});
  }
}


