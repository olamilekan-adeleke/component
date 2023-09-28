import 'package:fpdart/fpdart.dart';

import '../../../../base_request_body/base_request_body.dart';
import '../../../../failures/base.dart';
import '../../../../try_catch_helper/try_catch_helper.dart';
import '../../domain/repositories/bank_misc_repository.dart';
import '../datasources/bank_misc_remote_data_source.dart';
import '../models/get_nigeria_bank_model.dart';
import '../models/resolved_bank_account_model.dart';

class BankMiscRepositoryImpl extends BankMiscRepository {
  final BankMiscRemoteDataSource remoteDataSource;

  BankMiscRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, GetNigeriaBankModel>> getNigerianBanks() async {
    final action = remoteDataSource.getNigerianBanks();

    final repoTryCatchHelper = RepoTryCatchHelper<GetNigeriaBankModel>();
    return await repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, ResolveBankModel>> resolveBankAccount(
    RequestParam requestParam,
  ) async {
    final action = remoteDataSource.resolveBankAccount(requestParam);

    final repoTryCatchHelper = RepoTryCatchHelper<ResolveBankModel>();
    return await repoTryCatchHelper.tryAction(() => action);
  }
}
