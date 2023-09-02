part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppChangedBottomNabBarState extends AppState {}

class AppCreateDatabase extends AppState {}
class AppGetDatabase extends AppState {}
class AppInsertDatabase extends AppState {}
class AppUpdateDatabase extends AppState {}
class DeleteFromDatabase extends AppState {}

class AppChangedBottomSheetState extends AppState {}