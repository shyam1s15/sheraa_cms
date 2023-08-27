import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sheraa_cms/dto/category_dto.dart';

import '../../api/base_api.dart';
import '../../api/categories_api.dart';
import '../../api/file_api.dart';
import '../../api/obtained_response.dart';

String icon = "";
class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({super.key});

  @override
  State<CategoryCreatePage> createState() => _CategoryCreatePageState();
}

class _CategoryCreatePageState extends State<CategoryCreatePage> {
  final TextEditingController _categoryNameController = TextEditingController();
  
  final TextEditingController _categoryBgController =
      TextEditingController();
  
  @override
  void dispose() {
    _categoryNameController.dispose();
    // _productSubcategoryController.dispose();
    _categoryBgController.dispose();
    super.dispose();
  }

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
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(), // Adds the outline border
                // You can customize other properties like labelText, hintText, etc.
              ),
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _categoryBgController,
              decoration: InputDecoration(
                labelText: 'Backgroud color',
                border: OutlineInputBorder(), // Adds the outline border
                // You can customize other properties like labelText, hintText, etc.
              ),
            ),
          ),
          const Divider(height: 0),
          
          CategoryImageUpload(),

          ElevatedButton(
            onPressed: () async {
              CategoryDto dto = CategoryDto(
                  name: _categoryNameController.text,
                  bgColor: _categoryBgController.text);
              CategoriesApi api = new CategoriesApi();
              ObtainedResponse resp = await api.saveCategory(dto);
              if (resp.result == API_RESULT.SUCCESS) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        SizedBox(width: 8),
                        Text("Category Created Successfully"),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check, color: Colors.red),
                        SizedBox(width: 8),
                        Text("Category creation failed"),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Text('Create Category'),
          ),
        ],
      ),
    ));
  }
}

class CategoryImageUpload extends StatefulWidget {
  const CategoryImageUpload({super.key});

  @override
  State<CategoryImageUpload> createState() => _CategoryImageUploadState();
}

class _CategoryImageUploadState extends State<CategoryImageUpload> {
  late PlatformFile _imageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon.isNotEmpty
              ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            icon,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          IconButton(
                              onPressed: ()  {
                                setState(() {
                                  icon = "";
                                });
                              },
                              icon: Icon(Icons.cancel))
                        ],
                      ),
                    )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey, // Empty container's color
                  ),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Add Category Icons'),
          ),
        ],
      ),
    );
  }

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
        // _imageFiles.add(result.files.first);
        _imageFile = result.files.first;
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
      icon = resp.data as String;
      print(icon);
    } else {
      icon = "empty"; // TODO: add default image link
    }
  }

}