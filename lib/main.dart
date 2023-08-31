import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  double saldo = 1000;
  double valorSubtraido = 0;
  bool mostrarCampos = false;
  bool mostrarBotaoVoltar = false;
  bool mostrarExtrato = false;
  List<double> historico = [];

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
              mostrarExtrato = false;
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.account_balance_wallet),
                      Text(
                        'Saldo: \$${saldo.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.account_balance_wallet),
                    ],
                  ),
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
                        labelText: 'Digite um valor',
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
                            saldo -= valorSubtraido;
                            historico.add(-valorSubtraido);
                          });
                        },
                        child: Row(
                          children: [
                            Text('Enviar'),
                          ],
                        ),
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
                    child: Row(
                      children: [
                        Icon(Icons.remove_circle),
                        Text('Transação'),
                      ],
                    ),
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
                              mostrarExtrato = false;
                            });
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                  ),
                if (mostrarExtrato)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Extrato:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (var valor in historico)
                          Text(
                            'R\$ ${valor.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  ),
                if (!mostrarCampos && !mostrarExtrato && !mostrarBotaoVoltar)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        mostrarExtrato = true;
                        mostrarBotaoVoltar = true;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.history),
                        Text('Extrato'),
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
