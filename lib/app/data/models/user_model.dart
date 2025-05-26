import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String? name;
  final String? email;
  final String? photoUrl; 
  final DateTime createdAt;
  final DateTime? lastLogin; 

  UserModel({
    required this.uid,
    this.name,
    this.email,
    this.photoUrl,
    required this.createdAt,
    this.lastLogin,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?; 
    if (data == null) {
      throw Exception("User data is null for UID: ${doc.id}");
    }

    return UserModel(
      uid: doc.id,
      name: data['name'],
      email: data['email'],
      photoUrl: data['photoUrl'], 
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLogin: (data['lastLogin'] as Timestamp?)?.toDate(), 
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl, // Sertakan photoUrl saat menyimpan
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}