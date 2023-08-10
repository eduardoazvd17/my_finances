enum AppDateFormat {
  dmy,
  mdy,
  ymd,
}

extension AppDateFormatExtension on AppDateFormat {
  String get title {
    return switch (this) {
      AppDateFormat.dmy => 'dd/MM/yyyy',
      AppDateFormat.mdy => 'MM/dd/yyyy',
      AppDateFormat.ymd => 'yyyy/MM/dd',
    };
  }

  String get locale {
    return switch (this) {
      AppDateFormat.dmy => 'pt_BR',
      AppDateFormat.mdy => 'en_US',
      AppDateFormat.ymd => 'ja_JP',
    };
  }
}
