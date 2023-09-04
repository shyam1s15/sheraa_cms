import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheraa_cms/dto/category_dto.dart';

import '../../api/base_api.dart';
import '../../api/categories_api.dart';
import '../../api/file_api.dart';
import '../../api/obtained_response.dart';
import '../../bloc/app_bloc.dart';

String icon = "";
class CategoryUpdatePage extends StatefulWidget {
  const CategoryUpdatePage({super.key, required this.category});
  final CategoryDto category;

  @override
  State<CategoryUpdatePage> createState() => _CategoryUpdatePageState();
}

class _CategoryUpdatePageState extends State<CategoryUpdatePage> {
  final TextEditingController _categoryNameController = TextEditingController();
  
  final TextEditingController _categoryBgController =
      TextEditingController();
  
  @override
  void initState() {
    this._categoryBgController.text = widget.category.bgColor ?? "#000000";
    this._categoryNameController.text = widget.category.name ?? "";
    icon = widget.category.icon ?? "";
    super.initState();
  }
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
                  id: widget.category.id,
                  name: _categoryNameController.text,
                  icon: icon,
                  bgColor: _categoryBgController.text);
              CategoriesApi api = CategoriesApi();
              ObtainedResponse resp = await api.updateCategory(dto);
              if (resp.result == API_RESULT.SUCCESS) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        SizedBox(width: 8),
                        Text("Category Updated Successfully"),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
                BlocProvider.of<AppBloc>(context).add(LoadCategoriesAppEvent());

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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Update Category'),
            ),
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
          SizedBox(height: 20),

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
      setState(() {
        icon = resp.data as String;      
      });
      print(icon);
    } else {
      icon = "empty"; // TODO: add default image link
    }
  }

}