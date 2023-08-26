part of 'app_bloc.dart';

enum AppPage { Users, Orders, Products, Categories }

sealed class AppState extends Equatable {
  const AppState();
  
  @override
  List<Object> get props => [];
}

final class AppInitial extends AppState {}

class AppLoadingState extends AppState {

}

class UsersPageState extends AppState {}
class OrdersPageState extends AppState {}
class ProductsPageState extends AppState {
  final List<ProductDto> products;

  ProductsPageState(this.products);

  @override
  List<Object> get props => [products];
}
class CategoriesPageState extends AppState {}

class AppErrorState extends AppState {
  final String error;

  const AppErrorState(this.error);
  
  @override
  List<Object> get props => [error];
}

class EmptyScreenState extends AppState {}

class ProductCreateScreenState extends AppState {
  final CategoriesAndSubcategoriesListDto data;

  const ProductCreateScreenState(this.data);
  @override
  List<Object> get props => [data];
}

class ProductUpdateScreenState extends AppState {
  final CategoriesAndSubcategoriesListDto categories;
  final ProductDto product;

  ProductUpdateScreenState(this.categories, this.product);

  @override
  List<Object> get props => [categories, product];
}