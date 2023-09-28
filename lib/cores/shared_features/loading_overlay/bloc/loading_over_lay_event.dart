part of 'loading_over_lay_bloc.dart';

abstract class LoadingOverlayEvent extends Equatable {
  const LoadingOverlayEvent();

  @override
  List<Object> get props => [];
}

class ShowLoadingOverlayEvent extends LoadingOverlayEvent {}

class HideLoadingOverlayEvent extends LoadingOverlayEvent {}
