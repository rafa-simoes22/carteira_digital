import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  double saldo = 0;
  double valorAdicionado = 0;
  bool mostrarCampos = false;  
  bool mostrarBotaoVoltar = false;  // Novo estado para controlar a exibição do botão voltar

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
                          valorAdicionado = double.tryParse(value) ?? 0;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Valor a adicionar',
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
                            saldo += valorAdicionado;
                          });
                        },
                        child: Text('Enviar'),
                      ),
                    ],
                  ),
                if (!mostrarCampos && !mostrarBotaoVoltar)  // Mostrar o botão "Transação" somente se os campos não estiverem sendo mostrados
                  ElevatedButton(  
                    onPressed: () {
                      setState(() {
                        mostrarCampos = true;
                        mostrarBotaoVoltar = true;
                      });
                    },
                    child: Text('Transação'),
                  ),
                if (mostrarBotaoVoltar)  // Mostrar o botão de voltar apenas se mostrarBotaoVoltar for verdadeiro
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
