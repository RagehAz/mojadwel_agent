import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:mojadwel_agent/core/utilities/idifier.dart';
import 'package:mojadwel_agent/core/utilities/timers.dart';

@immutable
class DMModel {
  // -----------------------------------------------------------------------------
  const DMModel({
    required this.id,
    required this.text,
    required this.time,
    required this.ownerID,
  });
  // --------------------
  final String id;
  final String? text;
  final DateTime? time;
  final String? ownerID;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  DMModel copyWith({
    String? id,
    String? text,
    DateTime? time,
    String? ownerID,
  }){
    return DMModel(
      id: id ?? this.id,
      text: text ?? this.text,
      time: time ?? this.time,
      ownerID: ownerID ?? this.ownerID,
    );
  }
  // --------------------
  /*
  ///
  AnswerModel nullifyField({
    bool id = false,
    bool text = false,
    bool time = false,
  }){
    return AnswerModel(
      id: id == true ? '' : this.id,
    );
  }
   */
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    required bool toJSON,
  }){
    return {
      'text': text,
      'id': id,
      'time': Timers.cipherTime(time: time, toJSON: toJSON),
      'ownerID': ownerID,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherToMaps({
    required List<DMModel>? models,
    required bool toJSON,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (checkCanLoop(models) == true){

      for (final DMModel model in models!){

        final Map<String, dynamic> _map = model.toMap(
          toJSON: toJSON,
        );

        _output.add(_map);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DMModel? decipherMap({
    required Map<String, dynamic>? map,
    required bool fromJSON,
  }){
    DMModel? _output;

    if (map != null && map['id'] != null){

      _output = DMModel(
        id: map['id'] as String,
        text: map['text'] as String,
        time: Timers.decipherTime(time: map['time'], fromJSON: fromJSON),
        ownerID: map['ownerID'] as String,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DMModel> decipherMaps({
    required List<Map<String, dynamic>>? maps,
    required bool fromJSON,
  }){
    final List<DMModel> _output = [];

    if (checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final DMModel? _model = decipherMap(
          map: map,
          fromJSON: fromJSON,
        );

        if (_model != null){
          _output.add(_model);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TO CHAT LOG MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipherToChatLogMap({
    required List<DMModel>? models,
    required String? userName,
    required bool toJSON,
  }){
    Map<String, dynamic>? _output;

    final String? _userName = Idifier.idifyString(userName);

    if (_userName != null && checkCanLoop(models) == true){

      _output = {};

      loopSync(
        models: models,
        onLoop: (int index, DMModel? model){

          if (model != null){

            final Map<String, dynamic> _map = model.toMap(
              toJSON: toJSON,
            );

            final String name = model.ownerID == 'cleo' ? 'cleo' : _userName;

            final String _mapKey = '${index}_$name';

            _output![_mapKey] = _map;

          }

        },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DMModel> insertNewDM({
    required List<DMModel> dms,
    required String? userID,
    required String? text,
  }){

    if (userID == null || text == null){
      return dms;
    }

    else {

      final DMModel _newDM = DMModel(
        id: Idifier.createUniqueIDString(),
        time: DateTime.now(),
        ownerID: userID,
        text: text,
      );

      return [...dms, _newDM];

    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DMModel> sortConversation({
    required List<DMModel> dms,
  }){

    final List<DMModel> sorted = [...dms]; // avoid mutating original list

    // ignore: cascade_invocations
    sorted.sort((a, b) {
      final aTime = a.time ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.time ?? DateTime.fromMillisecondsSinceEpoch(0);
      return aTime.compareTo(bTime); // newest first
    });

    return sorted;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelsAreIdentical({
    required DMModel? model1,
    required DMModel? model2,
  }){

    return checkMapsAreIdentical(
      map1: model1?.toMap(toJSON: true),
      map2: model2?.toMap(toJSON: true),
    );
  }
  // --------------------
  /// AI TESTED
  static bool checkMapsAreIdentical({
    required Map<String, dynamic>? map1,
    required Map<String, dynamic>? map2,
  }) {

    return const DeepCollectionEquality().equals(map1, map2);

    /*
    bool _mapsAreIdentical = false;

    /// BOTH ARE NULL
    if (map1 == null && map2 == null) {
      _mapsAreIdentical = true;
    }

    /// BOTH AREN'T NULL BUT AT LEAST ONE OF THEM IS NULL
    else if (map1 == null || map2 == null){
      _mapsAreIdentical = false;
    }

    /// NON OF THEM IS NULL
    else if (map1 != null && map2 != null){

      if (map1.toString() == map2.toString()){
        _mapsAreIdentical = true;
      }
      else {
        _mapsAreIdentical = false;
      }

      // final List<String> _map1Keys = map1.keys.toList();
      // final List<String> _map2Keys = map2.keys.toList();
      //
      // /// KEYS LENGTH ARE DIFFERENT
      // if (_map1Keys.length != _map2Keys.length) {
      //   _mapsAreIdentical = false;
      // }
      //
      // /// KEYS LENGTH ARE IDENTICAL
      // else {
      //
      //   /// FOR EACH PAIR
      //   for (int i = 0; i < _map1Keys.length; i++){
      //
      //     final String _key1 = _map1Keys[i];
      //     final String _key2 = _map1Keys[i];
      //
      //     /// KEYS ARE DIFFERENT
      //     if (_key1 != _key2){
      //       _mapsAreIdentical = false;
      //       break;
      //     }
      //
      //     /// KEYS ARE IDENTICAL
      //     else {
      //
      //       /// BOTH VALUES ARE NULL
      //       if (map1[_key1] == null && map2[_key2] == null){
      //         // continue looping
      //       }
      //
      //       /// BOTH VALUES ARE NOT NULL BUT ONE OF THEM IS
      //       else if (map1[_key1] == null || map2[_key2] == null){
      //         _mapsAreIdentical = false;
      //         break;
      //       }
      //
      //       /// BOTH VALUES ARE NOT NULL
      //       else {
      //
      //         /// VALUE TYPES ARE DIFFERENT
      //         if (map1[_key1].runtimeType != map2[_key2].runtimeType){
      //           _mapsAreIdentical = false;
      //           break;
      //         }
      //
      //         /// VALUE TYPES ARE IDENTICAL
      //         else {
      //
      //           if (
      //               map1[_key1] is String ||
      //               map1[_key1] is int ||
      //               map1[_key1] is double ||
      //               map1[_key1] is bool
      //           ){
      //
      //             if (map1[_key1] != map2[_key2]){
      //               _mapsAreIdentical = false;
      //               break;
      //             }
      //
      //           }
      //
      //           else if (map1[_key1] is List){
      //
      //           }
      //
      //         }
      //
      //       }
      //
      //
      //     }
      //
      //   }
      //
      //   // final List<dynamic> _map1Values = map1.values.toList();
      //   // final List<dynamic> _map2Values = map2.values.toList();
      //   //
      //   // if (
      //   //     checkListsAreIdentical(list1: _map1Keys, list2: _map2Keys) == true
      //   //     &&
      //   //     checkListsAreIdentical(list1: _map1Values, list2: _map2Values) == true
      //   // ){
      //   //   _mapsAreIdentical = true;
      //   // }
      //   //
      //   // else {
      //   //   _mapsAreIdentical = false;
      //   // }
      //
      // }

    }

    return _mapsAreIdentical;
     */
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelsListsAreIdentical({
    required List<DMModel>? models1,
    required List<DMModel>? models2,
  }){
    return checkMapsListsAreIdentical(
      maps1: cipherToMaps(models: models1, toJSON: true),
      maps2: cipherToMaps(models: models2, toJSON: true),
    );
  }
  // --------------------
  /// AI TESTED
  static bool checkMapsListsAreIdentical({
    required List<Map<String, dynamic>>? maps1,
    required List<Map<String, dynamic>>? maps2,
  }){

    /// OLD BULLSHIT
    // bool _listsAreIdentical = false;
    //
    // if (maps1 == null && maps2 == null){
    //   _listsAreIdentical = true;
    // }
    //
    // else if (maps1?.isEmpty && maps2 == []){
    //   _listsAreIdentical = true;
    // }
    //
    // else if (checkCanLoopList(maps1) == true && checkCanLoopList(maps2) == true){
    //
    //   if (maps1.length != maps2.length) {
    //     _listsAreIdentical = false;
    //   }
    //
    //   else {
    //     for (int i = 0; i < maps1.length; i++) {
    //
    //       final bool _mapsAreIdentical = checkMapsAreIdentical(
    //         map1: maps1[i],
    //         map2: maps2[i],
    //       );
    //
    //       if (_mapsAreIdentical == false) {
    //         // blog('items at index ( $i ) do not match : ( ${maps1[i]} ) <=> ( ${maps2[i]} )');
    //         _listsAreIdentical = false;
    //         break;
    //       }
    //
    //       else {
    //         _listsAreIdentical = true;
    //       }
    //
    //     }
    //   }
    //
    // }
    //
    // if (_listsAreIdentical == false){
    //   blogMapsListsDifferences(
    //     maps1: maps1,
    //     maps2: maps2,
    //     invoker: 'checkMapsListsAreIdentical',
    //   );
    // }
    // return _listsAreIdentical;

    /// THIS DOES NOT CONDUCT DEEP MAP CHECK
    // return checkListsAreIdentical(list1: maps1, list2: maps2);

    /// ITERATE AND DEEP CHECK
    bool _listsAreIdentical = false;

    if (maps1 == null && maps2 == null){
      _listsAreIdentical = true;
    }
    else if (maps1 != null && maps1.isEmpty == true && maps2 != null && maps2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (checkCanLoop(maps1) == true && checkCanLoop(maps2) == true){

      if (maps1!.length != maps2!.length) {
        // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
        // blog(' ---> lis1 is ( ${list1.toString()} )');
        // blog(' ---> lis2 is ( ${list2.toString()} )');
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < maps1.length; i++) {

          if (checkMapsAreIdentical(map1: maps1[i], map2: maps2[i]) == false){
            // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');

            if (maps1[i].toString() == maps2[i].toString()){
              // blog('but they are equal when converted to string');
              _listsAreIdentical = true;
            }
            else {
              // blog('and they are not equal when converted to string');
              _listsAreIdentical = false;
              break;
            }

          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;

  }
  // -----------------------------------------------------------------------------

  /// HELPERS

  // --------------------
  static bool checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void loopSync<T>({
    required List<T?>? models,
    required void Function(int index, T? model) onLoop,
    Function? onListIsEmpty,
  }) {

    if (checkCanLoop(models) == true){

      for (int i = 0; i < models!.length; i++){
        onLoop(i, models[i]);
      }

    }

    else {
      onListIsEmpty?.call();
    }

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      '''
DMModel(
   id : $id,
   text: $text,
   time: $time,
   ownerID: $ownerID,
)  
''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is DMModel){
      _areIdentical = checkModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      text.hashCode^
      time.hashCode^
      ownerID.hashCode^
      id.hashCode;
// -----------------------------------------------------------------------------
}
