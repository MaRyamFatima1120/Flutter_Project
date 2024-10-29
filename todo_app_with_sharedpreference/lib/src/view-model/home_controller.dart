import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var showFilter = false.obs;
  var searchQuery = ''.obs;
  var title = ''.obs;
  var description = ''.obs;
  var filterType =''.obs;

  //Observable List to hold data
  RxList<Map<String, dynamic>> addData = <Map<String, dynamic>>[].obs;
  //Observable List to hold data
  RxList<Map<String, dynamic>> searchData = <Map<String, dynamic>>[].obs;


//Filter
  void showFilterFunction() {
    showFilter.value = !showFilter.value;
  }

  void onChangedFunction(String query) {
    searchQuery.value = query.toLowerCase();
    searchData.value= addData.where((item)=>item['title'].toLowerCase().contains(searchQuery.value)||item['description'].toLowerCase().contains(searchQuery.value)).toList();
    print("Search Query:${searchQuery.value}");
  }

  Future<void> saveData() async {
    if (title.value.isNotEmpty && description.value.isNotEmpty) {
      SharedPreferences prefers = await SharedPreferences.getInstance();

      //// Add new data to addData list
      addData.add({'title': title.value,
        'description': description.value,
        'timeStamp':DateTime.now().toIso8601String(),
        'completed':false
      });

      // Convert addData list to JSON format for SharedPreferences
      String jsonData = jsonEncode(addData);

      // Save the JSON string to SharedPreferences
      await prefers.setString('data', jsonData);
      searchData.value = addData;
      clearFormField();
    } else {
      print("Field is Empty!");
    }
  }

// Clear form fields
  void clearFormField() {
    title.value = '';
    description.value = '';
  }

  //Retrieve Data
  Future<void> loadData() async {
    SharedPreferences prefers = await SharedPreferences.getInstance();
    String? jsonData = prefers.getString('data');

    if (jsonData != null) {
      List<dynamic> decodeData = jsonDecode(jsonData);
      addData.value = List<Map<String, dynamic>>.from(decodeData);
      searchData.value = addData;
    }
  }

//Delete Data
  void deleteData(int index) {
    addData.removeAt(index);
    updateSharedPreference();
    searchData.value = addData;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
    searchData.value=addData;
  }


  //editTask
  void editTask(int index, String newTitle, String newDescription) {
    addData[index]['title'] = newTitle;
    addData[index]['description'] = newDescription;
    addData.refresh();
    updateSharedPreference();
  }


  //updateTask
  Future<void> updateSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert addData list to JSON format for SharedPreferences
    String jsonData = jsonEncode(addData);

    // Save the JSON string to SharedPreferences
    await prefs.setString('data', jsonData);
  }

  void toggleTaskCompletion(int index) async {
    addData[index]['completed'] = !(addData[index]['completed'] ?? false);
    addData.refresh(); // Refresh UI after status change
    await updateSharedPreference();
  }


  void applyFilterType(String? type){
    filterType.value=type!;
    if(type=='completed'){
      searchData.value= addData.where((item)=>item['completed']==true).toList();
    }
    else if(type=='pending'){
      searchData.value= addData.where((item)=>item['completed']==false).toList();

    }
    else if(type=='recent'){
      // Sort by timestamp to show recently added tasks first
      List<Map<String, dynamic>> sortedData = List<Map<String, dynamic>>.from(addData);
      sortedData.sort((a, b) => DateTime.parse(b['timeStamp']).compareTo(DateTime.parse(a['timeStamp'])));
      searchData.value = sortedData;

    }
    else {
      searchData.value = addData;
    }
  }
}
