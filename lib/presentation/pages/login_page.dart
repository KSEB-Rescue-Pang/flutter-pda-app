import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../widgets/rescue_pang_logo.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/work_type_dropdown.dart';
import '../widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIdController = TextEditingController();
  WorkType? _selectedWorkType;
  bool _isLoading = false;

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_userIdController.text.isEmpty || _selectedWorkType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사용자 ID와 작업 유형을 모두 입력해주세요.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 로그인 로직 시뮬레이션
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${_selectedWorkType == WorkType.inbound ? 'Inbound' : 'Outbound'} 작업으로 로그인되었습니다.',
          ),
          backgroundColor: AppColors.primaryButton,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // 로고
                  const Center(child: RescuePangLogo()),

                  const SizedBox(height: AppSizes.verticalSpacing),

                  // 로그인 폼 컨테이너
                  Container(
                    width: AppSizes.formContainerWidth,
                    constraints: const BoxConstraints(
                      minHeight: AppSizes.formContainerHeight,
                      maxHeight: 450,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.inputBackground,
                      borderRadius: BorderRadius.circular(
                        AppSizes.formContainerRadius,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 사용자 ID 입력 필드
                          CustomInputField(
                            label: '사용자 ID 입력',
                            hintText: '사용자 ID를 입력하세요',
                            controller: _userIdController,
                          ),

                          const SizedBox(height: AppSizes.verticalSpacing),

                          // 작업 유형 선택
                          WorkTypeDropdown(
                            selectedValue: _selectedWorkType,
                            onChanged: (WorkType? value) {
                              setState(() {
                                _selectedWorkType = value;
                              });
                            },
                          ),

                          const SizedBox(height: AppSizes.verticalSpacing),

                          // 로그인 버튼
                          LoginButton(
                            onPressed: _handleLogin,
                            isLoading: _isLoading,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
