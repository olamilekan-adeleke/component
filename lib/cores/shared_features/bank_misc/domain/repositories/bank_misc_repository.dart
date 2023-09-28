import 'package:fpdart/fpdart.dart';

import '../../../../base_request_body/base_request_body.dart';
import '../../../../failures/base.dart';
import '../../data/models/get_nigeria_bank_model.dart';
import '../../data/models/resolved_bank_account_model.dart';

abstract class BankMiscRepository {
  Future<Either<Failures, GetNigeriaBankModel>> getNigerianBanks();

  Future<Either<Failures, ResolveBankModel>> resolveBankAccount(
    RequestParam requestParam,
  );
}
