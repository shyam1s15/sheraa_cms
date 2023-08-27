part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class InitialAppEvent extends AppEvent {
  
}

class LoadUsersAppEvent extends AppEvent {}

class LoadProductsAppEvent extends AppEvent {}

class LoadOrdersAppEvent extends AppEvent {}

class LoadCategoriesAppEvent extends AppEvent {}

class LoadCreateProuductScreen extends AppEvent {}

class SaveProductEvent extends AppEvent {
  final ProductDto reqDto;

  SaveProductEvent(this.reqDto);

  @override
  List<Object> get props => [reqDto];
}

class LoadUpdateProductScreen extends AppEvent {
  final String productId;
  LoadUpdateProductScreen(this.productId);

  @override
  List<Object> get props => [productId];
}

class LoadUpdateCategoryScreen extends AppEvent {
  final String categoryId;
  LoadUpdateCategoryScreen(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class LoadCreateCategoryScreen extends AppEvent {}

