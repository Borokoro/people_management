import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:people_managment/core/error/failures.dart';
import 'package:people_managment/features/post_code/data/models/post_code_data_model.dart';
import 'package:people_managment/features/post_code/domain/usecases/get_post_code_data_usecase.dart';

part 'post_code_state.dart';

class PostCodeCubit extends Cubit<PostCodeState> {
  final GetPostCodeDataUseCase getPostCodeDataUseCase;
  PostCodeCubit({required this.getPostCodeDataUseCase})
      : super(const PostCodeState());

  void getPostCodeData(String postCode) async {
    emit(const PostCodeLoading());
    final Either<Failure, PostCodeDataModel> result =
        await getPostCodeDataUseCase.call(postCode);
    result.fold((l) => emit(const PostCodeError()),
        (r) => emit(PostCodeLoaded(postCodeDataModel: r)));
  }
}
