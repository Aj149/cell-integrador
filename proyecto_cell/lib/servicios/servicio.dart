import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movilapp_main/ahorros.dart';

FirebaseFirestore bdA = FirebaseFirestore.instance;


  Future<void> agregarGasto(Map<String, dynamic> gasto)async{
  try {
  CollectionReference collectionReferenceAhorros = bdA.collection("ahorros");
  await collectionReferenceAhorros.add(gasto);
  print("exito");
} catch(e) {
  print("error: $e");
}
  }
