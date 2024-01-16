import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:task_management/app_routes.dart';
import 'package:task_management/bloc/auth/cubit.dart';
import 'package:task_management/screeens/widgets/app_button.dart';
import 'package:task_management/screeens/widgets/custom_snackbar.dart';
import 'package:task_management/screeens/widgets/custom_text_field.dart';
import 'package:task_management/screeens/widgets/screen.dart';
import 'package:task_management/utils/notification_handler.dart';

import '../../configs/app.dart';
import '../../configs/configs.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _BodyState();
}

class _BodyState extends State<SignUp> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool next = true;
  bool driver = false;
  String deviceId = '';

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.cubit(context);
    App.init(context);

    return Screen(
      overlayWidgets: [
        BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSignUpLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          },
          listener: (context, state) {
            if (state is AuthSignUpFailed) {
              CustomSnackBars.failure(
                context,
                state.message!,
                title: 'Sign up Failed!',
              );
            } else if (state is AuthSignUpSuccess) {
              Navigator.popUntil(
                context,
                ModalRoute.withName(AppRoutes.login),
              );

              CustomSnackBars.success(
                context,
                'Account has been created successfully. Please verify your email and login.',
                title: 'Account Created!',
                color: AppTheme.c!.primary,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          padding: Space.all(1),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.y1!,
                Space.y!,
                Text(
                  'Sign Up',
                  style: AppText.h2b,
                ),
                Space.y!,
                Text(
                  'Please create an account .',
                  style: AppText.l1!.copyWith(
                    color: AppTheme.c!.text,
                  ),
                ),
                FormBuilderRadioGroup(
                  decoration: const InputDecoration(border: InputBorder.none),
                  initialValue: "Admin",
                  name: 'type',
                  onChanged: (value) {},
                  options: ['Admin', 'Manager', 'User']
                      .map(
                        (e) => FormBuilderFieldOption(
                          value: e,
                        ),
                      )
                      .toList(growable: false),
                ),
                Space.y1!,
                CustomTextField(
                  name: 'fullName',
                  hint: 'Full name',
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  validatorFtn: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        errorText: 'Full name is required',
                      ),
                    ],
                  ),
                ),
                Space.y!,
                CustomTextField(
                  name: 'password',
                  hint: 'Password',
                  isPass: true,
                  textInputType: TextInputType.text,
                  validatorFtn: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Password is required',
                    ),
                  ]),
                ),
                Space.y!,
                CustomTextField(
                  name: 'confirmPassword',
                  hint: 'Confirm Password',
                  isPass: true,
                  textInputType: TextInputType.text,
                  validatorFtn: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Confirm password is required',
                    ),
                  ]),
                ),
                Space.y!,
                CustomTextField(
                  name: 'email',
                  hint: 'Email address',
                  textInputType: TextInputType.emailAddress,
                  validatorFtn: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        errorText: 'Email is required',
                      ),
                      FormBuilderValidators.email(
                        errorText: 'Please provide a valid email address',
                      )
                    ],
                  ),
                ),
                Space.y1!,
                FormBuilderCheckbox(
                  activeColor: AppTheme.c!.primary,
                  name: 'terms',
                  title: ExcludeSemantics(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree that I have read and accepted the ',
                            style: AppText.l1!.copyWith(
                              color: AppTheme.c!.text,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of use ',
                            style: AppText.l1b!.copyWith(
                              color: AppTheme.c!.primary,
                            ),
                          ),
                          TextSpan(
                            text: ' and',
                            style: AppText.l1!.copyWith(
                              color: AppTheme.c!.text,
                            ),
                          ),
                          TextSpan(
                            text: ' Privacy Policy',
                            style: AppText.l1b!.copyWith(
                              color: AppTheme.c!.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  validator: FormBuilderValidators.required(
                    errorText: 'Please agree to terms and conditions',
                  ),
                ),
                Space.y1!,
                AppButton(
                  child: Text(
                    'Create an Account',
                    style: AppText.b1!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    NotificationServices notificationServices =
                        NotificationServices();
                    notificationServices.getDeviceToken().then((value) {
                      deviceId = value;
                    });
                    final isValid = _formKey.currentState!.saveAndValidate();
                    if (!isValid) return;
                    FocusScope.of(context).unfocus();

                    final form = _formKey.currentState!;
                    final data = form.value;

                    final password = data['password'];
                    final confirmPassword = data['confirmPassword'];

                    if (password != confirmPassword) {
                      CustomSnackBars.failure(
                        context,
                        'Password mismatch, please re-check and try again!',
                      );
                    } else {
                      authCubit.signup(
                        data['fullName'],
                        data['email'],
                        password,
                        data['type'],
                        deviceId,
                      );
                    }
                  },
                ),
                Space.y!,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: AppText.l1,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Login',
                          style: AppText.l1b,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
