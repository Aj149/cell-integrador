import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AhorroApp());
}

class Gasto {
  String nombre;
  double cantidad;
  String tipo;

  Gasto({required this.nombre, required this.cantidad, required this.tipo});
}

class AhorroApp extends StatefulWidget {
  @override
  _AhorroAppState createState() => _AhorroAppState();
}

class _AhorroAppState extends State<AhorroApp> {
  final TextEditingController _saldoInicialController = TextEditingController();
  final TextEditingController _nombreGastoController = TextEditingController();
  final TextEditingController _cantidadGastoController = TextEditingController();
  final TextEditingController _tipoGastoController = TextEditingController();
  final TextEditingController _tipoEmergenciaController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  double saldoInicial = 0;
  List<Gasto> gastos = [];
  String nombreGasto = "";
  double cantidadGasto = 0;
  String tipoGasto = "fijo";
  String tipoEmergencia = "";

  Future<void> agregarGasto(Map<String, dynamic> gasto) async {
    try {
      CollectionReference collectionReferenceAhorros = _firestore.collection("ahorros");
      await collectionReferenceAhorros.add(gasto);
      print("exito");
    } catch (e) {
      print("error: $e");
      throw e; // Re-lanza la excepción para manejarla en otro lugar si es necesario
    }
  }

  void handleAgregarGasto() async {
    if (_nombreGastoController.text.isEmpty ||
        _cantidadGastoController.text.isEmpty ||
        _saldoInicialController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Por favor, llena todos los campos correctamente."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    double cantidadGasto = double.parse(_cantidadGastoController.text);
    double saldoInicial = double.parse(_saldoInicialController.text);

    if (cantidadGasto > saldoInicial) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("¡Tus ingresos no son suficientes para este gasto!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    final nuevoGasto = Gasto(
      nombre: _nombreGastoController.text,
      cantidad: cantidadGasto,
      tipo: tipoGasto,
    );

    // Llamada al servicio para agregar el gasto a Firestore
    try {
      await agregarGasto({
        'nombre': nuevoGasto.nombre,
        'cantidad': nuevoGasto.cantidad,
        'tipo': nuevoGasto.tipo,
      });

      setState(() {
        gastos.add(nuevoGasto);
        saldoInicial -= cantidadGasto;
        _nombreGastoController.clear();
        _cantidadGastoController.clear();
        tipoGasto = "fijo";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gasto agregado correctamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar gasto: $e')),
      );
    }
  }

  double calcularPorcentajeConsumido() {
    double totalGastos = calcularTotalGastos();
    if (saldoInicial == 0) return 0;
    double porcentajeConsumido = ((saldoInicial - totalGastos) / saldoInicial) * 100;
    return porcentajeConsumido;
  }

  double calcularTotalGastos() {
    return gastos.fold(0, (total, gasto) => total + gasto.cantidad);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ahorro App'),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0B0C10),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: const Color(0xFF1F2833),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ahorro App',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _saldoInicialController,
                            decoration: InputDecoration(
                              labelText: 'Saldo Inicial',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _nombreGastoController,
                            decoration: InputDecoration(
                              labelText: 'Nombre del Gasto',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _cantidadGastoController,
                            decoration: InputDecoration(
                              labelText: 'Cantidad del Gasto',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: tipoGasto,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            dropdownColor: Color(0xFF1F2833),
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                tipoGasto = value!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                child: Text('Fijo', style: TextStyle(color: Colors.white)),
                                value: 'fijo',
                              ),
                              DropdownMenuItem(
                                child: Text('Variable', style: TextStyle(color: Colors.white)),
                                value: 'variable',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _tipoEmergenciaController,
                            decoration: InputDecoration(
                              labelText: 'Gasto de Emergencia',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: handleAgregarGasto,
                            child: const Text('Ingresar tu gasto'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: const Color(0xFF1F2833),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detalles de los Gastos',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Saldo Restante: \$${(saldoInicial - calcularTotalGastos()).toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                            'Porcentaje de Saldo Restante: ${calcularPorcentajeConsumido().toStringAsFixed(2)}%',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          gastos.isEmpty
                              ? const Text(
                                  'No hay gastos ingresados.',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                )
                              : Column(
                                  children: gastos.map((gasto) {
                                    return ListTile(
                                      title: Text(gasto.nombre, style: TextStyle(color: Colors.white)),
                                      subtitle: Text(gasto.tipo, style: TextStyle(color: Colors.white70)),
                                      trailing: Text(
                                        '\$${gasto.cantidad.toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
