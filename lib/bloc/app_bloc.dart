import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sheraa_cms/api/base_api.dart';
import 'package:sheraa_cms/api/categories_api.dart';
import 'package:sheraa_cms/api/obtained_response.dart';
import 'package:sheraa_cms/api/products_api.dart';
import 'package:sheraa_cms/dto/categories_subcategories_list_dto.dart';
import 'package:sheraa_cms/dto/product_dto.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<AppEvent>((event, emit) {
      // TODO: implement event handler
    });

    on <InitialAppEvent>(_loadApplication);

    on<LoadUsersAppEvent>(_loadExistingAppUsers);

    on<LoadOrdersAppEvent>(_loadAppOrders);

    on<LoadProductsAppEvent>(_loadAppProducts);

    on<LoadCategoriesAppEvent>(_loadAppCategories);

    on<LoadCreateProuductScreen>(_loadCreateProductScreen);


    
  }

  FutureOr<void> _loadExistingAppUsers(LoadUsersAppEvent event, Emitter<AppState> emit) {
  }

  FutureOr<void> _loadAppOrders(LoadOrdersAppEvent event, Emitter<AppState> emit) {
  }

  FutureOr<void> _loadAppProducts(LoadProductsAppEvent event, Emitter<AppState> emit) async {
    print("load products state");

    ProductCmsApi api = ProductCmsApi();
    emit(AppLoadingState());
    ObtainedResponse resp = await api.getProducts(0);
    if (resp.result == API_RESULT.FAILED) {
      print("failed to get products");
    } else {
      print("loaded products state");
      emit(ProductsPageState(resp.data as List<ProductDto>));
    }
  }

  FutureOr<void> _loadAppCategories(LoadCategoriesAppEvent event, Emitter<AppState> emit) {
  }

  FutureOr<void> _loadApplication(InitialAppEvent event, Emitter<AppState> emit) {
    // print("initial app state");
    // _loadAppProducts(LoadProductsAppEvent(), emit);
  }

  FutureOr<void> _loadCreateProductScreen(LoadCreateProuductScreen event, Emitter<AppState> emit) async {
    // emit(EmptyScreenState());
    CategoriesApi api = CategoriesApi();
    ObtainedResponse resp = await api.getCategoriesAndSubCategories();
    if (resp.result == API_RESULT.SUCCESS) {
      print("pass product create screen ");
      emit(ProductCreateScreenState(resp.data as CategoriesAndSubcategoriesListDto));
    } else {
      print("failed to get products"); 
    }
  }
}
