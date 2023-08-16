import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/enums/app_currency_format.dart';
import 'package:myfinances/src/core/data/enums/app_date_format.dart';
import 'package:myfinances/src/core/data/enums/app_language.dart';
import 'package:myfinances/src/core/data/enums/app_theme.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';
import 'package:myfinances/src/core/presentation/controllers/theme_controller.dart';

import '../widgets/bottom_sheet_modal_widget.dart';
import '../widgets/drop_down_button_widget.dart';

class SettingsBottomSheetModal extends GetWidget<AppController> {
  const SettingsBottomSheetModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomSheetModalWidget(
        icon: CupertinoIcons.settings,
        title: 'settings-text'.i18n(),
        child: Column(
          children: [
            if (controller.user == null)
              _getNoAuthTiles(context)
            else
              _getAuthTiles(context),
          ],
        ),
      ),
    );
  }

  Widget _getNoAuthTiles(BuildContext context) {
    return Column(
      children: [
        _languageTile(context),
        const Divider(),
        _themeTile(context),
      ],
    );
  }

  Widget _getAuthTiles(BuildContext context) {
    return Column(
      children: [
        if (!kIsWeb) ...[
          _biometricTile(context),
          const Divider(),
        ],
        _languageTile(context),
        const Divider(),
        _dateFormatTile(context),
        _timeFormatTile(context),
        const Divider(),
        _currencyFormatTile(context),
        const Divider(),
        _themeTile(context),
      ],
    );
  }

  Widget _biometricTile(BuildContext context) {
    return SwitchListTile(
      value: controller.canEnableBiometrics
          ? controller.isBiometricsEnabled
          : false,
      onChanged: controller.canEnableBiometrics
          ? controller.setIsBiometricsEnabled
          : null,
      title: Text(
        'enable-biometrics-button'.i18n(),
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.normal),
      ),
      subtitle: controller.canEnableBiometrics
          ? null
          : Text(
              "*${'cannot-enable-biometrics-text'.i18n()}",
              style: TextStyle(color: Colors.red[300]),
            ),
    );
  }

  Widget _languageTile(BuildContext context) {
    final I18nController i18nController = Get.find<I18nController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '${'app-language-label'.i18n()}:',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: DropDownButtonWidget<AppLanguage?>(
                itemHeight: 50,
                isExpanded: true,
                value: i18nController.selectedLanguage,
                onChanged: (value) {
                  i18nController.setSelectedLanguage(value);
                },
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text('app-language-null'.i18n()),
                  ),
                  ...AppLanguage.values.map(
                    (language) => DropdownMenuItem(
                      value: language,
                      child: Text(language.title),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateFormatTile(BuildContext context) {
    final I18nController i18nController = Get.find<I18nController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '${'app-date-format-label'.i18n()}:',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: DropDownButtonWidget<AppDateFormat?>(
                itemHeight: 50,
                isExpanded: true,
                value: i18nController.selectedDateFormat,
                onChanged: (value) {
                  i18nController.setSelectedDateFormat(value);
                },
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text('app-date-format-null'.i18n()),
                  ),
                  ...AppDateFormat.values.map(
                    (date) => DropdownMenuItem(
                      value: date,
                      child: Text(date.title),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeFormatTile(BuildContext context) {
    final I18nController i18nController = Get.find<I18nController>();
    return SwitchListTile(
      value: i18nController.dateUse24hFormat,
      onChanged: i18nController.setDateUse24hFormat,
      title: Text(
        'use-24h-format-button'.i18n(),
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _currencyFormatTile(BuildContext context) {
    final I18nController i18nController = Get.find<I18nController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '${'app-currency-format-label'.i18n()}:',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: DropDownButtonWidget<AppCurrencyFormat?>(
                itemHeight: 50,
                isExpanded: true,
                value: i18nController.selectedCurrencyFormat,
                onChanged: (value) {
                  i18nController.setSelectedCurrencyFormat(value);
                },
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text('app-currency-format-null'.i18n()),
                  ),
                  ...AppCurrencyFormat.values.map(
                    (currency) => DropdownMenuItem(
                      value: currency,
                      child: Text(currency.title),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeTile(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '${'app-theme-label'.i18n()}:',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: DropDownButtonWidget<AppTheme>(
                itemHeight: 50,
                isExpanded: true,
                value: themeController.selectedTheme,
                onChanged: (value) {
                  if (value != null) {
                    themeController.setSelectedTheme(value);
                  }
                },
                items: AppTheme.values
                    .map(
                      (theme) => DropdownMenuItem(
                        value: theme,
                        child: Text(theme.title),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
