part of mojo_brain;

// @immutable
// class MojoResponseModel {
//   // -----------------------------------------------------------------------------
//   const MojoResponseModel({
//     required this.id,
//     required this.text,
//     this.choices = const [],
//     this.function,
//     this.data,
//   });
//   // -----------------------------------------------------------------------------
//   final String id;
//   final String text;
//   final List<String> choices;
//   final String? function;
//   final Map<String, dynamic>? data;
//   // -----------------------------------------------------------------------------
//
//   /// CLONING
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   MojoResponseModel copyWith({
//     String? id,
//     String? text,
//     List<String>? choices,
//     String? function,
//     Map<String, dynamic>? data,
//   }) {
//     return MojoResponseModel(
//       id: id ?? this.id,
//       text: text ?? this.text,
//       choices: choices ?? this.choices,
//       function: function ?? this.function,
//       data: data ?? this.data,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   MojoResponseModel nullifyField({
//     bool id = false,
//     bool text = false,
//     bool choices = false,
//     bool function = false,
//     bool data = false,
//   }) {
//     return MojoResponseModel(
//       id: id ? '' : this.id,
//       text: text ? '' : this.text,
//       choices: choices ? [] : this.choices,
//       function: function ? null : this.function,
//       data: data ? null : this.data,
//     );
//   }
//   // -----------------------------------------------------------------------------
//
//   /// CYPHERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'text': text,
//       'choices': choices,
//       'function': function,
//       'data': data,
//     };
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<Map<String, dynamic>> cipherToMaps({
//     required List<MojoResponseModel>? models,
//   }) {
//     final List<Map<String, dynamic>> _output = [];
//
//     if (checkCanLoop(models) == true) {
//       for (final MojoResponseModel model in models!) {
//         _output.add(model.toMap());
//       }
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static MojoResponseModel? decipherMap({
//     required Map<String, dynamic>? map,
//   }) {
//     MojoResponseModel? _output;
//
//     if (map != null) {
//       _output = MojoResponseModel(
//         id: map['id'] as String? ?? '',
//         text: map['text'] as String? ?? '',
//         choices: _getStringsFromDynamics(map['choices']),
//         function: map['function'] as String?,
//         data: map['data'] as Map<String, dynamic>?,
//       );
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<MojoResponseModel> decipherMaps({
//     required List<Map<String, dynamic>>? maps,
//   }) {
//     final List<MojoResponseModel> _output = [];
//
//     if (checkCanLoop(maps) == true) {
//       for (final Map<String, dynamic> map in maps!) {
//         final MojoResponseModel? _model = decipherMap(map: map);
//         if (_model != null) {
//           _output.add(_model);
//         }
//       }
//     }
//
//     return _output;
//   }
//   // --------------------------------------------------------------------------
//
//   /// GENERATE RESPONSE
//
//   // --------------------
//   ///
//   static MojoResponseModel? decipherContentResponse({
//     required GenerateContentResponse? response,
//   }){
//     MojoResponseModel? _output;
//
//     if (response != null){
//
//       dynamic _decoded;
//
//       if (response.text != null){
//         tryAndCatch(
//           invoker: 'decipherContentResponse',
//           functions: () async {
//             _decoded = jsonDecode(response.text!);
//             },
//           onError: (String? error){
//             // Errorize.throwMap(
//             //   invoker: 'decipherContentResponse',
//             //   map: {
//             //     'theError': error,
//             //     'responseText': response.text,
//             //     'totalTokenCount': response.usageMetadata?.totalTokenCount,
//             //   },
//             // );
//           },
//         );
//       }
//
//       if (_decoded != null){
//
//         final Map<String, dynamic>? _map = _getMapFromIHLMOO(
//           ihlmoo: _decoded,
//         );
//
//         _output = decipherMap(map: _map);
//
//       }
//
//     }
//
//     return _output;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// EQUALITY
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool checkModelsAreIdentical({
//     required MojoResponseModel? model1,
//     required MojoResponseModel? model2,
//   }) {
//     return _checkMapsAreIdentical(
//       map1: model1?.toMap(),
//       map2: model2?.toMap(),
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool checkModelsListsAreIdentical({
//     required List<MojoResponseModel>? models1,
//     required List<MojoResponseModel>? models2,
//   }) {
//     return _checkMapsListsAreIdentical(
//       maps1: cipherToMaps(models: models1),
//       maps2: cipherToMaps(models: models2),
//     );
//   }
//   // --------------------
//   /// AI TESTED
//   static List<String> _getStringsFromDynamics(dynamic dynamics) {
//     return _getStringsFromTheDamnThing(dynamics);
//   }
//   // --------------------
//   /// AI TESTED
//   static List<String> _getStringsFromTheDamnThing(dynamic thing){
//     List<String> _output = [];
//
//     if (thing != null){
//
//       if (thing.runtimeType.toString() == 'List<String>'){
//         _output = thing as List<String>;
//       }
//
//       /// ImmutableList<Object?>
//       else if (thing.runtimeType.toString() == 'ImmutableList<Object?>'){
//         _output =  _getStringsFromDynamicsList(thing as List<Object?>);
//       }
//
//       /// _Map<String, dynamic>
//       else if (thing.runtimeType.toString() == '_Map<String, dynamic>'){
//         final Map<String, dynamic> _map = thing as Map<String, dynamic>;
//         final List<String> _keys = _map.keys.toList();
//         for (final String key in _keys){
//           if (_map[key] is String){
//             _output.add(_map[key] as String);
//           }
//         }
//       }
//
//       /// List<dynamic>
//       else if (
//       thing.runtimeType.toString() == 'List<dynamic>' ||
//           thing.runtimeType.toString() == 'List<Object?>' ||
//           thing.runtimeType.toString() == 'List<Object>' ||
//           thing.runtimeType.toString() == 'List<dynamic>?' ||
//           thing.runtimeType.toString() == 'List<Object?>?' ||
//           thing.runtimeType.toString() == 'List<Object>?'  ||
//           thing.runtimeType.toString() == 'List<dynamic>?'
//       ){
//         final List<dynamic> things = thing as List<dynamic>? ?? [];
//         _output = _getStringsFromDynamicsList(things);
//       }
//
//       /// minified
//       // else if (ObjectCheck.objectIsMinified(thing) == true){
//       //   final List<dynamic> things = thing;
//       //   for (final dynamic item in things) {
//       //     if (item is String) {
//       //       _output.add(item);
//       //     }
//       //   }
//       // }
//
//       else if (thing is List){
//         _output = _getStringsFromDynamicsList(thing);
//       }
//
//       // else if (thing is bool){
//       //   _output = ['$thing'];
//       // }
//
//       else {
//         blog('getStringsFromTheDamnThing_something_is_wrong : thing($thing)}');
//         blog('getStringsFromTheDamnThing_something_is_wrong : type(${thing.runtimeType})');
//         // assert(thing == null, 'getStringsFromTheDamnThing_something_is_wrong : ');
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// AI TESTED
//   static List<String> _getStringsFromDynamicsList(List<dynamic>? dynamics) {
//     final List<String> _strings = [];
//
//     if (checkCanLoop(dynamics) == true) {
//       for (final dynamic thing in dynamics!) {
//
//         if (thing is String == true) {
//           _strings.add(thing as String);
//         }
//
//         else if (thing is List){
//           final List<String> _sub = _getStringsFromDynamicsList(thing);
//           _strings.addAll(_sub);
//         }
//
//         else {
//           _strings.add(thing.toString());
//         }
//
//       }
//     }
//
//     return _strings;
//   }
//   // -----------------------------------------------------------------------------
//
//   // --------------------
//   /// MANUALLY TESTED : WORKS PERFECT
//   static Map<String, dynamic>? _getMapFromIHLMOO({
//     required dynamic ihlmoo,
//   }){
//     Map<String, dynamic>? _output;
//
//     /// NOTE : IHLMOO = Internal Hash Linked Map Object Object
//
//     if (ihlmoo != null){
//       _output = jsonDecode(jsonEncode(ihlmoo)) as Map<String, dynamic>?;
//       // _output = Map<String, dynamic>.from(internalHashLinkedMapObjectObject);
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// AI TESTED
//   static bool _checkMapsAreIdentical({
//     required Map<String, dynamic>? map1,
//     required Map<String, dynamic>? map2,
//   }) {
//
//     return const DeepCollectionEquality().equals(map1, map2);
//
//     /*
//     bool _mapsAreIdentical = false;
//
//     /// BOTH ARE NULL
//     if (map1 == null && map2 == null) {
//       _mapsAreIdentical = true;
//     }
//
//     /// BOTH AREN'T NULL BUT AT LEAST ONE OF THEM IS NULL
//     else if (map1 == null || map2 == null){
//       _mapsAreIdentical = false;
//     }
//
//     /// NON OF THEM IS NULL
//     else if (map1 != null && map2 != null){
//
//       if (map1.toString() == map2.toString()){
//         _mapsAreIdentical = true;
//       }
//       else {
//         _mapsAreIdentical = false;
//       }
//
//       // final List<String> _map1Keys = map1.keys.toList();
//       // final List<String> _map2Keys = map2.keys.toList();
//       //
//       // /// KEYS LENGTH ARE DIFFERENT
//       // if (_map1Keys.length != _map2Keys.length) {
//       //   _mapsAreIdentical = false;
//       // }
//       //
//       // /// KEYS LENGTH ARE IDENTICAL
//       // else {
//       //
//       //   /// FOR EACH PAIR
//       //   for (int i = 0; i < _map1Keys.length; i++){
//       //
//       //     final String _key1 = _map1Keys[i];
//       //     final String _key2 = _map1Keys[i];
//       //
//       //     /// KEYS ARE DIFFERENT
//       //     if (_key1 != _key2){
//       //       _mapsAreIdentical = false;
//       //       break;
//       //     }
//       //
//       //     /// KEYS ARE IDENTICAL
//       //     else {
//       //
//       //       /// BOTH VALUES ARE NULL
//       //       if (map1[_key1] == null && map2[_key2] == null){
//       //         // continue looping
//       //       }
//       //
//       //       /// BOTH VALUES ARE NOT NULL BUT ONE OF THEM IS
//       //       else if (map1[_key1] == null || map2[_key2] == null){
//       //         _mapsAreIdentical = false;
//       //         break;
//       //       }
//       //
//       //       /// BOTH VALUES ARE NOT NULL
//       //       else {
//       //
//       //         /// VALUE TYPES ARE DIFFERENT
//       //         if (map1[_key1].runtimeType != map2[_key2].runtimeType){
//       //           _mapsAreIdentical = false;
//       //           break;
//       //         }
//       //
//       //         /// VALUE TYPES ARE IDENTICAL
//       //         else {
//       //
//       //           if (
//       //               map1[_key1] is String ||
//       //               map1[_key1] is int ||
//       //               map1[_key1] is double ||
//       //               map1[_key1] is bool
//       //           ){
//       //
//       //             if (map1[_key1] != map2[_key2]){
//       //               _mapsAreIdentical = false;
//       //               break;
//       //             }
//       //
//       //           }
//       //
//       //           else if (map1[_key1] is List){
//       //
//       //           }
//       //
//       //         }
//       //
//       //       }
//       //
//       //
//       //     }
//       //
//       //   }
//       //
//       //   // final List<dynamic> _map1Values = map1.values.toList();
//       //   // final List<dynamic> _map2Values = map2.values.toList();
//       //   //
//       //   // if (
//       //   //     checkListsAreIdentical(list1: _map1Keys, list2: _map2Keys) == true
//       //   //     &&
//       //   //     checkListsAreIdentical(list1: _map1Values, list2: _map2Values) == true
//       //   // ){
//       //   //   _mapsAreIdentical = true;
//       //   // }
//       //   //
//       //   // else {
//       //   //   _mapsAreIdentical = false;
//       //   // }
//       //
//       // }
//
//     }
//
//     return _mapsAreIdentical;
//      */
//   }
//   // --------------------
//   /// AI TESTED
//   static bool _checkMapsListsAreIdentical({
//     required List<Map<String, dynamic>>? maps1,
//     required List<Map<String, dynamic>>? maps2,
//   }){
//
//     /// OLD BULLSHIT
//     // bool _listsAreIdentical = false;
//     //
//     // if (maps1 == null && maps2 == null){
//     //   _listsAreIdentical = true;
//     // }
//     //
//     // else if (maps1?.isEmpty && maps2 == []){
//     //   _listsAreIdentical = true;
//     // }
//     //
//     // else if (checkCanLoopList(maps1) == true && checkCanLoopList(maps2) == true){
//     //
//     //   if (maps1.length != maps2.length) {
//     //     _listsAreIdentical = false;
//     //   }
//     //
//     //   else {
//     //     for (int i = 0; i < maps1.length; i++) {
//     //
//     //       final bool _mapsAreIdentical = checkMapsAreIdentical(
//     //         map1: maps1[i],
//     //         map2: maps2[i],
//     //       );
//     //
//     //       if (_mapsAreIdentical == false) {
//     //         // blog('items at index ( $i ) do not match : ( ${maps1[i]} ) <=> ( ${maps2[i]} )');
//     //         _listsAreIdentical = false;
//     //         break;
//     //       }
//     //
//     //       else {
//     //         _listsAreIdentical = true;
//     //       }
//     //
//     //     }
//     //   }
//     //
//     // }
//     //
//     // if (_listsAreIdentical == false){
//     //   blogMapsListsDifferences(
//     //     maps1: maps1,
//     //     maps2: maps2,
//     //     invoker: 'checkMapsListsAreIdentical',
//     //   );
//     // }
//     // return _listsAreIdentical;
//
//     /// THIS DOES NOT CONDUCT DEEP MAP CHECK
//     // return checkListsAreIdentical(list1: maps1, list2: maps2);
//
//     /// ITERATE AND DEEP CHECK
//     bool _listsAreIdentical = false;
//
//     if (maps1 == null && maps2 == null){
//       _listsAreIdentical = true;
//     }
//     else if (maps1 != null && maps1.isEmpty == true && maps2 != null && maps2.isEmpty == true){
//       _listsAreIdentical = true;
//     }
//
//     else if (checkCanLoop(maps1) == true && checkCanLoop(maps2) == true){
//
//       if (maps1!.length != maps2!.length) {
//         // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
//         // blog(' ---> lis1 is ( ${list1.toString()} )');
//         // blog(' ---> lis2 is ( ${list2.toString()} )');
//         _listsAreIdentical = false;
//       }
//
//       else {
//         for (int i = 0; i < maps1.length; i++) {
//
//           if (_checkMapsAreIdentical(map1: maps1[i], map2: maps2[i]) == false){
//             // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');
//
//             if (maps1[i].toString() == maps2[i].toString()){
//               // blog('but they are equal when converted to string');
//               _listsAreIdentical = true;
//             }
//             else {
//               // blog('and they are not equal when converted to string');
//               _listsAreIdentical = false;
//               break;
//             }
//
//           }
//
//           else {
//             _listsAreIdentical = true;
//           }
//
//         }
//       }
//
//     }
//
//     return _listsAreIdentical;
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// OVERRIDES
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   @override
//   String toString() => '''
// CleoResponseModel(
//   id: $id,
//   text: $text,
//   choices: $choices,
//   function: $function,
//   data: $data,
// )
// ''';
//   // --------------------
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) {
//       return true;
//     }
//
//     bool _areIdentical = false;
//     if (other is MojoResponseModel) {
//       _areIdentical = checkModelsAreIdentical(
//         model1: this,
//         model2: other,
//       );
//     }
//
//     return _areIdentical;
//   }
//   // --------------------
//   ///
//   @override
//   int get hashCode => Object.hash(id, text, choices, function, data);
//   // --------------------------------------------------------------------------
// }
