import 'dart:io';

import 'package:dospace/dospace.dart' as dospace;
import 'package:flutter/foundation.dart';

import '../../../../../app/env.dart';
import '../../../../../app/locator.dart';
import '../../../../entity/base_entity.dart';
import '../../../../exception/base_exception.dart';
import '../../../../utils/utils.dart';

abstract class ImageUploadRemoteDataSource {
  Future<BaseModel> uploadImage(String imagePath);

  Future<List<BaseModel>> uploadMultipleImage(List<String> pathList);
}

class ImageUploadRemoteDataSourceImpl extends ImageUploadRemoteDataSource {
  ImageUploadRemoteDataSourceImpl();

  @override
  Future<BaseModel> uploadImage(String imagePath) async {
    final File docFile = File(imagePath);
    final ENV env = getIt<ENV>();
    await Future.delayed(const Duration(seconds: 1));

    try {
      dospace.Spaces spaces = dospace.Spaces(
        region: env.DIGITAL_OCEAN_REGION,
        accessKey: env.digitalOceanAccessKey,
        secretKey: env.digitalOceanSecretKey,
      );

      String projectName = "Recon";
      String folderName = kDebugMode ? "staging_all_images" : "prod_images";
      String fileName = docFile.path.split('/').last;

      String? etag = await spaces.bucket(projectName).uploadFile(
            '$folderName/$fileName',
            docFile,
            'text/plain',
            dospace.Permissions.public,
          );

      LoggerHelper.log('upload: $etag');
      String uploadedFileUrl =
          "${env.digitalOceanBucketUrl}$folderName/$fileName";

      LoggerHelper.log('url: $uploadedFileUrl');

      await spaces.close();

      // return "uploadedFileUrl";
      return BaseModel(
        state: "success",
        status: 202,
        message: "success",
        data: uploadedFileUrl,
        // "https://media.premiumtimesng.com/wp-content/files/2014/08/National-eID-card_${DateTime.now().toIso8601String()}.jpg",
      );
    } catch (err, s) {
      LoggerHelper.log(err, s);
      throw const BaseFailures(
        message: 'An error occurred uploading the image',
      );
    }
  }

  @override
  Future<List<BaseModel>> uploadMultipleImage(List<String> pathList) async {
    final List<BaseModel> imageUrls = await Future.wait(
      pathList.map((image) => uploadImage(image)),
    );

    return imageUrls;
  }
}
