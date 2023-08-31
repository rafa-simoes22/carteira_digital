import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  double saldo = 1000;
  double valorSubtraido = 0;  // Renomeado para valorSubtraido
  bool mostrarCampos = false;  
  bool mostrarBotaoVoltar = false;  

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: WillPopScope(
        onWillPop: () async {
          if (mostrarBotaoVoltar) {
            setState(() {
              mostrarCampos = false;
              mostrarBotaoVoltar = false;
            });
            return false;
          }
          return true;
        }, 
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.grey[200],
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Saldo: \$${saldo.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                if (mostrarCampos)  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) {
                        setState(() {
                          valorSubtraido = double.tryParse(value) ?? 0;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Digite o Valor',
                      ),
                    ),
                  ),
                if (mostrarCampos)  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            saldo -= valorSubtraido;  // Subtrair o valorSubtraido do saldo
                          });
                        },
                        child: Text('Enviar'),
                      ),
                    ],
                  ),
                if (!mostrarCampos && !mostrarBotaoVoltar)
                  ElevatedButton(  
                    onPressed: () {
                      setState(() {
                        mostrarCampos = true;
                        mostrarBotaoVoltar = true;
                      });
                    },
                    child: Text('Transação'),
                  ),
                if (mostrarBotaoVoltar)  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              mostrarCampos = false;
                              mostrarBotaoVoltar = false;
                            });
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomePageWidget()));
}
