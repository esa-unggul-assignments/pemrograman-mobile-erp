import 'package:get/get.dart';

class Controller extends GetxController {
  var currentUser = {}.obs;
  setCurrentUser(username) => currentUser(username);
}
