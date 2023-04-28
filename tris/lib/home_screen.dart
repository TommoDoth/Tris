import 'package:flutter/material.dart';
import 'package:tris/game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController p1Controller = TextEditingController();
  final TextEditingController p2Controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Inserisci nome giocatori: ",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: p1Controller,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    hintText: "Nome Giocatore 1",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (valore) {
                    if (valore == null || valore.isEmpty) {
                      return "Inserisci Nome Giocatore 1";
                    }
                    return null;
                  },
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: p2Controller,
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: "Nome Giocatore 2",
                  hintStyle: TextStyle(color: Colors.black),
                ),
                validator: (valore) {
                  if (valore == null || valore.isEmpty) {
                    return "Inserisci Nome Giocatore 2";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen(
                              G1: p1Controller.text, G2: p2Controller.text)));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                child: const Text(
                  "Start",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
