import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheraa_cms/api/base_api.dart';

import 'package:sheraa_cms/api/file_api.dart';
import 'package:sheraa_cms/api/obtained_response.dart';
import 'package:sheraa_cms/api/products_api.dart';
import 'package:sheraa_cms/dto/categories_subcategories_list_dto.dart';
import 'package:sheraa_cms/dto/product_dto.dart';

import '../../bloc/app_bloc.dart';

List<String> productImages = [];

class ProductCreateScreen extends StatefulWidget {
  final CategoriesAndSubcategoriesListDto data;
  const ProductCreateScreen({super.key, required this.data});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final TextEditingController _productNameController = TextEditingController();
  String _category = "0";
  // final TextEditingController _productSubcategoryController =
  //     TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productSummaryController =
      TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productOfferTextController =
      TextEditingController();
  bool is_trending = false;

  @override
  void dispose() {
    _productNameController.dispose();
    // _productSubcategoryController.dispose();
    _productSummaryController.dispose();
    _productDescriptionController.dispose();
    _productOfferTextController.dispose();
    _productPriceController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _category = widget.data.categories[0];
    super.initState();
  }

  // final controller
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(), // Adds the outline border
                // You can customize other properties like labelText, hintText, etc.
              ),
            ),
          ),
          const Divider(height: 0),
          DropdownButton<String>(
            value: widget.data.categories[0], // Default selected value
            onChanged: (String? newValue) {
              // Handle dropdown value change
              _category = newValue ?? "";
              print(newValue);
            },
            items: widget.data.categories.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: _productSubcategoryController,
          //     decoration: InputDecoration(
          //       labelText: 'Product Subcategory',
          //       border: OutlineInputBorder(), // Adds the outline border
          //       // You can customize other properties like labelText, hintText, etc.
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]')), // Only allow numeric input
              ],
              keyboardType: TextInputType.number,
              controller: _productPriceController,
              decoration: InputDecoration(
                labelText: 'Product Price',
                border: OutlineInputBorder(), // Adds the outline border
                // You can customize other properties like labelText, hintText, etc.
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _productSummaryController,
              decoration: InputDecoration(
                labelText: 'Product Summary',
                border: OutlineInputBorder(), // Adds the outline border
                // You can customize other properties like labelText, hintText, etc.
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _productDescriptionController,
              decoration: InputDecoration(
                labelText: 'Product Description',
                border: OutlineInputBorder(), // Adds the outline border
                // You can customize other properties like labelText, hintText, etc.
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _productOfferTextController,
              decoration: InputDecoration(
                labelText: 'Product Offer text',
                border: OutlineInputBorder(), // Adds the outline border
                // You can customize other properties like labelText, hintText, etc.
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  value: is_trending,
                  onChanged: (bool? newValue) {
                    setState(() {
                      is_trending = newValue ?? false;
                    });
                  },
                ),
                SizedBox(width: 10,),
                Text("make it trending?"),
              ],
            ),
          ),
          ImagePickerWidget(),
          ElevatedButton(
            onPressed: () async {
              ProductDto dto = ProductDto(
                  name: _productNameController.text,
                  categoryName: _category,
                  description: _productDescriptionController.text,
                  images: productImages,
                  price: int.parse(_productPriceController.text),
                  summary: _productSummaryController.text,
                  offerText: _productOfferTextController.text,
                  isTrending: is_trending);
              ProductCmsApi api = new ProductCmsApi();
              ObtainedResponse resp = await api.saveProduct(dto);
              if (resp.result == API_RESULT.SUCCESS) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        SizedBox(width: 8),
                        Text("Product Created Successfully"),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
                BlocProvider.of<AppBloc>(context).add(LoadProductsAppEvent());

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check, color: Colors.red),
                        SizedBox(width: 8),
                        Text("Product creation failed"),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Create Product'),
            ),
          ),
        ],
      ),
    ));
  }
}

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  List<PlatformFile> _imageFiles = [];

  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;

  Future<void> _pickImage() async {
    try {
      // Pick an image file using file_picker package
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      // If user cancels the picker, do nothing
      if (result == null) return;

      // If user picks an image, update the state with the new image file
      setState(() {
        // _imageFile = result.files.first;
        _imageFiles.add(result.files.first);
        _uploadImage(result);
      });
    } catch (e) {
      // If there is an error, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> _uploadImage(FilePickerResult? result) async {
    if (result == null) {
      print("failed to upload image");
      return;
    }

    PlatformFile file = result.files.first;

    Uint8List fileBytes = file.bytes!;
    FileUploadCmsApi api = FileUploadCmsApi();
    ObtainedResponse resp = await api.uploadFile(fileBytes);
    if (resp.result == API_RESULT.SUCCESS) {
      productImages.add(resp.data as String);
      print(productImages);
    } else {
      productImages.add("empty"); // TODO: add default image link
    }
    // print(resp.data);
    // Upload the file to Firebase Storage
    // firebase_storage.Reference fileRef = storage.ref().child(fileName);
    // await fileRef.putData(fileBytes);

    // Get the download URL for the uploaded file
    // String downloadURL = await fileRef.getDownloadURL();
    // fileRef

    // print('File uploaded successfully!');
    // print('Download URL: $downloadURL');

    // uploadUint8List(fileBytes, fileName);
  }

  // Future<void> uploadUint8List(Uint8List uint8List, String fileName) async {
  //   final blob = Blob([uint8List]);
  //   // final storageRef = storage.ref().child(fileName);

  //   final uploadTask = storageRef.putBlob(blob);

  //   try {
  //     await uploadTask;
  //     print('Upload complete!');
  //   } catch (e) {
  //     print('Upload failed: $e');
  //   }
  // }

  void _cancelImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
      productImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _imageFiles.isNotEmpty
              ? Row(
                  children: _imageFiles.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.memory(
                            Uint8List.fromList(entry.value.bytes!),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          IconButton(
                              onPressed: () => _cancelImage(entry.key),
                              icon: Icon(Icons.cancel))
                        ],
                      ),
                    );
                  }).toList(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey, // Empty container's color
                  ),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Add Product Images'),
          ),
          SizedBox(height: 20),

        ],
      ),
    );
  }
}
