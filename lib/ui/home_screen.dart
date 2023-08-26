import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheraa_cms/bloc/app_bloc.dart';
import 'package:sheraa_cms/dto/categories_subcategories_list_dto.dart';
import 'package:sheraa_cms/dto/product_dto.dart';
import 'package:sheraa_cms/ui/products/product_create_screen.dart';
import 'package:sheraa_cms/ui/products/product_list.dart';
import 'package:sheraa_cms/ui/products/product_update_screen.dart';

/// Flutter code sample for [NavigationRail].

// void main() => runApp(const NavigationRailExampleApp());

class NavigationRailExampleApp extends StatelessWidget {
  const NavigationRailExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeD,
      home: NavRailExample(),
    );
  }
}

class NavRailExample extends StatefulWidget {
  const NavRailExample({super.key});

  @override
  State<NavRailExample> createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: groupAlignment,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
                if (_selectedIndex == 1) {
                  BlocProvider.of<AppBloc>(context).add(LoadProductsAppEvent());
                }

              });
            },
            labelType: labelType,
            leading: showLeading
                ? FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Icon(Icons.add),
                  )
                : const SizedBox(),
            trailing: showTrailing
                ? IconButton(
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    icon: const Icon(Icons.more_horiz_rounded),
                  )
                : const SizedBox(),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart),
                selectedIcon: Icon(Icons.shopping_cart_checkout),
                label: Text('Orders'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.local_offer),
                selectedIcon: Icon(Icons.book),
                label: Text('Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.contacts),
                selectedIcon: Icon(Icons.contacts),
                label: Text('Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.category),
                selectedIcon: Icon(Icons.category),
                label: Text('Categories'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.

          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state is AppInitial) {
                return Container(child: Text("data"),);
              } else if (state is AppErrorState) {
                return Container(child: Text(state.error),);
              } else if (state is AppLoadingState) {
                return Container(child: Text("App is loading please wait"),);
              } else if (state is ProductsPageState) {
                return ProductListWidget(products: state.products);
              } else if (state is ProductCreateScreenState) {
                return ProductCreateScreen(data: state.data as CategoriesAndSubcategoriesListDto);
              } else if (state is ProductUpdateScreenState) {
                return ProductUpdateScreen(product: state.product as ProductDto, categories: state.categories as CategoriesAndSubcategoriesListDto);
              }
              else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
