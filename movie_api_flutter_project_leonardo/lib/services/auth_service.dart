import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  // Stream para monitorar mudanças no estado de autenticação
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Obter usuário atual
  User? get currentUser => _auth.currentUser;

  // Login com email e senha
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('Erro no login com email: $e');
      rethrow;
    }
  }

  // Registro com email e senha
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('Erro no registro com email: $e');
      rethrow;
    }
  }

  // Login com Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      debugPrint('Iniciando login com Google...');
      
      // Verifica se o Google Sign In está disponível
      final isAvailable = await _googleSignIn.isSignedIn();
      debugPrint('Google Sign In disponível: $isAvailable');

      // Tenta fazer o login
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('Login com Google cancelado pelo usuário');
        throw 'Login com Google cancelado';
      }

      debugPrint('Google Sign In bem sucedido: ${googleUser.email}');

      // Obtém as credenciais
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      debugPrint('Credenciais do Google obtidas');

      // Cria a credencial do Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Faz o login no Firebase
      debugPrint('Tentando login no Firebase...');
      final userCredential = await _auth.signInWithCredential(credential);
      debugPrint('Login no Firebase bem sucedido: ${userCredential.user?.email}');

      return userCredential;
    } catch (e) {
      debugPrint('Erro no login com Google: $e');
      rethrow;
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      debugPrint('Iniciando logout...');
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      debugPrint('Logout concluído com sucesso');
    } catch (e) {
      debugPrint('Erro no logout: $e');
      rethrow;
    }
  }

  // Reset de senha
  Future<void> resetPassword(String email) async {
    try {
      debugPrint('Iniciando reset de senha para: $email');
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint('Email de reset de senha enviado');
    } catch (e) {
      debugPrint('Erro no reset de senha: $e');
      rethrow;
    }
  }
} 