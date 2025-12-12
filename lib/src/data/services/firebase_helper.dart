import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class FirebaseHelper {
  static const idPrefix = "id_";

  User? get currentUser => FirebaseAuth.instance.currentUser;

  DatabaseReference getDatabaseReference(String path) => FirebaseDatabase.instance.ref(path);

  Future<DataSnapshot> getDatabaseSnapshot(String path) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    var dataSnapshot = await databaseReference.child(path).get();
    return dataSnapshot;
  }

  Future<void> setDatabaseValue(String path, dynamic value) async => getDatabaseReference(path).set(value);
  Future<void> updateDatabaseValue(String path, dynamic value) async => getDatabaseReference(path).update(value);
}