import 'package:intl/intl.dart';

enum AppCurrencyFormat {
  brl, // Brazilian Real
  mzn, // Mozambican Metical
  aoa, // Angolan Kwanza
  cve, // Cape Verdean Escudo
  gwp, // Guinea-Bissau Peso
  stn, // Sao Tomean Dobra
  tl, // Timorese Centavo
  usd, // US Dollar
  gbp, // British Pound
  aud, // Australian Dollar
  nzd, // New Zealand Dollar
  cad, // Canadian Dollar
  hkd, // Hong Kong Dollar
  jmd, // Jamaican Dollar
  zwl, // Zimbabwean Dollar
  zmw, // Zambian Kwacha
  bwp, // Botswana Pula
  lsl, // Basotho Loti
  szl, // Swazi Lilangeni
  ars, // Argentine Peso
  mxn, // Mexican Peso
  cop, // Colombian Peso
  pen, // Peruvian Sol
  clp, // Chilean Peso
  uyu, // Uruguayan Peso
  bob, // Bolivian Bolíviano
  pyg, // Paraguayan Guarani
  cuc, // Cuban Convertible Peso
  dop, // Dominican Peso
}

extension AppCurrencyFormatExtension on AppCurrencyFormat {
  String get symbol {
    switch (this) {
      case AppCurrencyFormat.brl:
        return 'R\$';
      case AppCurrencyFormat.mzn:
        return 'MT';
      case AppCurrencyFormat.aoa:
        return 'Kz';
      case AppCurrencyFormat.cve:
        return 'Esc';
      case AppCurrencyFormat.gwp:
        return 'CFA';
      case AppCurrencyFormat.stn:
        return 'Db';
      case AppCurrencyFormat.tl:
        return '¢';
      case AppCurrencyFormat.usd:
        return '\$';
      case AppCurrencyFormat.gbp:
        return '£';
      case AppCurrencyFormat.aud:
        return 'A\$';
      case AppCurrencyFormat.nzd:
        return 'NZ\$';
      case AppCurrencyFormat.cad:
        return 'C\$';
      case AppCurrencyFormat.hkd:
        return 'HK\$';
      case AppCurrencyFormat.jmd:
        return 'J\$';
      case AppCurrencyFormat.zwl:
        return 'Z\$';
      case AppCurrencyFormat.zmw:
        return 'ZK';
      case AppCurrencyFormat.bwp:
        return 'P';
      case AppCurrencyFormat.lsl:
        return 'L';
      case AppCurrencyFormat.szl:
        return 'E';
      case AppCurrencyFormat.ars:
        return '\$';
      case AppCurrencyFormat.mxn:
        return '\$';
      case AppCurrencyFormat.cop:
        return '\$';
      case AppCurrencyFormat.pen:
        return 'S/';
      case AppCurrencyFormat.clp:
        return '\$';
      case AppCurrencyFormat.uyu:
        return '\$U';
      case AppCurrencyFormat.bob:
        return 'Bs';
      case AppCurrencyFormat.pyg:
        return '₲';
      case AppCurrencyFormat.cuc:
        return '\$';
      case AppCurrencyFormat.dop:
        return 'RD\$';
    }
  }

  String get locale {
    switch (this) {
      case AppCurrencyFormat.brl:
      case AppCurrencyFormat.mzn:
      case AppCurrencyFormat.aoa:
      case AppCurrencyFormat.cve:
      case AppCurrencyFormat.gwp:
      case AppCurrencyFormat.stn:
      case AppCurrencyFormat.tl:
        return 'pt_BR';

      case AppCurrencyFormat.usd:
      case AppCurrencyFormat.gbp:
      case AppCurrencyFormat.aud:
      case AppCurrencyFormat.nzd:
      case AppCurrencyFormat.cad:
      case AppCurrencyFormat.hkd:
      case AppCurrencyFormat.jmd:
      case AppCurrencyFormat.zwl:
      case AppCurrencyFormat.zmw:
      case AppCurrencyFormat.bwp:
      case AppCurrencyFormat.lsl:
      case AppCurrencyFormat.szl:
        return 'en_US';

      case AppCurrencyFormat.ars:
      case AppCurrencyFormat.mxn:
      case AppCurrencyFormat.cop:
      case AppCurrencyFormat.pen:
      case AppCurrencyFormat.clp:
      case AppCurrencyFormat.uyu:
      case AppCurrencyFormat.bob:
      case AppCurrencyFormat.pyg:
      case AppCurrencyFormat.cuc:
      case AppCurrencyFormat.dop:
        return 'es_ES';
    }
  }

  String get title {
    return '${name.toUpperCase()} (${format(1234.56)})';
  }

  String format(double value) {
    return NumberFormat.currency(
      locale: locale,
      name: name.toUpperCase(),
      symbol: symbol,
    ).format(value);
  }
}
