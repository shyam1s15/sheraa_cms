import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_bloc.dart';
import '../../dto/category_dto.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key, required this.categoryList});
  final List<CategoryDto> categoryList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    BlocProvider.of<AppBloc>(context).add(LoadCreateCategoryScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Set button background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12.0), // Set button border radius
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0), // Set button padding
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white), // Add "+" icon
                      SizedBox(width: 8.0), // Add spacing between icon and text
                      Text(
                        'Create', // Button text
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                categoryList.length > 0 ?
                Expanded(
                  child: ListView.separated(
                    itemCount: categoryList.length,
                    itemBuilder: ((context, index) => CategoryTile(
                          dto: categoryList[index],
                        )),
                    separatorBuilder: ((context, index) =>
                        const Divider(height: 0)),
                  ),
                )
                : Container()
              ],
            ),
        );
  }
}


class CategoryTile extends StatelessWidget {
  final CategoryDto dto;
  const CategoryTile({super.key, required this.dto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppBloc>(context).add(LoadUpdateCategoryScreen(dto.id ?? ""));
      },
      child: ListTile(
        leading: CircleAvatar(child: Text('A')),
        title: Text(dto.name ?? ""),
      //   subtitle: Row(
      //     children: [
      //       Text(
      //         '(${dto.categoryName})',
      //         style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      //       ),
      //       // Text(
      //       //   '(${dto.subcategoryName})',
      //       //   style: TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),
      //       // ),
      //     ],
      //   ),
      //   trailing: Icon(Icons.favorite_rounded),
      // ),
    ));
  }
}
