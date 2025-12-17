import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepository(this._supabaseClient);

  User? get currentUser => _supabaseClient.auth.currentUser;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGoogle() async {
    const webClientId = 'YOUR_WEB_CLIENT_ID';
    const iosClientId = 'YOUR_IOS_CLIENT_ID';

    final googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw 'No ID token from Google';
    }

    await _supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;

  Future<void> deleteAccount() async {
    await _supabaseClient.rpc('delete_user');
  }

  Future<void> updateUserPassword(String password) async {
    await _supabaseClient.auth.updateUser(
      UserAttributes(
        password: password,
      ),
    );
  }
}
