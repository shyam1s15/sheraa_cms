import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheraa_cms/dto/product_dto.dart';

import '../../bloc/app_bloc.dart';

/// Flutter code sample for [ListTile].

// void main() => runApp(const ListTileApp());

// class ListTileApp extends StatelessWidget {
//   const ListTileApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: const ListTileExample(),
//     );
//   }
// }

class ProductListWidget extends StatelessWidget {
  final List<ProductDto>? products;
  ProductListWidget({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    BlocProvider.of<AppBloc>(context).add(LoadCreateProuductScreen());
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
                products != null && products!.length > 0 ?
                Expanded(
                  child: ListView.separated(
                    itemCount: products!.length,
                    itemBuilder: ((context, index) => ProductTile(
                          dto: products![index],
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

class ProductTile extends StatelessWidget {
  final ProductDto dto;
  const ProductTile({super.key, required this.dto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppBloc>(context).add(LoadUpdateProductScreen(dto.id ?? ""));
      },
      child: ListTile(
        leading: CircleAvatar(child: Text('A')),
        title: Text(dto.name ?? ""),
        subtitle: Row(
          children: [
            Text(
              '(${dto.categoryName})',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   '(${dto.subcategoryName})',
            //   style: TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),
            // ),
          ],
        ),
        trailing: Icon(Icons.favorite_rounded),
      ),
    );
  }
}
