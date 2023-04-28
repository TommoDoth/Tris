import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tris/home_screen.dart';

class GameScreen extends StatefulWidget {
  String G1;
  String G2;
  GameScreen({required this.G1, required this.G2});
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> mappa;
  late String ilGiocatoreCheStaGiocando;
  late String vincitore;
  late bool fine;
  @override
  void initState() {
    super.initState();
    mappa = List.generate(3, (_) => List.generate(3, (_) => ""));
    ilGiocatoreCheStaGiocando = "X";
    vincitore = "";
    fine = false;
  }

  void resetGame() {
    setState(() {
      mappa = List.generate(3, (_) => List.generate(3, (_) => ""));
      ilGiocatoreCheStaGiocando = "X";
      vincitore = "";
      fine = false;
    });
  }

  void mossa(int r, int c) {
    if (mappa[r][c] != "" || fine) {
      return;
    }
    setState(() {
      mappa[r][c] = ilGiocatoreCheStaGiocando;
      if (mappa[r][0] == ilGiocatoreCheStaGiocando &&
          mappa[r][1] == ilGiocatoreCheStaGiocando &&
          mappa[r][2] == ilGiocatoreCheStaGiocando) {
        vincitore = ilGiocatoreCheStaGiocando;
        fine = true;
      } else if (mappa[0][c] == ilGiocatoreCheStaGiocando &&
          mappa[1][c] == ilGiocatoreCheStaGiocando &&
          mappa[2][c] == ilGiocatoreCheStaGiocando) {
        vincitore = ilGiocatoreCheStaGiocando;
        fine = true;
      } else if (mappa[0][0] == ilGiocatoreCheStaGiocando &&
          mappa[1][1] == ilGiocatoreCheStaGiocando &&
          mappa[2][2] == ilGiocatoreCheStaGiocando) {
        vincitore = ilGiocatoreCheStaGiocando;
        fine = true;
      } else if (mappa[0][2] == ilGiocatoreCheStaGiocando &&
          mappa[1][1] == ilGiocatoreCheStaGiocando &&
          mappa[2][0] == ilGiocatoreCheStaGiocando) {
        vincitore = ilGiocatoreCheStaGiocando;
        fine = true;
      }
      if (ilGiocatoreCheStaGiocando == "X") {
        ilGiocatoreCheStaGiocando = "O";
      } else {
        ilGiocatoreCheStaGiocando = "X";
      }
      if (!mappa.any((r) => r.any((cell) => cell == ""))) {
        fine = true;
        vincitore = "Pareggio";
      }
      if (vincitore != "") {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: "Gioca ancora",
            title: vincitore == "X"
                ? widget.G1 + " Ha vinto"
                : vincitore == "O"
                    ? widget.G2 + "Ha vinto"
                    : "Pareggio",
            btnOkOnPress: () {
              resetGame();
            }).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Turno: ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                          ilGiocatoreCheStaGiocando == "X"
                              ? widget.G1 + " ($ilGiocatoreCheStaGiocando)"
                              : widget.G2 + " ($ilGiocatoreCheStaGiocando)",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ilGiocatoreCheStaGiocando == "X"
                                ? Color(0xFF323D5B)
                                : Colors.red,
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(5),
              child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    int r = index ~/ 3;
                    int c = index % 3;
                    return GestureDetector(
                      onTap: () => mossa(r, c),
                      child: Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            mappa[r][c],
                            style: TextStyle(
                              fontSize: 120,
                              fontWeight: FontWeight.bold,
                              color: mappa[r][c] == "X"
                                  ? Color(0xFF323D5B)
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                    widget.G1 = "";
                    widget.G2 = "";
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      child: Text(
                        "Restart Gioco",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
