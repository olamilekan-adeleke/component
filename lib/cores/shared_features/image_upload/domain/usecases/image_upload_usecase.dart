import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../entity/base_entity.dart';
import '../../../../failures/base.dart';
import '../../../../usecase/usecase_interface.dart';
import '../repositories/image_upload_repository.dart';

class ImageUploadUsecase
    extends UseCaseFuture<Failures, BaseEntity, ImageUploadParams> {
  final ImageUploadRepository _imageUploadRepository;

  ImageUploadUsecase(this._imageUploadRepository);

  @override
  Future<Either<Failures, BaseEntity>> call(ImageUploadParams params) async {
    return await _imageUploadRepository.uploadImage(params.imagePath);
  }
}

class ImageUploadParams extends Equatable {
  final String imagePath;

  const ImageUploadParams(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}
