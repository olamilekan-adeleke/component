import '../../../../base_request_body/base_request_body.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/http_helper.dart';
import '../models/get_nigeria_bank_model.dart';
import '../models/resolved_bank_account_model.dart';

abstract class BankMiscRemoteDataSource {
  Future<GetNigeriaBankModel> getNigerianBanks();

  Future<ResolveBankModel> resolveBankAccount(RequestParam requestParam);
}

class BankMiscRemoteDataSourceImpl implements BankMiscRemoteDataSource {
  final HttpHelper httpHelper;

  BankMiscRemoteDataSourceImpl({required this.httpHelper});

  @override
  Future<GetNigeriaBankModel> getNigerianBanks() async {
    final Map<String, dynamic> response =
        await httpHelper.get(ApiEndpoints.getNigeriaBanks);

    return GetNigeriaBankModel.fromMap(response);
  }

  @override
  Future<ResolveBankModel> resolveBankAccount(
    RequestParam requestParam,
  ) async {
    final Map<String, dynamic> response = await httpHelper
        .get(ApiEndpoints.resolveBank, query: requestParam.toMap());

    return ResolveBankModel.fromMap(response);
  }
}
