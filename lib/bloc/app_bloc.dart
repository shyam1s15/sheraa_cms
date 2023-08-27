import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sheraa_cms/api/base_api.dart';
import 'package:sheraa_cms/api/categories_api.dart';
import 'package:sheraa_cms/api/obtained_response.dart';
import 'package:sheraa_cms/api/products_api.dart';
import 'package:sheraa_cms/dto/categories_subcategories_list_dto.dart';
import 'package:sheraa_cms/dto/category_dto.dart';
import 'package:sheraa_cms/dto/product_dto.dart';
import 'package:sheraa_cms/ui/products/product_update_screen.dart';

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

    on <LoadUpdateProductScreen>(_loadUpdateProductScreen);

    on<LoadCreateCategoryScreen>(_loadCreateCategoryScreen);

    on<LoadUpdateCategoryScreen>(_loadUpdateCategoryScreen);
    
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
      emit(AppErrorState("failed to get products"));
    } else {
      print("loaded products state");
      emit(ProductsPageState(resp.data as List<ProductDto>));
    }
  }

  FutureOr<void> _loadAppCategories(LoadCategoriesAppEvent event, Emitter<AppState> emit) async {
    emit(AppLoadingState());
    CategoriesApi api = CategoriesApi();
    ObtainedResponse resp = await api.getCategoriesDetailList();
    if (resp.result == API_RESULT.SUCCESS) {
      emit(CategoriesPageState(resp.data as List<CategoryDto>));
    } else {
      print("failed to get categories");
      emit(AppErrorState("failed to get categories"));
    }
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
      emit(EmptyScreenState());
    }
  }

  FutureOr<void> _loadUpdateProductScreen(LoadUpdateProductScreen event, Emitter<AppState> emit) async {
    CategoriesApi catApi = CategoriesApi();
    ObtainedResponse catResp = await catApi.getCategoriesAndSubCategories();

    ProductCmsApi productApi = ProductCmsApi();
    ObtainedResponse productResp = await productApi.getProduct(event.productId);

    if (catResp.result == API_RESULT.SUCCESS && productResp.result == API_RESULT.SUCCESS) {
      emit(ProductUpdateScreenState(catResp.data as CategoriesAndSubcategoriesListDto, productResp.data as ProductDto));
    } else {
      print("error loading existing product");  
      emit(EmptyScreenState());
    }

  }

  FutureOr<void> _loadCreateCategoryScreen(LoadCreateCategoryScreen event, Emitter<AppState> emit) {
    emit((CategoryCreateScreenState()));
  }

  FutureOr<void> _loadUpdateCategoryScreen(LoadUpdateCategoryScreen event, Emitter<AppState> emit) async {
    CategoriesApi api = CategoriesApi();
    print(event.categoryId);
    ObtainedResponse resp = await api.getCategory(event.categoryId);
    if (resp.result == API_RESULT.SUCCESS) {
      emit(CategoryUpdateScreenState(resp.data as CategoryDto));
    } else {
      print(resp.data as String);  
      emit(AppErrorState("error loading existing category"));
    }

  }
}
