part of mojo_brain;
/// => TAMAM
// class CleoLocalExporter {
//   // -----------------------------------------------------------------------------
//
//   /// EXPORT CHAT MAP
//
//   // --------------------
//   ///
//   static Future<void> exportConversationLocally({
//     required List<Content> history,
//     required List<DMModel> dms,
//     required String? userName,
//   }) async {
//     bool _success = false;
//     Verse? _successVerse;
//     Verse? _failVerse;
//
//     /// WE HAVE HISTORY
//     if (Lister.checkCanLoop(history) == true){
//
//       final DMModel _initialDM = DMModel(
//         id: 'initial',
//         ownerID: 'cleo',
//         text: getWord('phid_cleo_intro'),
//         time: null,
//       );
//
//       final Map<String, dynamic>? _map = DMModel.cipherToChatLogMap(
//         models: [_initialDM, ...dms],
//         userName: userName,
//         toJSON: true,
//       );
//
//       const String _fileName = 'cleo_conv';
//
//       _success = await LocalJSON.exportMapNew(
//         map: _map,
//         fileName: _fileName,
//       );
//
//       if (_success == true){
//
//         final BuildContext context = getTheMainContext();
//
//         const String _command = '''
// adb pull /sdcard/Android/data/net.bldrs.app/files/$_fileName.json 'C:\\Users\\rageh\\Downloads'
// ''';
//
//         await Dialogs.confirmProceed(
//           headlineVerse: Verse.plain('Copy and run those commands'),
//           bodyVerse: Verse.plain(_command),
//         );
//
//         await KeyboardModel.copyToClipboardAndNotify(
//           context: context,
//           copy: _command,
//         );
//
//         await BldrsCenterDialog.showCenterDialog(
//           headlineVerse: Verse.plain('exported chat history'),
//           bodyVerse: Verse.plain('Copy Location'),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//
//               BldrsBox(
//                 height: 40,
//                 width: BldrsCenterDialog.clearWidth(context),
//                 verse: Verse.plain(r'COPY : C:\Users\rageh\Downloads'),
//                 verseScaleFactor: 0.8,
//                 color: Colorz.yellow50,
//                 margins: const EdgeInsets.symmetric(vertical: 5),
//                 onTap: () => KeyboardModel.copyToClipboardAndNotify(
//                   context: context,
//                   copy: r'C:\Users\rageh\Downloads',
//                 ),
//               ),
//
//             ],
//           ),
//         );
//
//       }
//
//     }
//
//     /// EMPTY HISTORY
//     else {
//       _failVerse = Verse.plain('No chat history to export');
//     }
//
//     await Dialogs.stateDialog(
//       state: _success,
//       failVerse: _failVerse,
//       successVerse: _successVerse,
//     );
//
//   }
//   // -----------------------------------------------------------------------------
// }
