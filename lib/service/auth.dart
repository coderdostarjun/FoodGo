import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/screen/onboarding.dart';

class AuthMethods
{
  //i.e FirebaseAuth.instance vaneko Firebaseauth ko object create hunxa
  final FirebaseAuth auth=FirebaseAuth.instance;

  getCurrentUser() async
  {
   await auth.currentUser;
  }
  Future SignOut() async
  {
    await FirebaseAuth.instance.signOut();
  }

  //delete user
  Future<void> deleteUser(String email, String password, BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw FirebaseAuthException(code: 'no-user', message: 'No user signed in');
      }

      final credential = EmailAuthProvider.credential(email: email, password: password);

      // Re-authenticate the user
      await user.reauthenticateWithCredential(credential);

      // Wait a bit to make sure it's stable
      await Future.delayed(Duration(milliseconds: 300));

      // Now delete the user
      await user.delete();

      // Wait a little to let Firebase clean up
      await Future.delayed(Duration(milliseconds: 300));

      // Now safely navigate to onboarding
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Onboarding()),
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Error: ${e.code} - ${e.message}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Something went wrong")),
        );
      }
    } catch (e) {
      print("General error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to delete account. Try again.")),
        );
      }
    }
  }



}
