import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const GenerateColors());
}

class GenerateColors extends StatelessWidget {
  const GenerateColors({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Color!',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  List<Widget> paginas = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      paginas.addAll([
        geraContainer(),
        geraContainer(),
      ]);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: paginas,
        onPageChanged: (value) {
          setState(() {
            paginas.add(geraContainer());
          });
        },
      ),
    );
  }

  Color geraCor() {
    int red = Random().nextInt(255);
    int green = Random().nextInt(255);
    int blue = Random().nextInt(255);

    return Color.fromRGBO(red, green, blue, 1);
  }

  String convertCor(Color cor) {
    String red = cor.red.toRadixString(16).padLeft(2, '0');
    String green = cor.green.toRadixString(16).padLeft(2, '0');
    String blue = cor.blue.toRadixString(16).padLeft(2, '0');

    return "$red$green$blue";
  }

  Widget geraContainer() {
    final Color corGerada = geraCor();
    final String corHex = convertCor(corGerada).toUpperCase();

    return Container(
      color: corGerada,
      height: double.maxFinite,
      width: double.maxFinite,
      child: Center(
        child: GestureDetector(
          onTap: () => copiaCor(corHex),
          onLongPress: () => copiaCor(corHex),
          child: Text(
            '#$corHex',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              backgroundColor: Colors.black.withOpacity(
                corGerada.computeLuminance(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void copiaCor(String corHex) {
    Clipboard.setData(ClipboardData(text: '#$corHex'));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black.withOpacity(.5),
        content: SizedBox(
          height: 20,
          width: double.maxFinite,
          child: Center(
            child: Text("Color #$corHex copied!"),
          ),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }
}
