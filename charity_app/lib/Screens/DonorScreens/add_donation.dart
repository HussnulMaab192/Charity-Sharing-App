import 'dart:typed_data';
import 'package:charity_app/Screens/auth_screens/signin_screen.dart';
import 'package:charity_app/controllers/add_donation_controller.dart';
import 'package:charity_app/controllers/pick_image_controller.dart';
import 'package:charity_app/services/firebase_auth/firebase_auth.dart';
import 'package:charity_app/utils/validations/form_field_validation.dart';
import 'package:charity_app/widgets/tabular_data/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/firebase_methods/firebase_methods.dart';

import '../../widgets/app_logo_text.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/default_button.dart';
import '../../widgets/show_alert_diaoluge.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({Key? key}) : super(key: key);

  @override
  State<AddDonation> createState() => _AddDonationState();
}
//noumana@devnatives.com

class _AddDonationState extends State<AddDonation> {
  final _alertFormKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userTitleController = TextEditingController();
  final TextEditingController _userDonationDescriptionController =
      TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _userAddressController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _attachmentController = TextEditingController();
  final TextEditingController _addItemDescriptionController =
      TextEditingController();
  bool isUpdate = false;
  Uint8List? image;
  String? showImageMessage;
  @override
  Widget build(BuildContext context) {
    Get.put(AddMoreList());
    Get.put(PickImage());
    // MY-LIST
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Add Doantion"),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Firebaseauth firebaseauth = Firebaseauth();
                String res = await firebaseauth.signOut();
                if (res == 'success') {
                  Get.to(const SignIn());
                } else {
                  return;
                }
              },
              child: const Text("log out "))
        ],
      ),
      drawer: MyDrawer(context),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              // APP-LOGO APP-TITLE-TEXT
              AppLogoText(),
              MyForm(),
              SizedBox(height: 12.h),

              GetBuilder<AddMoreList>(builder: (value) {
                return Column(
                  children: [
                    value.list.isNotEmpty
                        ? const CustomTable(
                            actions: Text("Actions"),
                            category: "Category",
                            name: "Name",
                            quantity: "Qty")
                        : SizedBox(),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: value.list.length,
                      itemBuilder: (context, index) {
                        return CustomTable(
                            actions: Row(
                              children: [
                                Obx(() => 
                                GestureDetector(
                                  onTap: () async {
                                    await showAlertDialog(
                                        context: context, index: index);

                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Deleted Scucessfully!")));
                                  },
                                  child: const Icon(Icons.delete),
                                ),),
                                SizedBox(
                                  width: 6.w,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await newMethod(
                                      value: index,
                                    );
                                  },
                                  child: const Icon(Icons.edit),
                                ),
                              ],
                            ),
                            category: value.list[index]['category'],
                            name: value.list[index]['itemName'],
                            quantity: value.list[index]['quantity']);
                      },
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    ));
  }

