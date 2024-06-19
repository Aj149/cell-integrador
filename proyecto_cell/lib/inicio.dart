import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movilapp_main/ahorros.dart';
import 'package:movilapp_main/dashboard.dart';
import 'package:movilapp_main/historial.dart';
import 'package:movilapp_main/paginaPrincipal.dart';
import 'package:movilapp_main/perfil.dart';

void main() {
  runApp(MaterialApp(
    home: InicioApp(),
  ));
}

class InicioApp extends StatelessWidget {
  final List<String> images = [
    'https://images.pexels.com/photos/1602726/pexels-photo-1602726.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/259165/pexels-photo-259165.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/4968630/pexels-photo-4968630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilUsuario()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PaginaPrincipal()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InicioApp()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.savings),
              title: const Text('Ahorros'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AhorroApp()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardApp()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Historial(gastos: [],)),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50.0),
                child: const Column(
                  children: [
                    Text(
                      '¡Bienvenido a tu aplicación de control de gastos!',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Somos una plataforma diseñada para ayudarte a administrar y controlar tus gastos de manera eficiente. '
                      'Registra tus ingresos y gastos, establece presupuestos, y mantén un seguimiento de tus finanzas personales de manera sencilla.',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: images.map((image) {
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: 1000.0,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 50.0),
              const Column(
                children: [
                  Text(
                    'Sobre nosotros',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Somos un equipo comprometido en ofrecerte la mejor experiencia para el control de tus gastos. '
                    'Nuestra aplicación está diseñada pensando en ti, para que puedas gestionar tus finanzas de manera fácil y segura. '
                    '¡Únete a nosotros y toma el control de tu dinero hoy mismo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
