part of mojo_brain;

// @immutable
// class CleoResponseModel {
//   // -----------------------------------------------------------------------------
//   const CleoResponseModel({
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
//   CleoResponseModel copyWith({
//     String? id,
//     String? text,
//     List<String>? choices,
//     String? function,
//     Map<String, dynamic>? data,
//   }) {
//     return CleoResponseModel(
//       id: id ?? this.id,
//       text: text ?? this.text,
//       choices: choices ?? this.choices,
//       function: function ?? this.function,
//       data: data ?? this.data,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   CleoResponseModel nullifyField({
//     bool id = false,
//     bool text = false,
//     bool choices = false,
//     bool function = false,
//     bool data = false,
//   }) {
//     return CleoResponseModel(
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
//     required List<CleoResponseModel>? models,
//   }) {
//     final List<Map<String, dynamic>> _output = [];
//
//     if (Lister.checkCanLoop(models) == true) {
//       for (final CleoResponseModel model in models!) {
//         _output.add(model.toMap());
//       }
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static CleoResponseModel? decipherMap({
//     required Map<String, dynamic>? map,
//   }) {
//     CleoResponseModel? _output;
//
//     if (map != null) {
//       _output = CleoResponseModel(
//         id: map['id'] ?? '',
//         text: map['text'] ?? '',
//         choices: Stringer.getStringsFromDynamics(map['choices']),
//         function: map['function'],
//         data: map['data'],
//       );
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<CleoResponseModel> decipherMaps({
//     required List<Map<String, dynamic>>? maps,
//   }) {
//     final List<CleoResponseModel> _output = [];
//
//     if (Lister.checkCanLoop(maps) == true) {
//       for (final Map<String, dynamic> map in maps!) {
//         final CleoResponseModel? _model = decipherMap(map: map);
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
//   static CleoResponseModel? decipherContentResponse({
//     required GenerateContentResponse? response,
//   }){
//     CleoResponseModel? _output;
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
//           onError: (String error){
//             Errorize.throwMap(
//               invoker: 'decipherContentResponse',
//               map: {
//                 'theError': error,
//                 'responseText': response.text,
//                 'totalTokenCount': response.usageMetadata?.totalTokenCount,
//               },
//             );
//           }
//         );
//       }
//
//       if (_decoded != null){
//
//         final Map<String, dynamic>? _map = Mapper.getMapFromIHLMOO(
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
//     required CleoResponseModel? model1,
//     required CleoResponseModel? model2,
//   }) {
//     return Mapper.checkMapsAreIdentical(
//       map1: model1?.toMap(),
//       map2: model2?.toMap(),
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool checkModelsListsAreIdentical({
//     required List<CleoResponseModel>? models1,
//     required List<CleoResponseModel>? models2,
//   }) {
//     return Mapper.checkMapsListsAreIdentical(
//       maps1: cipherToMaps(models: models1),
//       maps2: cipherToMaps(models: models2),
//     );
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
//     if (other is CleoResponseModel) {
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
