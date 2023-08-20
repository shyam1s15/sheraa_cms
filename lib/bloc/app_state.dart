part of 'app_bloc.dart';

enum AppPage { Users, Orders, Products, Categories }

sealed class AppState extends Equatable {
  const AppState();
  
  @override
  List<Object> get props => [];
}

final class AppInitial extends AppState {}
