import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefenceHelper
{
  static String userIdKey="USERKEY";
  static String userNameKey="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEY";
  static String userImageKey="USERIMAGEKEY";
  static String userLocation="USERLOCATION";

  Future<bool> saveUserId(String getUserId)async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId); //userIdKey should be unique
    //key(unique key) , value pair ma data store hunxa locally
  }
  Future<bool> saveUserName(String getUserName)async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userNameKey,getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail)async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey,getUserEmail);
  }
  Future<bool> saveUserImage(String getUserImage)async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userImageKey,getUserImage);
  }
  Future<bool> saveUserLocation(String getUserLocation)async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userLocation,getUserLocation);
  }

  Future<String?> getUserId() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }
  Future<String?> getUserName() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
    //tehi key(unique key) ko help le data or value get garna sakxau juna locally store vako thiyo

  }
  Future<String?> getUserEmail() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }
  Future<String?> getUserImage() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }
  Future<String?> getUserLocation() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userLocation);
  }
}