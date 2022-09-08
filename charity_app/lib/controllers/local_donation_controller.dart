import 'package:charity_app/Model/local_storage_donation_model.dart';
import 'package:get/get.dart';

import '../services/Databases/my_sqflite.dart';

class LocalDonationController extends GetxController {
// inserting the object to the database
  var taskList = <LocalDonation>[];
  Future<int> addTask({LocalDonation? task}) async {
    return await DBHelper.insert(task);
  }

// reading the object from the database
  void getTask() async {
    print("read function is called");
    List<Map<String, dynamic>>? tasks = await DBHelper.readData();

    taskList.assignAll(tasks!.map((e) => LocalDonation.fromJson(e)).toList());
    print("**************************");
    print(taskList.length);
    print("**************************");
    update();
  }

// deleting the task using the specific id
  Future<void> delete({required LocalDonation task}) async {
    var id = await DBHelper.delete(task: task);
    print(id);
    getTask();
  }

// updating the task in the database by id
  Future<void> updateTask(
      {required LocalDonation localDonation, required int id}) async {
    var value = await DBHelper.updateData(id: id, task: localDonation);
    print("****value******");
    print(value);
    getTask();
  }

  Future<void> deleteAll() async {
    var value = await DBHelper.deleteAll();
    print("****deleted ******");
    print(value);
    getTask();
  }
}
