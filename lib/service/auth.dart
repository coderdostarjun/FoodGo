import 'package:firebase_auth/firebase_auth.dart';

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
  Future deleteUser() async
  {
    User? user=await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}