import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account?.authentication;
      // print(account);
      // print('========ID TOKEN ========');
      // print(googleKey?.idToken);

      // Servicio rest
      final sigInWithGoogleEndPoint = Uri(
          scheme: 'https',
          host: 'apple-google-sing-in-daec.herokuapp.com',
          path: '/google');
      final session = await http
          .post(sigInWithGoogleEndPoint, body: {'token': googleKey?.idToken});
      print('====== backend ========');
      print(session.body);
      return account!;
    } catch (e) {
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}
