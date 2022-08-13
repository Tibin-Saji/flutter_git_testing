// Store All Global Variables like URL, User Object here
import 'models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const URL = "https://tathva-staging.herokuapp.com";
User user;

final storage = FlutterSecureStorage();