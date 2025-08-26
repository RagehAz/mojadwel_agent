// ignore_for_file: require_trailing_commas
import 'dart:convert';

/// => AI TESTED
abstract class Idifier {
  // -----------------------------------------------------------------------------

  /// CREATE ID

  // --------------------
  /// AI TESTED
  static int createUniqueIDInteger({
    int maxDigitsCount = 16, // 8'640'000'000'000'000'000
  }) {
    assert(maxDigitsCount > 0 && maxDigitsCount <= 16, 'Take care : 0 < maxDigitsCount <= 16',);

    /// some smart ass stunt online said : DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String _string = DateTime.now().microsecondsSinceEpoch.toString();

    final String? _trimmed = removeNumberOfCharactersFromBeginningOfAString(
      string: _string,
      numberOfCharacters: _string.length - maxDigitsCount,
    );

    return transformStringToInt(_trimmed)!;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String createUniqueIDString({
    int maxDigitsCount = 16, // 8'640'000'000'000'000'000
  }){
    return createUniqueIDInteger(maxDigitsCount: maxDigitsCount).toString();
  }
  // --------------------------------------------------------------------------

  /// IDIFY STRING

  // --------------------
  /// AI TESTED
  static String? idifyString(String? text){
    String? _output;

    if (isEmpty(text) == false){

      _output = text;

      _output = fixCountryName(
        input: _output,
        addTheseChars: {
          'and'               : {'char': '&'    ,'replacement': '_'},
          'space'             : {'char': ' '    ,'replacement': '_'},
        },
      );

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? fixCountryName({
    required String? input,
    Map<String, dynamic>? addTheseChars,
  }) {
    /// only user with country names, city names, districts names
    String? _output;

    if (input != null) {

      _output = input.toLowerCase().trim();

      Map<String, dynamic> _charsToMove = {
        'space'             : {'char': ' '    ,'replacement': '_'},
        'double space'      : {'char': '  '   ,'replacement': '_'},
        'dash'              : {'char': '-'    ,'replacement': '_'},
        'plus'              : {'char': '+'    ,'replacement': '_'},
        'tilde'             : {'char': '~'    ,'replacement': '_'},
        'dollar'            : {'char': r'$'    ,'replacement': '_'},
        'equal'             : {'char': '='    ,'replacement': '_'},
        'comma'             : {'char': ','    ,'replacement': ''},
        'left parenthesis'  : {'char': '('    ,'replacement': ''},
        'right parenthesis' : {'char': ')'    ,'replacement': ''},
        'left sq par'       : {'char': '['    ,'replacement': '_'},
        'right sq par'      : {'char': ']'    ,'replacement': '_'},
        'left x par'        : {'char': '{'    ,'replacement': '_'},
        'right x par'       : {'char': '}'    ,'replacement': '_'},
        'bigger'            : {'char': '>'    ,'replacement': '_'},
        'smaller'           : {'char': '<'    ,'replacement': '_'},
        'apostrophe'        : {'char': '’'    ,'replacement': ''},
        'double_quote'      : {'char': '"'    ,'replacement': ''},
        'single_quote'      : {'char': "'"    ,'replacement': ''},
        'o_circumflex'      : {'char': 'ô'    ,'replacement': 'o'},
        'backtick'          : {'char': '`'    ,'replacement': ''},
        'period'            : {'char': '.'    ,'replacement': '_'},
        'forward_slash'     : {'char': '/'    ,'replacement': '_'},
        'back_slash'        : {'char': r'\'    ,'replacement': '_'},
        'line'              : {'char': r'|'    ,'replacement': '_'},
        'semi_colon'        : {'char': ';'    ,'replacement': '_'},
        'colon'             : {'char': ':'    ,'replacement': '_'},
        'hash'              : {'char': '#'    ,'replacement': ''},
        'at'                : {'char': '@'    ,'replacement': ''},
        'exclamation'       : {'char': '!'    ,'replacement': ''},
        'question'          : {'char': '?'    ,'replacement': ''},
        'percent'           : {'char': '%'    ,'replacement': ''},
        'bo2loz'            : {'char': '^'    ,'replacement': ''},
        'star'              : {'char': '*'    ,'replacement': ''},
        'space1'            : {'char': '‎'  ,'replacement': '_'},
        'space2'            : {'char': '‏'  ,'replacement': '_'},
        'space3'            : {'char': '‎ ' ,'replacement': '_'},
        'space4'            : {'char': ' ‏' ,'replacement': '_'},
        'space5'            : {'char': '​' ,'replacement': '_'},
        'double underscore' : {'char': '__'   ,'replacement': '_'},
        'double underscore2': {'char': '__'   ,'replacement': '_'},
        'double underscore3': {'char': '__'   ,'replacement': '_'},
        'double underscore4': {'char': '__'   ,'replacement': '_'},
        'double underscore5': {'char': '__'   ,'replacement': '_'},
        // Add more character replacements as needed
      };
      _charsToMove = insertMapInMap(
        baseMap: _charsToMove,
        insert: addTheseChars,
        // replaceDuplicateKeys: true,
      );


      final List<String> _keys = _charsToMove.keys.toList();

      for (final String key in _keys){
        _output = replaceAllCharacters(
          input: _output,
          characterToReplace: _charsToMove[key]['char'] as String?,
          replacement: _charsToMove[key]['replacement']as String?,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? replaceAllCharacters({
    required String? characterToReplace,
    required String? replacement,
    required String? input,
  }) {
    if (
    characterToReplace != null &&
        replacement != null &&
        input != null
    ){
      return input.replaceAll(characterToReplace, replacement);
    }
    else {
      return input;
    }

  }
  // --------------------
  /// AI TESTED
  static Map<String, dynamic> insertMapInMap({
    required Map<String, dynamic>? baseMap,
    required Map<String, dynamic>? insert,
    bool replaceDuplicateKeys = true,
    bool cleanByDecoding = true,
  }){
    Map<String, dynamic>? _output = baseMap;

    if (cleanByDecoding == true){
      _output = cloneMap(baseMap);
    }

    if (insert != null){

      final List<String> _keys = insert.keys.toList();

      if (checkCanLoop(_keys) == true){

        for (final String key in _keys){

          _output = insertPairInMap(
            map: _output,
            key: key,
            value: insert[key],
            overrideExisting: replaceDuplicateKeys,
          );

        }

      }

    }

    return _output ?? {};
  }
  // --------------------
  /// AI TESTED
  static Map<String, dynamic> insertPairInMap({
    required Map<String, dynamic>? map,
    required String? key,
    required dynamic value,
    required bool overrideExisting, // was always false by default
  }) {

    final Map<String, dynamic> _result = <String, dynamic>{};

    if (map != null){
      _result.addAll(map);
    }

    if (key != null){

      /// PAIR IS NULL
      if (_result[key] == null){
        _result[key] = value;
        // _result.putIfAbsent(key, () => value);
      }

      /// PAIR HAS VALUE
      else {
        if (overrideExisting == true){
          _result[key] = value;
        }
      }

    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cloneMap(Map<String, dynamic>? map){
    if (map == null){
      return null;
    }
    else {
      return jsonDecode(jsonEncode(map)) as Map<String, dynamic>?;
    }
  }
  // --------------------
  /// AI TESTED
  static String? removeNumberOfCharactersFromBeginningOfAString({
    required String? string,
    required int? numberOfCharacters,
  }) {

    if (isEmpty(string) == true){
      return null;
    }

    else {

      final int _numberOfCharacters = numberOfCharacters ?? 0;

      if (_numberOfCharacters > 0) {

        String? _stringTrimmed;

        if (_numberOfCharacters > string!.length) {
          // blog('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
          final Error _error = ArgumentError(
              'can not remove ($numberOfCharacters) from the given string because',
              'removeNumberOfCharactersFromBeginningOfAString');
          throw _error;
        }

        else {
          _stringTrimmed = string.isNotEmpty ? string.substring(_numberOfCharacters) : null;
        }

        return _stringTrimmed;
      }

      else {
        return string;
      }

    }
  }
  // --------------------
  /// AI TESTED
  static int? transformStringToInt(String? string) {
    int? _value;

    if (string != null) {
      final double? _doubleValue = double.tryParse(string);
      _value = _doubleValue?.toInt();
    }

    return _value;
  }
  // --------------------
  /// AI TESTED
  static bool isEmpty(String? string) {

    if (string == null || string == '' || string.isEmpty == true

    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

    ) {
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// AI TESTED
  static bool checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
// --------------------------------------------------------------------------
}
