import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';


class FirebaseHelper {
  static const idPrefix = "id_";

  User? get currentUser => FirebaseAuth.instance.currentUser;

  String get userDataPrefix => "users/${currentUser?.uid}/";

  DatabaseReference getDatabaseReference(String path) => FirebaseDatabase.instance.ref(path);

  Future<Uint8List?> getStorageData(String path) async {
    Reference reference = FirebaseStorage.instance.ref(path);
    return reference.getData();
  }

  Future<DataSnapshot> getDatabaseSnapshot(String path, {bool isUserData = true}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    var dataSnapshot = await databaseReference.child((isUserData ? userDataPrefix : "") + path).get();
    return dataSnapshot;
  }

  Future<void> setDatabaseValue(String path, dynamic value, {bool isUserData = true}) async => getDatabaseReference((isUserData ? userDataPrefix : "") + path).set(value);
  Future<void> updateDatabaseValue(String path, dynamic value, {bool isUserData = true}) async => getDatabaseReference((isUserData ? userDataPrefix : "") + path).update(value);
  Future<void> removeDatabaseValue(String path, {bool isUserData = true}) async => getDatabaseReference((isUserData ? userDataPrefix : "") + path).remove();

  Future<int> getVersionConfig(String name) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getInt(name);
  }
}