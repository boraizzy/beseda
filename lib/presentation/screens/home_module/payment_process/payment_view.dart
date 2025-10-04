part of 'payment_imports.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppCommonGradient.mainDarkBackgroundGradient
              : AppCommonGradient.mainBackgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing,vertical: 12),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: commonPaymentView(
                    CommonImageAssets.paymentSuccess,
                    PaymentViewStrings.paymentSuccessTitle,
                    PaymentViewStrings.paymentSuccess,
                    AppColors.success600,
                  ),
                ),
                PrimaryButton(
                  onPressed: () {
                    Get.offNamedUntil(
                      AppRouteName.bottomView,
                      (route) => route.isFirst,
                    );
                  },
                  label: PaymentViewStrings.goToHome,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
