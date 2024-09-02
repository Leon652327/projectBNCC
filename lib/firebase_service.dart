import 'package:actualprojectforril/widgets/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  // panggil instance db
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionName = 'Datas';

  Stream<List<Data>> getData() {
    return _db.collection(collectionName).snapshots().map(
        (snapshot) => snapshot.docs.map((e) => Data.fromFirestore(e)).toList());
  }

  Future<void> addData(Data data) {
    return _db.collection(collectionName).add(data.toDoc(),);
  }

  Future<void> updateData(Data data) {
    return _db.collection(collectionName).doc(data.id).update(data.toDoc());
  }

  Future<void> deleteData(String id) {
    return _db.collection(collectionName).doc(id).delete();
  }
}
