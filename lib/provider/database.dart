import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/model/locationModel.dart';
import 'package:mobile/model/userModel.dart';

_Database databaseProvider = _Database();

class _Database {
  final db = Firestore.instance;
  FirebaseUser _firebaseUser;

  Future<void> init() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      await setCurrentUser(user);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    this._firebaseUser = null;
    currentUser = UserModal();
    return;
  }

  Future<void> setCurrentUser(FirebaseUser user) async {
    this._firebaseUser = user;
    Map<String, dynamic> result = await getUserProfile(uid: user.uid);
    if (result != null) {
      currentUser = UserModal.fromJson(result);
    }
  }

  FirebaseUser getCurrentUser() {
    return this._firebaseUser;
  }

  Future<void> registerUser(UserModal user) async {
    Completer<void> c = Completer<void>();
    try {
      if (_firebaseUser == null) {
        _firebaseUser = await FirebaseAuth.instance.currentUser();
      }
      await db
          .collection("users")
          .document(_firebaseUser.uid)
          .setData(user.toJSON());
      c.complete();
    } catch (e) {
      print(e);
      c.completeError(e);
    }
    return c.future;
  }

  Future<Map<String, dynamic>> getUserProfile(
      {@optionalTypeArgs String uid}) async {
    Completer<Map<String, dynamic>> c = Completer<Map<String, dynamic>>();
    try {
      String uuid = uid == null ? _firebaseUser.uid : uid;
      DocumentSnapshot doc = await db.collection("users").document(uuid).get();
      if (doc.exists)
        c.complete(doc.data);
      else
        c.complete();
    } catch (e) {
      print(e);
      c.completeError(e);
    }
    return c.future;
  }

  Future<Map<String, dynamic>> deleteUserProfile() async {
    Completer<Map<String, dynamic>> c = Completer<Map<String, dynamic>>();
    try {
      await db.collection("users").document(_firebaseUser.uid).delete();
      c.complete();
    } catch (e) {
      print(e);
      c.completeError(e);
    }
    return c.future;
  }

  Future<void> setUserLocation(UserLocation loc) async {
    Completer<void> c = Completer<void>();
    try {
      print("${loc.latitude}, ${loc.longitude}");
      print("${_firebaseUser.uid}");

      if (currentUser != null) {
        await db
            .collection("locations")
            .document(_firebaseUser.uid)
            .setData(loc.toJSON());
        c.complete();
      }
    } catch (e) {
      print("Error:-$e");
      c.completeError(e);
    }
    return c.future;
  }

  getUserLocation(String uid, {@optionalTypeArgs void onValue(LatLng latLng)}) {
    db.collection("locations").document(uid).snapshots().listen((onData) {
      print(onData.data);
      LatLng latLng = LatLng(onData.data["latitude"], onData.data["longitude"]);
      onValue(latLng);
    });
  }
}
