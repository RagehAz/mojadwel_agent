part of mojo_brain;
/// => TAMAM
// abstract class CleoRecorder {
//   // --------------------------------------------------------------------------
//   /*
//
//   cleo_conversations
//     |- users
//     |     |- userID: true
//     |     |- userID: true
//     |     |- ...
//     |
//     |- userID
//     |     |- conversations
//     |     |     |- conversationID: true
//     |     |     |- conversationID: true
//     |     |     |- ...
//     |     |
//     |     |- conversationID
//     |     |     |- dmID
//     |     |     |     | - ownerID
//     |     |     |     | - time
//     |     |     |     | - text
//     |     |     |-...
//     |     |-...
//     |- ...
//
//    */
//   // --------------------------------------------------------------------------
//   static const String cleoConversationsDoc = 'cleo_conversations';
//   static const String usersNode = 'users';
//   static const String conversationsNode = 'conversations';
//   // --------------------------------------------------------------------------
//
//   /// CREATE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static void recordDmSync({
//     required String? conversationID,
//     required DMModel dm,
//     required int index,
//   }) {
//     asyncInSync(() async {
//       await recordDm(
//         index: index,
//         dm: dm,
//         conversationID: conversationID,
//       );
//     });
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> recordDm({
//     required String? conversationID,
//     required DMModel dm,
//     required int index,
//   }) async {
//     bool _success = false;
//
//     final String? userID = OfficialAuthing.getUserID();
//
//     if (userID != null && conversationID != null){
//
//       final Map<String, dynamic>? _map = await OfficialReal.createDocInPath(
//         isConnected: GeneralPro.deviceIsConnected(),
//         pathWithoutDocName: '$cleoConversationsDoc/$userID/$conversationID',
//         doc: dm.id,
//         map: {
//           'ownerID': dm.ownerID,
//           'time': Timers.cipherTime(time: dm.time, toJSON: true),
//           'text': dm.text,
//         },
//       );
//
//       if (index == 0){
//         await OfficialReal.updateDocField(
//           isConnected: GeneralPro.deviceIsConnected(),
//           coll: cleoConversationsDoc,
//           doc: usersNode,
//           field: userID,
//           value: true,
//         );
//         await OfficialReal.updateDocField(
//           isConnected: GeneralPro.deviceIsConnected(),
//           coll: cleoConversationsDoc,
//           doc: '$userID/$conversationsNode',
//           field: conversationID,
//           value: true,
//         );
//       }
//
//       _success = _map != null;
//
//     }
//
//     return _success;
//   }
//   // --------------------------------------------------------------------------
//
//   /// READ
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<String>> readConversationsIDs({
//     required String? userID,
//   }) async {
//     List<String> _output = <String>[];
//
//     if (userID != null){
//
//       final Map<String, dynamic>? _map = await OfficialReal.readPathMap(
//           isConnected: GeneralPro.deviceIsConnected(),
//           path: '$cleoConversationsDoc/$userID/$conversationsNode',
//       );
//
//       if (_map != null){
//         _output = _map.keys.toList();
//         _output.remove('id');
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<DMModel>> readConversation({
//     required String? userID,
//     required String? conversationID,
//   }) async {
//     final List<DMModel> _output = [];
//
//     if (userID != null && conversationID != null){
//
//       final Map<String, dynamic>? _bigMap = await OfficialReal.readPathMap(
//         isConnected: GeneralPro.deviceIsConnected(),
//         path: '$cleoConversationsDoc/$userID/$conversationID',
//       );
//
//       if (_bigMap != null){
//
//         final List<String> _keys = _bigMap.keys.toList();
//         _keys.remove('id');
//
//         Lister.loopSync(
//           models: _keys,
//           onLoop: (int index, String? dmID){
//
//             if (dmID != null){
//
//               Map<String, dynamic>? _map = _bigMap[dmID];
//               _map = Mapper.insertPairInMap(
//                 map: _map,
//                 key: 'id',
//                 value: dmID,
//                 overrideExisting: true,
//               );
//
//               final DMModel? _dm = DMModel.decipherMap(
//                   map: _map,
//                   fromJSON: true,
//               );
//
//               if (_dm != null){
//                 _output.add(_dm);
//               }
//
//             }
//
//           },
//         );
//
//       }
//
//     }
//
//     return DMModel.sortConversation(
//       dms: _output,
//     );
//   }
//   // --------------------------------------------------------------------------
// }
