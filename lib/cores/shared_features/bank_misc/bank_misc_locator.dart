import '../../../app/locator.dart';
import '../../utils/http_helper.dart';
import 'data/datasources/bank_misc_remote_data_source.dart';
import 'data/repositories/bank_misc_repository_impl.dart';
import 'domain/repositories/bank_misc_repository.dart';
import 'domain/usecases/get_nigeria_bank_usecase.dart';
import 'domain/usecases/resolve_bank_usecase.dart';
import 'presentation/bloc/get_nigeria_banks/get_nigeria_banks_bloc.dart';
import 'presentation/bloc/resolve_bank_account/resolve_bank_account_bloc.dart';

void setUpBankMiscLocator() {
  // Data Sources
  getIt.registerLazySingleton<BankMiscRemoteDataSource>(
    () => BankMiscRemoteDataSourceImpl(httpHelper: getIt<HttpHelper>()),
  );

  // Repositories
  getIt.registerLazySingleton<BankMiscRepository>(
    () => BankMiscRepositoryImpl(
      remoteDataSource: getIt<BankMiscRemoteDataSource>(),
    ),
  );

  // usecase
  getIt.registerLazySingleton(
    () => GetNigerianBanksUsecase(repository: getIt<BankMiscRepository>()),
  );

  getIt.registerLazySingleton(
    () => ResolveBankUsecase(repository: getIt<BankMiscRepository>()),
  );

  // bloc
  getIt.registerLazySingleton(
    () => GetNigeriaBanksBloc(
      getNigerianBanksUsecase: getIt<GetNigerianBanksUsecase>(),
    ),
  );

  getIt.registerFactory(
    () => ResolveBankAccountBloc(
      resolveBankUsecase: getIt<ResolveBankUsecase>(),
    ),
  );
}
