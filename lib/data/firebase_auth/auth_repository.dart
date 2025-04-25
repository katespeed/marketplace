import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(FirebaseAuth.instance);

class AuthRepository {
  AuthRepository(this.auth);

  final FirebaseAuth auth;

  User? get authUser => auth.currentUser;

  Stream<User?> authStateChanges() => auth.authStateChanges();
  
  Stream<User?> userChanges() => auth.userChanges();

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(username);
      
      // Send email verification
      await credential.user?.sendEmailVerification();
      
      // Check if user document exists
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user?.uid)
          .get();
          
      if (!userDoc.exists) {
        // Create user document if it doesn't exist
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user?.uid)
            .set({
          'uuid': credential.user?.uid,
          'name': username,
          'email': credential.user?.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e, stack) {
      throw AsyncError(e, stack);
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw AsyncError(e, StackTrace.current);
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e, stack) {
      throw AsyncError(e, stack);
    }
  }

  Future<void> deleteAccount({required String password}) async {
    try {
      final user = auth.currentUser;
      if (user == null || user.email == null) {
        throw Exception('User not found');
      }
      
      try {
        // Attempt to reauthenticate
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
      } catch (e) {
        throw Exception('Invalid password');
      }
      
      // Delete all user-related data from Firestore
      try {
        final db = FirebaseFirestore.instance;
        final storage = FirebaseStorage.instance;
        
        // First delete user document to ensure permissions
        await db.collection('users').doc(user.uid).delete();
        
        // Delete user's products
        final productsSnapshot = await db
            .collection('products')
            .where('sellerId', isEqualTo: user.uid)
            .get();
            
        for (var doc in productsSnapshot.docs) {
          try {
            // Delete product images from storage
            final productData = doc.data();
            final imageUrls = productData['imageUrls'] as List<dynamic>?;
            
            if (imageUrls != null) {
              for (final imageUrl in imageUrls) {
                try {
                  final ref = storage.ref(imageUrl);
                  await ref.delete();
                } catch (e) {
                  throw AsyncError('Failed to delete image: $e', StackTrace.current);
                }
              }
            }
            
            // Delete product document
            await doc.reference.delete();
          } catch (e) {
            throw AsyncError('Failed to delete product document: $e', StackTrace.current);
          }
        }
        
        // Delete collections in parallel for better performance
        await Future.wait([
          _deleteCollection(db, 'listings', user.uid),
          _deleteCollection(db, 'reviews', user.uid),
          _deleteCollection(db, 'sales', user.uid),
        ]);
        
      } catch (e) {
        FirebaseAuth.instance.signOut(); // Force sign out on error
        throw AsyncError('Failed to delete Firestore data: $e', StackTrace.current);
      }
      
      // Delete Firebase user
      await user.delete();
    } catch (e, stack) {
      if (e is Exception) {
        throw AsyncError(e, stack);
      }
      throw AsyncError('Failed to delete account', stack);
    }
  }

  Future<void> _deleteCollection(FirebaseFirestore db, String collectionPath, String userId) async {
    final snapshot = await db
        .collection(collectionPath)
        .where('userId', isEqualTo: userId)
        .get();
        
    for (var doc in snapshot.docs) {
      try {
        await doc.reference.delete();
      } catch (e) {
        throw AsyncError('Failed to delete $collectionPath document: $e', StackTrace.current);
      }
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e, stack) {
      throw AsyncError(e, stack);
    }
  }

  // Add new method for checking email verification status
  bool isEmailVerified() {
    return auth.currentUser?.emailVerified ?? false;
  }

  // Add new method for resending verification email
  Future<void> resendVerificationEmail() async {
    final user = auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw Exception('No user is currently signed in');
    }
  }
}
