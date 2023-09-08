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
class OrdersPageState extends AppState {
  List<OrderDetailDto> orderList;

  OrdersPageState(this.orderList);

  @override
  List<Object> get props => [orderList];
}

class OrderDetailPageLoadedState extends AppState {
  OrderDetailDto orderDto;

  OrderDetailPageLoadedState(this.orderDto);

  @override
  List<Object> get props => [orderDto];
}
class ProductsPageState extends AppState {
  final List<ProductDto> products;

  ProductsPageState(this.products);

  @override
  List<Object> get props => [products];
}
class CategoriesPageState extends AppState {
  final List<CategoryDto> categories;

  CategoriesPageState(this.categories);

  @override
  List<Object> get props => [categories]; 
}

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

class CategoryCreateScreenState extends AppState {

}

class CategoryUpdateScreenState extends AppState {
  final CategoryDto category;

  CategoryUpdateScreenState(this.category);
  @override
  List<Object> get props => [category];
}

