import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../app/locator.dart';
import '../../../features/authentication/presentation/pages/verify_mobile/create_pin_view.dart';
import '../../../features/profile/presentation/bloc/get_profile/get_profile_bloc.dart';
import '../../constants/color.dart';
import '../../navigator/navigator.dart';
import '../../shared_session/authentication_local_storage_data_source.dart';
import '../../utils/utils.dart';
import '../components.dart';
import 'widget/pin_pad_widget.dart';

class EnterPinView extends StatefulWidget {
  static const String routeName = "/enterPin";
  final bool showBiometric;

  const EnterPinView({super.key, this.showBiometric = true});

  @override
  State<EnterPinView> createState() => _EnterPinViewState();
}

class _EnterPinViewState extends State<EnterPinView> {
  late TextEditingController _controller;
  static final GetProfileBloc _getProfileBloc = getIt<GetProfileBloc>();
  final AuthLocalStorageDataSource authLocalStorageDataSourceImp =
      getIt<AuthLocalStorageDataSource>();

  @override
  void initState() {
    _controller = TextEditingController();
    _getProfileBloc.add(const GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetProfileBloc, GetProfileState>(
      bloc: _getProfileBloc,
      listener: (context, state) {
        if (state is GetProfileLoaded) {
          _controller = TextEditingController();
        }
      },
      child: ScaffoldWidget(
        useSingleScroll: false,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(20),
            const AppBarWidget("Enter Pin"),
            BlocBuilder<GetProfileBloc, GetProfileState>(
              bloc: _getProfileBloc,
              builder: (context, state) {
                if (state is GetProfileLoading) {
                  return const Center(child: LoadingIndicatorWidget());
                } else if (state is GetProfileLoaded) {
                  final String? hashedPin =
                      state.profileDetailEntity.data.hashedPin;

                  if (hashedPin == null) {
                    return buildCreatePinWidget(context);
                  }
                  return buildPinWidget(context, hashedPin);
                } else if (state is GetProfileError) {
                  return CustomErrorWidget(
                    message: state.message,
                    callback: () => _getProfileBloc.add(
                      const GetProfileEvent(),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPinWidget(BuildContext context, String hashedPin) {
    final bool isDarkMode = context.isDarkMode;

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const TextWidget(
            "Enter Your Pin To Continue Transaction",
            fontSize: 16,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          verticalSpace(40),
          SizedBox(
            width: sw(85),
            child: AbsorbPointer(
              absorbing: true,
              child: PinCodeTextField(
                controller: _controller,
                appContext: context,
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(sr(5)),
                  fieldHeight: h(62),
                  fieldWidth: w(60),
                  activeColor: isDarkMode
                      ? Colors.white
                      : const Color(0xff272727).withOpacity(0.8),
                  activeFillColor: const Color(0xff272727).withOpacity(0.08),
                  selectedColor: const Color(0xff272727),
                  selectedFillColor: Colors.white,
                  inactiveColor: isDarkMode
                      ? Colors.white.withOpacity(0.3)
                      : const Color(0xff272727).withOpacity(0.4),
                  inactiveFillColor: const Color(0xff272727).withOpacity(0.02),
                ),
                enableActiveFill: true,
                onChanged: (value) => LoggerHelper.log(value),
                onCompleted: (value) {
                  LoggerHelper.log(value);
                  AppRouter.instance.goBack(_controller.text);
                },
              ),
            ),
          ),
          verticalSpace(40),
          KeyPad(
            pinController: _controller,
            onBioMetricPressed: () => _onBiometricPressed(hashedPin),
            showBioMetric: widget.showBiometric,
          ),
          verticalSpace(25),
          GestureDetector(
            onTap: () {},
            child: TextWidget(
              "Forgot Pin?",
              fontSize: sp(16),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          verticalSpace(45),
        ],
      ),
    );
  }

  Future<void> _onBiometricPressed(String hashedPin) async {
    try {
      if (await authLocalStorageDataSourceImp.canUseThumbPrint()) {
        final result =
            authLocalStorageDataSourceImp.authenticateWithBioMetric();

        if (await result == false) return;
        AppRouter.instance.goBack(hashedPin.toString());
      }
    } catch (e) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: "Failed to authenticate",
      );
    }
  }

  Widget buildCreatePinWidget(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          verticalSpace(),
          SizedBox(
            width: sw(70),
            child: const TextWidget(
              "It seems you have not set your transaction pin yet. Please set your transaction pin to continue",
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Button(
            text: "Create Transaction Pin",
            onTap: () => AppRouter.instance.navigateTo(
              CreatePinView.routeName,
            ),
          ),
          verticalSpace(45),
        ],
      ),
    );
  }
}
