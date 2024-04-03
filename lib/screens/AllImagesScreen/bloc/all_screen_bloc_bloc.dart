import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_screen_bloc_event.dart';
part 'all_screen_bloc_state.dart';

class AllScreenBlocBloc extends Bloc<AllScreenBlocEvent, AllScreenBlocState> {
  AllScreenBlocBloc() : super(AllScreenBlocInitial()) {
    on<AllScreenBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