// TEXT-FORM-FIELDS
  Widget MyForm() {
    return GetBuilder<AddMoreList>(builder: (value) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            myTextField(
              hintText: "Donation Title",
              preIcon: const Icon(Icons.title),
              mycontroller: _userTitleController,
              validator: requiredValidator,
            ),
            myTextField(
              hintText: "Description",
              preIcon: const Icon(Icons.description),
              mycontroller: _userDonationDescriptionController,
              validator: requiredValidator,
            ),
            myTextField(
              hintText: "PickUp location",
              preIcon: const Icon(Icons.location_city_rounded),
              mycontroller: _userAddressController,
              validator: requiredValidator,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultButton(
                  text: "Add Item",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //

                      await showDiaLog();
                    } else {
                      Get.snackbar("Message", "All Field required.");
                    }
                  },
                ),
                value.list.isEmpty
                    ? DefaultButton(
                        text: "Donate",
                        onPressed: null,
                      )
                    : loading
                        ? const Center(child: CircularProgressIndicator())
                        : DefaultButton(
                            text: "Donate",
                            onPressed: () async {
                              await submit();

                              Get.find<AddMoreList>().list.clear();
                              _userTitleController.clear();
                              _userDonationDescriptionController.clear();
                              _userAddressController.clear();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Donated Succesfully!")));
                            },
                          ),
                value.list.isEmpty
                    ? DefaultButton(
                        text: "Cancel",
                        onPressed: null,
                      )
                    : DefaultButton(
                        text: "Cancel",
                        onPressed: () async {
                          setState(() {
                            _userDonationDescriptionController.clear();
                            _userTitleController.clear();
                            _userAddressController.clear();
                            Get.find<AddMoreList>().list.clear();
                          });
                        },
                      ),
              ],
            ),
          ],
        ),
      );
    });
  }

  newMethod({
    int? value,
  }) async {
    final TextEditingController _userItemUpdate = TextEditingController(
        text: Get.find<AddMoreList>().list[value!]['itemName']);
    final TextEditingController _userCategoryUpdate = TextEditingController(
        text: Get.find<AddMoreList>().list[value]['category']);
    final TextEditingController _userQuantityUpdate = TextEditingController(
        text: Get.find<AddMoreList>().list[value]['quantity']);

    final TextEditingController _descUpdate = TextEditingController(
        text: Get.find<AddMoreList>().list[value]['description']);

    Get.defaultDialog(
        title: '',
        content: Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _alertFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppLogoText(),
                    SizedBox(
                      height: 30.0.h,
                    ),
                    myTextField(
                      hintText: "Item Name",
                      preIcon: const Icon(Icons.add),
                      mycontroller: _userItemUpdate,
                      validator: requiredValidator,
                    ),
                    myTextField(
                      hintText: "Category",
                      preIcon: const Icon(Icons.category),
                      mycontroller: _userCategoryUpdate,
                      validator: requiredValidator,
                    ),
                    myTextField(
                      hintText: "Quantity",
                      preIcon: const Icon(Icons.numbers),
                      mycontroller: _userQuantityUpdate,
                      validator: requiredValidator,
                    ),

                    // add attachement
                    GetBuilder<PickImage>(builder: (value) {
                      return GestureDetector(
                        onTap: () async {
                          await value.pickmyImage();
                        },
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border:
                                  Border.all(color: Colors.orange, width: 1)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 18.r, horizontal: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.attach_file,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                value.image == null
                                    ? const Text(
                                        "Add attachment ",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Rubik Medium",
                                            color: Colors.black),
                                      )
                                    : Text("image selected!"),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 16.h,
                    ),
                    myTextField(
                      hintText: "Description",
                      preIcon: const Icon(Icons.details),
                      mycontroller: _descUpdate,
                      validator: requiredValidator,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GetBuilder<AddMoreList>(
                          builder: (addList) {
                            return DefaultButton(
                              text: 'Update',
                              onPressed: () {
                                if (_alertFormKey.currentState!.validate()) {
                                  Get.back();

                                  Get.find<AddMoreList>().list[value]["title"] =
                                      _userTitleController.text;
                                  Get.find<AddMoreList>().list[value]
                                      ["itemName"] = _userItemUpdate.text;
                                  Get.find<AddMoreList>().list[value]
                                      ["category"] = _userCategoryUpdate.text;
                                  Get.find<AddMoreList>().list[value]
                                      ["quantity"] = _userQuantityUpdate.text;
                                  Get.find<AddMoreList>().list[value]
                                      ["description"] = _descUpdate.text;

                                  _itemNameController.clear();
                                  _categoryController.clear();
                                  _quantityController.clear();
                                  _itemDescriptionController.clear();
                                  _attachmentController.clear();
                                  Get.find<PickImage>().clear();
                                }
                              },
                            );
                          },
                        ),
                        DefaultButton(
                            text: 'Cancel',
                            onPressed: () {
                              Get.back();
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        radius: 10.0);
  }

  showDiaLog() async {
    Get.defaultDialog(
        title: '',
        content: Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _alertFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppLogoText(),
                    SizedBox(
                      height: 30.0.h,
                    ),
                    myTextField(
                      hintText: "Item Name",
                      preIcon: const Icon(Icons.add),
                      mycontroller: _itemNameController,
                      validator: requiredValidator,
                    ),
                    myTextField(
                      hintText: "Category",
                      preIcon: const Icon(Icons.category),
                      mycontroller: _categoryController,
                      validator: requiredValidator,
                    ),
                    myTextField(
                      hintText: "Quantity",
                      preIcon: const Icon(Icons.numbers),
                      mycontroller: _quantityController,
                      validator: requiredValidator,
                    ),

                    // add attachement
                    GetBuilder<PickImage>(builder: (value) {
                      return GestureDetector(
                        onTap: () async {
                          await value.pickmyImage();
                        },
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border:
                                  Border.all(color: Colors.orange, width: 1)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 18.r, horizontal: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.attach_file,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                value.image == null
                                    ? const Text(
                                        "Add attachment ",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Rubik Medium",
                                            color: Colors.black),
                                      )
                                    : Text("image selected!"),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 16.h,
                    ),
                    myTextField(
                      hintText: "Description",
                      preIcon: const Icon(Icons.details),
                      mycontroller: _itemDescriptionController,
                      validator: requiredValidator,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GetBuilder<AddMoreList>(
                          builder: (addList) {
                            return isUpdate == false
                                ? DefaultButton(
                                    text: 'Save',
                                    onPressed: () {
                                      if (_alertFormKey.currentState!
                                          .validate()) {
                                        Get.back();
                                        addList.addToList(
                                          donationDescription:
                                              _userDonationDescriptionController
                                                  .text,
                                          title: _userTitleController.text,
                                          itemName: _itemNameController.text,
                                          quantity: _quantityController.text,
                                          description:
                                              _itemDescriptionController.text,
                                          pickUpLocation:
                                              _userAddressController.text,
                                          attachment:
                                              Get.find<PickImage>().image!,
                                          category: _categoryController.text,
                                        );

                                        _itemNameController.clear();
                                        _categoryController.clear();
                                        _quantityController.clear();
                                        _itemDescriptionController.clear();
                                        _attachmentController.clear();
                                        Get.find<PickImage>().clear();
                                      }
                                    },
                                  )
                                : DefaultButton(
                                    text: "Update", onPressed: () {});
                          },
                        ),
                        DefaultButton(
                            text: 'Cancel',
                            onPressed: () {
                              Get.back();
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        radius: 10.0);
  }

  FirebsaeMethods firebsaeMethods = FirebsaeMethods();
  bool loading = false;
  // SUBMITING-TO-DATABASE
  submit() async {
    setState(() {
      loading = true;
    });
    for (var i = 0; i < Get.find<AddMoreList>().list.length; i++) {
      String res = await firebsaeMethods.addDonation(
        title: Get.find<AddMoreList>().list[i]['title'],
        name: Get.find<AddMoreList>().list[i]['itemName'],
        quantity: Get.find<AddMoreList>().list[i]['quantity'],
        description: Get.find<AddMoreList>().list[i]['description'],
        category: Get.find<AddMoreList>().list[i]['category'],
        pickUpLocation: Get.find<AddMoreList>().list[i]['pickUpLocation'],
        donationDescription: Get.find<AddMoreList>().list[i]
            ['donationDescription'],
        attachment: Get.find<AddMoreList>().list[i]['attachment'],
      );
      if (res == 'success') {
        setState(() {
          loading = false;
        });
        Get.snackbar('Message', 'Successfully');
      } else {
        setState(() {
          loading = false;
        });
        Get.snackbar('Message', res.toString());
      }
    }
  }
}
