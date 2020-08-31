// The Inputs from PopUp screen, Filters
// This class uses Singleton design pattrn
class SavedFilters {
  static final SavedFilters _instance = SavedFilters._internal();

  String _position;
  String get position => _position;
  void setposition(string) => _position = string;

  String _location;
  String get location => _location;
  void setlocation(string) => _location = string;

  List<int> _selectedProviders = [];
  List<int> get selectedProviders => _selectedProviders;
  void setselectedProviders(list) => _selectedProviders = list;

  factory SavedFilters() {
    return _instance;
  }
  // When the first instance initai
  SavedFilters._internal() {
    print('the ini done ');
  }
}
