import 'package:get/get.dart';

class MyGetXController extends GetxController {
  RxBool isCheck = false.obs;
  RxString task = ''.obs;
  RxString taskId = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  saveTaskValue(String name, String id, bool check) {
    task = name.obs;
    taskId = id.obs;
    // isCheck = check.obs;
    update();
  }

  resetTaskValue() {
    task = ''.obs;
    taskId = ''.obs;
    update();
  }

  setCheck(RxBool value) {
    isCheck != isCheck;
  }
}
