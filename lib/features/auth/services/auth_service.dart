import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Add your web client ID here (from Firebase Console)
  static const String _webClientId = '653741363027-iq15l2285diltb5gcprcul6142li21os.apps.googleusercontent.com';

  Future<UserModel?> signInWithGoogle() async {
  try {
    print('🔵 Starting Google Sign-In');

    final googleSignIn = GoogleSignIn(clientId: _webClientId);
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      print('🟡 Google Sign-In cancelled by user');
      return null;
    }

    print('🟢 Google user selected: ${googleUser.displayName}');

    final googleAuth = await googleUser.authentication;
    print('🟢 Auth tokens retrieved');

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print('🟢 Firebase credential created');

    final userCredential = await _auth.signInWithCredential(credential);
    print('✅ Firebase sign-in complete');

    final user = userCredential.user;
    if (user != null) {
      print('✅ Firebase user: ${user.email}');
      return UserModel(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
    } else {
      print('❌ Firebase user is null');
    }
  } catch (e) {
    print('❌ Sign-In Error: $e');
    rethrow;
  }

  return null;
}


  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn(clientId: _webClientId);
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
