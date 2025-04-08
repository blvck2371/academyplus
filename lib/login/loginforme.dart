import 'package:academyplus/Databasefirestore/ConnectDbFire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage();
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final PageController pageController = PageController();

  void switchForm() {
    setState(() {
      isLogin = !isLogin;
    });
    pageController.animateToPage(
      isLogin ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(5.0),
        child: AppBar(centerTitle: true, backgroundColor: Colors.black),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          AuthForm(isLogin: true, switchForm: switchForm),
          AuthForm(isLogin: false, switchForm: switchForm),
        ],
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  final bool isLogin;
  final VoidCallback switchForm;

  const AuthForm({super.key, required this.isLogin, required this.switchForm});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.isLogin)
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                ),
                Lottie.asset(
                  'assets/lottiefile/lotties/student.json',
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          const SizedBox(height: 20),
          Text(
            widget.isLogin ? 'Connexion' : 'Inscription',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                if (!widget.isLogin) ...[
                  buildTextField("Nom", nameController),
                  buildTextField("Prénom", surnameController),
                  buildTextField("Téléphone", phoneController),
                ],
                buildTextField("Email", emailController),
                buildTextField("Mot de passe", passwordController,
                    isPassword: true),
                if (!widget.isLogin)
                  buildTextField(
                      "Confirmer le mot de passe", confirmPasswordController,
                      isPassword: true),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isLogin) {
                        await _loginUser();
                      } else {
                        await _registerUser();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Valider',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: widget.switchForm,
                  child: Text(
                    widget.isLogin ? "Créer un compte" : "J'ai déjà un compte",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Ce champ est requis';
          if (label == "Email" &&
              !RegExp(r"^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            return 'Entrez un email valide';
          }
          if (label == "Téléphone" && !RegExp(r"^\d{8,15}$").hasMatch(value)) {
            return 'Entrez un numéro valide (8 à 15 chiffres)';
          }
          if (label == "Confirmer le mot de passe" &&
              value != passwordController.text) {
            return 'Les mots de passe ne correspondent pas';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Connexion réussie : ${userCredential.user?.email}");
      Get.offNamed('/');
    } on FirebaseAuthException catch (e) {
      print("Erreur : ${e.message}");

      _showError(e);
    }
  }

  Future<void> _registerUser() async {
    try {
      UserCredential userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      await FirebaseFirestore.instance
          .collection('Eleves')
          .doc(userCred.user!.uid)
          .set({
        'id': userCred.user!.uid,
        "nom": nameController.text.trim(),
        "prenom": surnameController.text.trim(),
        "telephone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "createdAt": Timestamp.now(),
      });

      await UserData!.updateDisplayName(
        nameController.text.trim(),
      );

      await Get.offNamed('/');
    } on FirebaseAuthException catch (e) {
      print(
          e.code + 'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      _showError(e);
    }
  }

  void _showError(FirebaseAuthException e) {
    final message = switchFirebaseError(e.code, e.message);
    Get.snackbar(
      "Erreur",
      message,
      backgroundColor: const Color.fromARGB(255, 137, 16, 16),
      colorText: Colors.white,
    );
  }

  String switchFirebaseError(String code, String? message) {
    switch (code) {
      case 'user-not-found':
        return 'Aucun utilisateur trouvé pour cet email.';
      case 'wrong-password':
        return 'Mot de passe incorrect.';
      case 'email-already-in-use':
        return 'Cet email est déjà utilisé.';
      case 'weak-password':
        return 'Mot de passe trop faible.';
      case 'invalid-email':
        return 'Email invalide.';
      case 'network-request-failed':
        return 'Problème de connexion réseau. Vérifie ta connexion.';
      default:
        return message ?? 'Une erreur est survenue.';
    }
  }
}
