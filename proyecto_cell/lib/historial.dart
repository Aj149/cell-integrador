import 'package:flutter/material.dart';

class Historial extends StatelessWidget {
  final List<Map<String, dynamic>> gastos;

  Historial({Key? key, required this.gastos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Gastos'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: gastos.length,
          itemBuilder: (context, index) {
            var gasto = gastos[index];
            return Card(
              child: ListTile(
                title: Text(gasto['nombre']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Saldo restante:'),
                    Text(
                      '\$${gasto['cantidad']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Tipo: ${gasto['tipo']}'),
                    Text('Fecha: ${gasto['fecha']}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
