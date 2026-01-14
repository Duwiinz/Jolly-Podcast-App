class CountryListModel {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  CountryListModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });
}

final List<CountryListModel> countriesListWithCodeAndFlag = [
  CountryListModel(
    name: 'Afghanistan',
    code: 'AF',
    dialCode: '+93',
    flag: '🇦🇫',
  ),
  CountryListModel(name: 'Albania', code: 'AL', dialCode: '+355', flag: '🇦🇱'),
  CountryListModel(name: 'Algeria', code: 'DZ', dialCode: '+213', flag: '🇩🇿'),
  CountryListModel(name: 'Andorra', code: 'AD', dialCode: '+376', flag: '🇦🇩'),
  CountryListModel(name: 'Angola', code: 'AO', dialCode: '+244', flag: '🇦🇴'),
  CountryListModel(
    name: 'Argentina',
    code: 'AR',
    dialCode: '+54',
    flag: '🇦🇷',
  ),
  CountryListModel(name: 'Armenia', code: 'AM', dialCode: '+374', flag: '🇦🇲'),
  CountryListModel(
    name: 'Australia',
    code: 'AU',
    dialCode: '+61',
    flag: '🇦🇺',
  ),
  CountryListModel(name: 'Austria', code: 'AT', dialCode: '+43', flag: '🇦🇹'),
  CountryListModel(
    name: 'Azerbaijan',
    code: 'AZ',
    dialCode: '+994',
    flag: '🇦🇿',
  ),
  CountryListModel(name: 'Bahrain', code: 'BH', dialCode: '+973', flag: '🇧🇭'),
  CountryListModel(
    name: 'Bangladesh',
    code: 'BD',
    dialCode: '+880',
    flag: '🇧🇩',
  ),
  CountryListModel(name: 'Belgium', code: 'BE', dialCode: '+32', flag: '🇧🇪'),
  CountryListModel(name: 'Brazil', code: 'BR', dialCode: '+55', flag: '🇧🇷'),
  CountryListModel(name: 'Canada', code: 'CA', dialCode: '+1', flag: '🇨🇦'),
  CountryListModel(name: 'China', code: 'CN', dialCode: '+86', flag: '🇨🇳'),
  CountryListModel(name: 'Egypt', code: 'EG', dialCode: '+20', flag: '🇪🇬'),
  CountryListModel(name: 'France', code: 'FR', dialCode: '+33', flag: '🇫🇷'),
  CountryListModel(name: 'Germany', code: 'DE', dialCode: '+49', flag: '🇩🇪'),
  CountryListModel(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
  CountryListModel(
    name: 'Indonesia',
    code: 'ID',
    dialCode: '+62',
    flag: '🇮🇩',
  ),
  CountryListModel(name: 'Italy', code: 'IT', dialCode: '+39', flag: '🇮🇹'),
  CountryListModel(name: 'Japan', code: 'JP', dialCode: '+81', flag: '🇯🇵'),
  CountryListModel(name: 'Kenya', code: 'KE', dialCode: '+254', flag: '🇰🇪'),
  CountryListModel(name: 'Mexico', code: 'MX', dialCode: '+52', flag: '🇲🇽'),
  CountryListModel(name: 'Nigeria', code: 'NG', dialCode: '+234', flag: '🇳🇬'),
  CountryListModel(name: 'Pakistan', code: 'PK', dialCode: '+92', flag: '🇵🇰'),
  CountryListModel(name: 'Russia', code: 'RU', dialCode: '+7', flag: '🇷🇺'),
  CountryListModel(
    name: 'Saudi Arabia',
    code: 'SA',
    dialCode: '+966',
    flag: '🇸🇦',
  ),
  CountryListModel(
    name: 'South Africa',
    code: 'ZA',
    dialCode: '+27',
    flag: '🇿🇦',
  ),
  CountryListModel(
    name: 'United Arab Emirates',
    code: 'AE',
    dialCode: '+971',
    flag: '🇦🇪',
  ),
  CountryListModel(
    name: 'United Kingdom',
    code: 'GB',
    dialCode: '+44',
    flag: '🇬🇧',
  ),
  CountryListModel(
    name: 'United States',
    code: 'US',
    dialCode: '+1',
    flag: '🇺🇸',
  ),
];
