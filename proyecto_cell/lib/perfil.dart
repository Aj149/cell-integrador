import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movilapp_main/servicios/firebaseservice.dart';

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  State<PerfilUsuario> createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  String _imageUrl = '';
  String _Nombre = '';
  String _Apellido = '';
  String _Usuario = '';

  Future<void> _saveUrl() async {
    if (_urlController.text.isNotEmpty) {
      setState(() {
        _imageUrl = _urlController.text;
      });
      await updatePerfil({'imageUrl': _imageUrl});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('URL actualizada con éxito.')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa una URL.')),
      );
    }
  }

  void _openUrlEditor() {
    _urlController.text = _imageUrl;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar URL de la imagen'),
          content: TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'URL de la imagen',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _saveUrl,
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _openProfileEditor() {
    _nombreController.text = _Nombre;
    _apellidoController.text = _Apellido;
    _usuarioController.text = _Usuario;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _apellidoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _usuarioController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveChanges() async {
    setState(() {
      _Nombre = _nombreController.text;
      _Apellido = _apellidoController.text;
      _Usuario = _usuarioController.text;
    });

    await updatePerfil({
      'Nombre': _Nombre,
      'Apellido': _Apellido,
      'Usuario': _Usuario,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil actualizado con éxito')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: getClientes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          }

          Map<String, dynamic> userData = snapshot.data!.docs.first.data();
          _Nombre = userData["Nombre"] ?? "";
          _Apellido = userData["Apellido"] ?? "";
          _Usuario = userData["Usuario"] ?? "";
          _imageUrl = userData["imageUrl"] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: _openUrlEditor,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: _imageUrl.isNotEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_imageUrl),
                                )
                              : null,
                          color: Colors.grey,
                        ),
                        child: _imageUrl.isEmpty
                            ? const Icon(Icons.account_circle, size: 100)
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Tooltip(
                        message: 'Editar imagen',
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: _openUrlEditor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Nombre:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _Nombre,
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _openProfileEditor,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Apellido:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _Apellido,
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _openProfileEditor,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Usuario:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _Usuario,
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _openProfileEditor,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
