import "package:cloud_firestore/cloud_firestore.dart";
import "package:shared_preferences/shared_preferences.dart";

FirebaseFirestore bdA = FirebaseFirestore.instance;

Future<void> RegisterUsuario(Map<String, dynamic> usuario) async {
  try {
    CollectionReference collectionReferenceUsuario = bdA.collection('Usuario');
    await collectionReferenceUsuario.add(usuario);
    print("Registro Exitoso");
  } catch (e) {
    print('Error: $e');
  }
}

Future<QuerySnapshot<Map<String, dynamic>>> getClientes() async {
  print("este es el servicio");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? usuario = prefs.getString('usuario');
  print("el usuario es :$usuario");
  QuerySnapshot<Map<String, dynamic>> result = await bdA
      .collection('Usuario')
      .where('Usuario', isEqualTo: usuario)
      .limit(1)
      .get();
  var userData = result.docs.first.data();
  print("la data es $userData");
  return result;
}

Future<void> updatePerfil(Map<String, dynamic> userData) async {
  try {
   SharedPreferences prefs = await SharedPreferences.getInstance();
  String? usuario = prefs.getString('usuario');
  print("el usuario es :$usuario");
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await bdA
      .collection('Usuario')
      .where('Usuario', isEqualTo: usuario)
      .limit(1)
      .get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference<Map<String, dynamic>> docRef =
          querySnapshot.docs.first.reference;

      await docRef.update(userData);

      print('Documento actualizado con éxito.');
    } else {
      print('Errr en if');
    }
  } catch (e) {
    print('Error al actualizar el documento: $e');
  }
}
