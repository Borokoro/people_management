part of 'post_code_cubit.dart';

class PostCodeState extends Equatable{
  const PostCodeState();

  @override
  List<Object> get props => [];
}

class PostCodeLoaded extends PostCodeState{
  final PostCodeDataModel postCodeDataModel;
  const PostCodeLoaded({required this.postCodeDataModel});
}

class PostCodeLoading extends PostCodeState{
  const PostCodeLoading();

  @override
  List<Object> get props => [];
}

class PostCodeError extends PostCodeState{
  const PostCodeError();

  @override
  List<Object> get props => [];
}