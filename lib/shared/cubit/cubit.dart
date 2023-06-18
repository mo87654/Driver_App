import 'package:bloc/bloc.dart';
import 'package:driver_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());
  static AppCubit get(context)=>BlocProvider.of(context);

}