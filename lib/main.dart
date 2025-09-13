import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dart_openai/dart_openai.dart';

void main() {
  runApp(MyApp());
}

var count = 0;
Future<void> _saveText(TextEditingController bc) async {
  count++;
  final text = bc.text;
  final file = await _getFile();
  await file.writeAsString("bc$count: $text\n", mode: FileMode.append);
  debugPrint("Saved to file: ${file.path}");
}

Future<void> _writeStartupLine() async {
  final file = await _getFile();
  await file.writeAsString("The Rorschach Test\n", mode: FileMode.write);
}

Future<File> _getFile() async {
  final dir = await getApplicationDocumentsDirectory();
  return File('${dir.path}/user_input.txt');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(context) {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {});
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage());
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("video/menu.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setPlaybackSpeed(1.75);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(width: 800, height: 300, child: VideoPlayer(_controller))
        : const Center(child: CircularProgressIndicator());
  }
}

class VideoPlayerScreen2 extends StatefulWidget {
  const VideoPlayerScreen2({super.key});

  @override
  State<VideoPlayerScreen2> createState() => _VideoPlayerScreenState2();
}

class _VideoPlayerScreenState2 extends State<VideoPlayerScreen2> {
  late VideoPlayerController _controller2;
  @override
  void initState() {
    super.initState();

    _controller2 = VideoPlayerController.asset("video/Rules.mp4")
      ..initialize().then((_) {
        _controller2.play();
        _controller2.setPlaybackSpeed(2);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller2.value.isInitialized
        ? SizedBox(width: 500, height: 300, child: VideoPlayer(_controller2))
        : const Center(child: CircularProgressIndicator());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(4.0, 4.0, 4.0, 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Positioned(child: VideoPlayerScreen()),
                  Positioned(
                    top: 128,
                    left: 165,
                    child: Text(
                      'The',
                      style: TextStyle(
                        fontFamily: 'RomanAntique',
                        fontSize: 40,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 165,
                    left: 95,
                    child: Text(
                      'Rorschach Test',
                      style: TextStyle(
                        fontFamily: 'RomanAntique',
                        fontSize: 40,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton.tonal(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Rules()),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(200, 60),
                    backgroundColor: Colors.white10,
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontFamily: 'Winky',
                      fontSize: 35,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 100, child: VideoPlayerScreen2()),
          Positioned(
            top: 200,
            left: 75,
            child: Text(
              'Rules:-',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 50,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),

          Positioned(
            left: 80,
            top: 300,
            child: Text(
              '• We will show you 10 \n   inkblot images.\n• You are to describe \n   what you see in those \n   images.\n• thats really it i think.',
              style: TextStyle(fontFamily: 'Winky', fontSize: 30),
            ),
          ),
          Positioned(
            left: 125,
            bottom: 200,
            child: FilledButton.tonal(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FirstImage()),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                minimumSize: Size(100, 50),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FirstImage extends StatelessWidget {
  FirstImage({super.key});

  TextEditingController first = TextEditingController();
  @override
  Widget build(context) {
    _writeStartupLine();
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/1.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: first,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. bat, butterfly, moth',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (first.text != null && first.text.trim().isNotEmpty) {
                  _saveText(first);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SecImage()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecImage extends StatelessWidget {
  SecImage({super.key});
  TextEditingController second = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/2.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: second,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. two humans, four-legged animal',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (second.text != null && second.text.trim().isNotEmpty) {
                  _saveText(second);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => thrImage()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class thrImage extends StatelessWidget {
  thrImage({super.key});
  TextEditingController thr = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/3.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: thr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. two people',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (thr.text != null && thr.text.trim().isNotEmpty) {
                  _saveText(thr);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => f()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class f extends StatelessWidget {
  f({super.key});
  TextEditingController thr = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/4.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: thr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. animal hide, animal skin, skin rug',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (thr.text != null && thr.text.trim().isNotEmpty) {
                  _saveText(thr);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => five()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class five extends StatelessWidget {
  five({super.key});
  TextEditingController thr = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/5.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: thr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. bat, butterly, moth',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (thr.text != null && thr.text.trim().isNotEmpty) {
                  _saveText(thr);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => six()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class six extends StatelessWidget {
  six({super.key});
  TextEditingController thr = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/6.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: thr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. animal hide, animal skin, skin rug',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (thr.text != null && thr.text.trim().isNotEmpty) {
                  _saveText(thr);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => seven()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class seven extends StatelessWidget {
  seven({super.key});
  TextEditingController thr = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/7.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: thr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText:
                      'eg. human heads, faces, heads of women or children',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (thr.text != null && thr.text.trim().isNotEmpty) {
                  _saveText(thr);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => eight()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class eight extends StatelessWidget {
  eight({super.key});
  TextEditingController thr = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/8.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: thr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. pink four-legged animal',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (thr.text != null && thr.text.trim().isNotEmpty) {
                  _saveText(thr);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => nine()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class nine extends StatelessWidget {
  nine({super.key});
  TextEditingController thr = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/9.jpg',
              width: 600,
              height: 350,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 200,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: thr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. human',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (thr.text.trim().isNotEmpty) {
                  _saveText(thr);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ten()),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ten extends StatelessWidget {
  ten({super.key});
  TextEditingController thr = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            top: 200,
            child: Text(
              'What do you see',
              style: TextStyle(
                fontFamily: 'RomanAntique',
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationThickness: 5,
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 10,
            right: 20,
            child: Image.asset(
              'image/10.jpg',
              width: 600,
              height: 285,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 250,
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: thr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ), // Border when focused
                  ),
                  labelText: 'eg. crab, lobster, worms, caterpillars',
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                if (thr.text.trim().isNotEmpty) {
                  _saveText(thr);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RorschachAnalysisScreen(),
                    ),
                  );
                } else {
                  final snackBar = SnackBar(content: Text("Enter an Input!!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Winky',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RorschachAnalysisScreen extends StatefulWidget {
  const RorschachAnalysisScreen({super.key});

  @override
  State<RorschachAnalysisScreen> createState() =>
      _RorschachAnalysisScreenState();
}

class _RorschachAnalysisScreenState extends State<RorschachAnalysisScreen> {
  String? _analysis;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _analyzeResponses();
  }

  Future<void> _analyzeResponses() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/user_input.txt');
      final userResponses = await file.readAsString();

      OpenAI.apiKey = "API key";
      final chat = await OpenAI.instance.chat.create(
        model: "gpt-4o-mini",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.system,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                "You are an AI giving symbolic interpretations of Rorschach test responses. "
                "Do not give medical or psychological advice. Keep it fun, creative, and thoughtful.",
              ),
            ],
          ),
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                userResponses,
              ),
            ],
          ),
        ],
      );

      setState(() {
        _analysis = chat.choices.first.message.content?.first.text ?? "";
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _analysis = "Error: $e";
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 250, 228, 210),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(246, 250, 228, 210),
        title: Align(
          alignment: AlignmentGeometry.xy(0, 0),
          child: Text("Result"),
        ),
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: _loading
            ? const LinearProgressIndicator(
                minHeight: 6,
                color: Colors.deepPurple,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _analysis ?? "No analysis",
                        style: TextStyle(fontSize: 20, fontFamily: "Winky"),
                      ),
                      ElevatedButton.icon(onPressed: 
                      (){Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false,
                  );},
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                    label: Text("Finalize"),   )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
