import 'dart:typed_data';
import 'package:charity_app/Model/local_storage_donation_model.dart';
import 'package:charity_app/Screens/auth_screens/signin_screen.dart';
import 'package:charity_app/constaints.dart';
import 'package:charity_app/controllers/add_donation_controller.dart';
import 'package:charity_app/controllers/pick_image_controller.dart';
import 'package:charity_app/services/firebase_auth/firebase_auth.dart';
import 'package:charity_app/utils/validations/form_field_validation.dart';
import 'package:charity_app/widgets/tabular_data/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/local_donation_controller.dart';
import '../../../services/firebase_methods/firebase_methods.dart';
import '../../../theme.dart';
import '../../../widgets/app_logo_text.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/default_button.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({Key? key}) : super(key: key);

  @override
  State<AddDonation> createState() => _AddDonationState();
}
//noumana@devnatives.com

class _AddDonationState extends State<AddDonation> {
  bool chkdonation = false;
  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.person,
  ];

  int _selectedIndex = 0;
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
  PageController _pageController = PageController();
  bool isUpdate = false;
  Uint8List? image;
  String? showImageMessage;
  bool isPicked = true;
  @override
  Widget build(BuildContext context) {
    Get.put(AddMoreList());
    Get.put(PickImage());
    Get.find<LocalDonationController>().getTask();
    // MY-LIST

    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? primaryDarkClr : Colors.white,
        appBar: AppBar(
          backgroundColor:
              Get.isDarkMode ? primaryDarkBorderClr : Colors.orange,
          title: const Text(
            "Add Doantion",
            style: TextStyle(),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Get.isDarkMode
                        ? primaryDarkBorderClr
                        : primaryLightClr)),
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
        body: PageView(
          controller: _pageController,
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    // APP-LOGO APP-TITLE-TEXT
                    AppLogoText(),
                    MyForm(),
                    SizedBox(height: 12.h),

                    GetBuilder<LocalDonationController>(
                        builder: (localdonation) {
                      return GetBuilder<AddMoreList>(builder: (value) {
                        return Column(
                          children: [
                            localdonation.taskList.isNotEmpty
                                ? CustomTable(
                                    isHeader: true,
                                    actions: Text(
                                      "Actions",
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.teal
                                              : primaryLightClr),
                                    ),
                                    category: "Category",
                                    name: "Name",
                                    quantity: "Qty")
                                : const SizedBox(),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: localdonation.taskList.length,
                              itemBuilder: (context, index) {
                                return CustomTable(
                                  actions: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          print("the task list is " +
                                              localdonation.taskList
                                                  .toString());
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("My title"),
                                                content: const Text(
                                                    "This is my message."),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Cancel"),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                  ),
                                                  GetBuilder<
                                                          LocalDonationController>(
                                                      builder: (value) {
                                                    return TextButton(
                                                      child:
                                                          const Text("Delete"),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        await value.delete(
                                                            task: Get.find<
                                                                    LocalDonationController>()
                                                                .taskList[index]);
                                                        setState(() {});

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "Deleted Scucessfully!")));
                                                      },
                                                    );
                                                  }),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Icon(Icons.delete),
                                      ),
                                      SizedBox(
                                        width: 2.w,
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
                                  category: localdonation
                                      .taskList[index].category
                                      .toString(),
                                  name: localdonation.taskList[index].itemName
                                      .toString(),
                                  quantity: localdonation
                                      .taskList[index].quantity
                                      .toString(),
                                );
                              },
                            ),
                          ],
                        );
                      });
                    }),
                  ],
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 4, 31, 48),
              ),
            ),
            const Center(
              child: Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 4, 31, 48),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: customNavigationBar(
        //     selectedIndex: _selectedIndex, onItemTapped: _onItemTapped)
        // bottomNavigationBar: fancyBar(ontap: _onItemTapped),
      ),
    );
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
              preIcon: Icons.title,
              mycontroller: _userTitleController,
              validator: requiredValidator,
            ),
            myTextField(
              hintText: "Description",
              preIcon: Icons.description,
              mycontroller: _userDonationDescriptionController,
              validator: requiredValidator,
            ),
            myTextField(
              hintText: "PickUp location",
              preIcon: Icons.location_city_rounded,
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
                Get.find<LocalDonationController>().taskList.isEmpty
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
                            },
                          ),
                Get.find<LocalDonationController>().taskList.isEmpty
                    ? DefaultButton(
                        text: "Cancel",
                        onPressed: null,
                      )
                    : DefaultButton(
                        text: "Cancel",
                        onPressed: () async {
                          await Get.find<LocalDonationController>().deleteAll();
                          LocalDonation localDonation = LocalDonation(
                              null,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              Get.find<PickImage>().image,
                              '',
                              '',
                              '');
                          setState(() {
                            _userDonationDescriptionController.clear();
                            _userTitleController.clear();
                            _userAddressController.clear();
                            Get.find<LocalDonationController>()
                                .delete(task: localDonation);
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
        text: Get.find<LocalDonationController>().taskList[value!].itemName);
    final TextEditingController _userCategoryUpdate = TextEditingController(
        text: Get.find<LocalDonationController>().taskList[value].category);
    final TextEditingController _userQuantityUpdate = TextEditingController(
        text: Get.find<LocalDonationController>().taskList[value].quantity);

    final TextEditingController _descUpdate = TextEditingController(
        text: Get.find<LocalDonationController>().taskList[value].description);

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
                      preIcon: Icons.add,
                      mycontroller: _userItemUpdate,
                      validator: requiredValidator,
                    ),
                    myTextField(
                      hintText: "Category",
                      preIcon: Icons.category,
                      mycontroller: _userCategoryUpdate,
                      validator: requiredValidator,
                    ),
                    myTextField(
                      hintText: "Quantity",
                      preIcon: Icons.numbers,
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
                                        ),
                                      )
                                    : const Text("image selected!"),
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
                      preIcon: Icons.details,
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
                              onPressed: () async {
                                if (_alertFormKey.currentState!.validate()) {
                                  Get.back();

                                  // UPDATING - LIST - IN - SQL
                                  await Get.find<LocalDonationController>()
                                      .updateTask(
                                          id: Get.find<
                                                  LocalDonationController>()
                                              .taskList[value]
                                              .id!,
                                          localDonation: LocalDonation(
                                            null,
                                            _userTitleController.text,
                                            '',
                                            _userItemUpdate.text,
                                            _userCategoryUpdate.text,
                                            _userQuantityUpdate.text,
                                            '',
                                            Get.find<PickImage>().image,
                                            _descUpdate.text,
                                            '',
                                            '',
                                          ));

                                  Get.find<LocalDonationController>()
                                      .taskList[value]
                                      .title = _userTitleController.text;
                                  Get.find<LocalDonationController>()
                                      .taskList[value]
                                      .itemName = _userItemUpdate.text;
                                  Get.find<LocalDonationController>()
                                      .taskList[value]
                                      .category = _userCategoryUpdate.text;
                                  Get.find<LocalDonationController>()
                                      .taskList[value]
                                      .quantity = _userQuantityUpdate.text;
                                  Get.find<LocalDonationController>()
                                      .taskList[value]
                                      .description = _descUpdate.text;

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
                      preIcon: Icons.add,
                      mycontroller: _itemNameController,
                      validator: requiredValidator,
                    ),
                    myTextField(
                      hintText: "Category",
                      preIcon: Icons.category,
                      mycontroller: _categoryController,
                      validator: requiredValidator,
                    ),
                    myTextField(
                      hintText: "Quantity",
                      preIcon: Icons.numbers,
                      mycontroller: _quantityController,
                      validator: requiredValidator,
                      keyboardType: TextInputType.number,
                    ),

                    // add attachement
                    GetBuilder<PickImage>(builder: (value) {
                      return TextFormField(
                        controller: _attachmentController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Add Attachment",
                          hintStyle: textInputStyle,
                          prefixIcon: GestureDetector(
                            onTap: () async {
                              await value.pickmyImage();
                              _attachmentController.text = "Image is Selected";
                            },
                            child: Icon(
                              Icons.attach_file,
                              color: Get.isDarkMode
                                  ? Colors.teal
                                  : primaryLightClr,
                            ),
                          ),
                          focusedBorder: outlineBorder(),
                          enabledBorder: outlineBorder(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        validator: requiredValidator,
                      );
                    }),
                    SizedBox(
                      height: 16.h,
                    ),
                    myTextField(
                      hintText: "Description",
                      preIcon: Icons.details,
                      mycontroller: _itemDescriptionController,
                      validator: requiredValidator,
                    ),
                    GetBuilder<LocalDonationController>(
                        builder: (localDonationController) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GetBuilder<AddMoreList>(
                            builder: (addList) {
                              return isUpdate == false
                                  ? DefaultButton(
                                      text: 'Save',
                                      onPressed: () async {
                                        if (_alertFormKey.currentState!
                                            .validate()) {
                                          if (Get.find<PickImage>().image !=
                                              null) {
                                            Get.back();
                                            final row = await localDonationController
                                                .addTask(
                                                    task: LocalDonation(
                                                        null,
                                                        _userTitleController
                                                            .text,
                                                        _userDonationDescriptionController
                                                            .text,
                                                        _itemNameController
                                                            .text,
                                                        _categoryController
                                                            .text,
                                                        _quantityController
                                                            .text,
                                                        _userAddressController
                                                            .text,
                                                        Get.find<PickImage>()
                                                            .image,
                                                        _itemDescriptionController
                                                            .text,
                                                        DateTime.now()
                                                            .toString(),
                                                        "pending"));

                                            print(row);
                                            addList.addToList(
                                              donationDescription:
                                                  _userDonationDescriptionController
                                                      .text,
                                              title: _userTitleController.text,
                                              itemName:
                                                  _itemNameController.text,
                                              quantity:
                                                  _quantityController.text,
                                              description:
                                                  _itemDescriptionController
                                                      .text,
                                              pickUpLocation:
                                                  _userAddressController.text,
                                              attachment:
                                                  Get.find<PickImage>().image!,
                                              category:
                                                  _categoryController.text,
                                            );

                                            _itemNameController.clear();
                                            _categoryController.clear();
                                            _quantityController.clear();
                                            _itemDescriptionController.clear();
                                            _attachmentController.clear();
                                            Get.find<PickImage>().clear();
                                          } else {}
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
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        radius: 10.0);
  }

  void _onItemTapped(int myindex) {
    setState(() {
      _selectedIndex = myindex;
      _pageController.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  FirebsaeMethods firebsaeMethods = FirebsaeMethods();
  bool loading = false;
  // SUBMITING-TO-DATABASE
  submit() async {
    String res = "Some error occured";
    setState(() {
      loading = true;
    });
    for (var i = 0;
        i < Get.find<LocalDonationController>().taskList.length;
        i++) {
      res = await firebsaeMethods.addDonation(
        date: DateTime.now(),
        title: Get.find<LocalDonationController>().taskList[i].title.toString(),
        name:
            Get.find<LocalDonationController>().taskList[i].itemName.toString(),
        quantity:
            Get.find<LocalDonationController>().taskList[i].quantity.toString(),
        description: Get.find<LocalDonationController>()
            .taskList[i]
            .description
            .toString(),
        category:
            Get.find<LocalDonationController>().taskList[i].category.toString(),
        pickUpLocation:
            Get.find<LocalDonationController>().taskList[i].pickup.toString(),
        donationDescription: Get.find<LocalDonationController>()
            .taskList[i]
            .itemDescription
            .toString(),
        attachment:
            Get.find<LocalDonationController>().taskList[i].attachement!,
      );
    }
    if (res == 'success') {
      setState(() {
        // Get.find<AddMoreList>().list.clear();
        _userTitleController.clear();
        _userDonationDescriptionController.clear();
        _userAddressController.clear();
      });
      await Get.find<LocalDonationController>().deleteAll();
    } else {
      setState(() {
        _userTitleController.clear();
        _userDonationDescriptionController.clear();
        _userAddressController.clear();
      });
      Get.snackbar('Message', res.toString());
    }
    Get.snackbar('Message', "Donated Successfully");
    setState(() {
      loading = false;
    });
    Get.find<AddMoreList>().list.clear();
  }
}
