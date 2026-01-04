import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

/// Google Authentication Service
/// Handles Google Sign-In functionality
class GoogleAuthService extends GetxService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  GoogleSignInAccount? _currentUser;

  /// Get current signed-in Google user
  GoogleSignInAccount? get currentUser => _currentUser;

  @override
  void onInit() {
    super.onInit();
    _listenToAuthChanges();
  }

  /// Listen to Google Sign-In auth state changes
  void _listenToAuthChanges() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
      if (account != null) {
        print('✅ Google User signed in: ${account.displayName}');
        print('📧 Email: ${account.email}');
        print('🆔 ID: ${account.id}');
      } else {
        print('❌ Google User signed out');
      }
    });
  }

  /// Sign in with Google
  ///
  /// Returns: GoogleSignInAccount if successful, null otherwise
  Future<GoogleSignInAccount?> signIn() async {
    try {
      print('📤 Starting Google Sign-In...');

      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        _currentUser = account;
        print('✅ Google Sign-In successful');
        print('👤 Name: ${account.displayName}');
        print('📧 Email: ${account.email}');
        print('🆔 ID: ${account.id}');
        print('📷 Photo: ${account.photoUrl}');

        return account;
      } else {
        print('⚠️ Google Sign-In cancelled by user');
        return null;
      }
    } catch (error) {
      print('❌ Google Sign-In Error: $error');
      return null;
    }
  }

  /// Sign in silently (if previously signed in)
  ///
  /// Returns: GoogleSignInAccount if successful, null otherwise
  Future<GoogleSignInAccount?> signInSilently() async {
    try {
      print('📤 Attempting silent Google Sign-In...');

      final GoogleSignInAccount? account = await _googleSignIn.signInSilently();

      if (account != null) {
        _currentUser = account;
        print('✅ Silent Google Sign-In successful');
        return account;
      } else {
        print('⚠️ No previous Google Sign-In found');
        return null;
      }
    } catch (error) {
      print('❌ Silent Google Sign-In Error: $error');
      return null;
    }
  }

  /// Sign out from Google
  Future<void> signOut() async {
    try {
      print('📤 Signing out from Google...');

      await _googleSignIn.signOut();
      _currentUser = null;

      print('✅ Google Sign-Out successful');
    } catch (error) {
      print('❌ Google Sign-Out Error: $error');
    }
  }

  /// Disconnect from Google (revoke access)
  Future<void> disconnect() async {
    try {
      print('📤 Disconnecting from Google...');

      await _googleSignIn.disconnect();
      _currentUser = null;

      print('✅ Google Disconnect successful');
    } catch (error) {
      print('❌ Google Disconnect Error: $error');
    }
  }

  /// Check if user is currently signed in
  bool isSignedIn() {
    return _currentUser != null;
  }

  /// Get Google ID Token (for backend verification)
  Future<String?> getIdToken() async {
    try {
      if (_currentUser == null) {
        print('⚠️ No Google user signed in');
        return null;
      }

      final GoogleSignInAuthentication auth = await _currentUser!.authentication;
      return auth.idToken;
    } catch (error) {
      print('❌ Error getting Google ID Token: $error');
      return null;
    }
  }

  /// Get Google Access Token
  Future<String?> getAccessToken() async {
    try {
      if (_currentUser == null) {
        print('⚠️ No Google user signed in');
        return null;
      }

      final GoogleSignInAuthentication auth = await _currentUser!.authentication;
      return auth.accessToken;
    } catch (error) {
      print('❌ Error getting Google Access Token: $error');
      return null;
    }
  }
}
