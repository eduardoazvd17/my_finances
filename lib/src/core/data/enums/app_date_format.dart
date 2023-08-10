enum AppDateFormat {
  dmy,
  mdy,
  ymd,
}

extension AppDateFormatExtension on AppDateFormat {
  String get title {
    return switch (this) {
      AppDateFormat.dmy => '30/12/2023',
      AppDateFormat.mdy => '12/30/2023',
      AppDateFormat.ymd => '2023/12/30',
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
