part of mojo_brain;
/// => TAMAM
// abstract class CleoModelSerializer {
//   // --------------------------------------------------------------------------
//
//   /// MODEL SERIALIZATION
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<TextPart> userModelToCleoTextParts(UserModel? user){
//     final List<TextPart> _output = [
//       TextPart("Below are the UserModel's info, use this data to personalize your questions and tone"),
//     ];
//
//     /// USER IS NULL
//     if (user == null){
//       final TextPart _part = TextPart('user data is not available');
//       _output.add(_part);
//     }
//
//     /// WE HAVE USER
//     else {
//
//       final bool isAnonymous = user.signInMethod == SignInMethod.anonymous;
//
//       final List<TextPart> _parts = [
//         TextPart('id: ${user.id}'),
//         TextPart('isAnonymous: $isAnonymous'),
//         TextPart('name: ${user.name}'),
//         TextPart('title (job title): ${user.title}'),
//         TextPart('company : ${user.company}'),
//         TextPart('gender : ${user.gender}'),
//         TextPart('language : ${user.language}'),
//         TextPart('isAuthor : ${user.isAuthor}'),
//         if (user.zone?.countryID != null)
//           TextPart('countryID : ${user.zone!.countryID}'),
//         if (user.zone?.cityID != null)
//           TextPart('cityID : ${user.zone!.cityID}'),
//         if (user.location != null)
//           TextPart('location: lat(${user.location!.latitude}).lng(${user.location!.longitude})'),
//         if (Lister.checkCanLoop(user.myBzzIDs) == true)
//           TextPart('is a team member in (${user.myBzzIDs!.length}) companies on Bldrs.net'),
//         if (Lister.checkCanLoop(user.contacts) == true)
//           ...List.generate(user.contacts!.length, (int index){
//             final ContactModel _contact = user.contacts![index];
//             final String? _contactTypePhid = ContactModel.getContactTypePhid(contactType: _contact.type);
//             final String? _contactTypeString = TextMod.removeTextBeforeFirstSpecialCharacter(text: _contactTypePhid, specialCharacter: '_');
//             if (_contactTypeString == null){
//               return TextPart('');
//             }
//             else {
//               return TextPart('contact($_contactTypeString):${_contact.value}');
//             }
//           }),
//       ];
//
//       _output.addAll(_parts);
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<String?> bzModelToCleoText(BzModel? bz) async {
//
//     if (bz == null){
//       return null;
//     }
//
//     final buffer = StringBuffer();
//
//     if (bz.name != null) {
//       buffer.writeln('Business Name: ${bz.name}');
//     }
//
//     if (Lister.checkCanLoop(bz.bzTypes) == true) {
//
//       final String? _bzTypesString = await BzTyper.translateBzTypesIntoString(
//         bzTypes: bz.bzTypes,
//         bzForm: bz.bzForm,
//         oneLine: true,
//       );
//
//       buffer.writeln('Business Type(s): $_bzTypesString');
//     }
//
//     if (bz.bzForm != null) {
//       buffer.writeln('Business Form: ${bz.bzForm!.name}');
//     }
//
//     if (bz.scopes != null) {
//       final List<String> _phids = ScopeModel.getPhids(bz.scopes);
//       final String scopes = _phids.map((phid) => getWord(phid)).join(', ');
//       buffer.writeln('Services Offered: $scopes');
//     }
//
//     if (bz.about != null && bz.about!.isNotEmpty) {
//       buffer.writeln('About: ${bz.about}');
//     }
//
//     if (bz.zone?.countryID != null) {
//       buffer.writeln('CountryID: ${bz.zone!.countryID}');
//     }
//
//     if (bz.zone?.cityID != null) {
//       buffer.writeln('CityID: ${bz.zone!.cityID}');
//     }
//
//     if (bz.position != null) {
//       buffer.writeln('Location: lat=${bz.position!.latitude}, lng=${bz.position!.longitude}');
//     }
//
//     if (Booler.boolIsTrue(bz.isVerified) == true) {
//       buffer.writeln('This business is verified.');
//     }
//
//     // if (bz.power != null) {
//     //   buffer.writeln('Business Power: ${bz.power.}');
//     // }
//
//     if (bz.bzState != null) {
//       buffer.writeln('Current State: ${bz.bzState!.name}');
//     }
//
//     return '''
// Business Context Summary:
// ${buffer.toString().trim()}
// Use this information when presenting or referring to this business in the conversation.
// ''';
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<String?> keywordsMapToCleoText() async {
//     String? _output;
//
//     final Map<String, dynamic>? _map = await KeywordsProtocols.fetch();
//
//     if (_map != null){
//
//       await tryAndCatch(
//           invoker: 'keywordsMapToCleoText',
//           functions: () async {
//
//             final String jsonString = jsonEncode(_map);
//
//             _output =
// '''
// Here is the keyword tree (in JSON):
// $jsonString
// ''';
//
//           },
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   ///
//   static Future<String?> keywordsTranslationsToCleoText() async {
//     String? _output;
//
//     final Map<String, String>? _allTranslations = Localizer.instance.localizedValues;
//
//     if (_allTranslations != null){
//
//       final Map<String, String> _keywordsTranslationsMap = Map.fromEntries(
//         _allTranslations.entries.where((entry) {
//           final String? phid = entry.key;
//           return phid != null && Keyworder.checkIsPhidK(phid);
//         }),
//       );
//
//       if (Booler.boolIsTrue(_keywordsTranslationsMap.isNotEmpty) == true){
//         await tryAndCatch(
//           invoker: 'keywordsTranslationsToCleoText',
//           functions: () async {
//
//             final String jsonString = jsonEncode(_keywordsTranslationsMap);
//
//             _output =
//             '''
// Here is the keywords translations:
// $jsonString
// ''';
//
//           },
//         );
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<TextPart> questionModelToCleo(){
//     return [
//
//       /// id
//       TextPart('- `id` [auto-generated]: Unique identifier for the question. Cleo does not need to collect this.'),
//
//       /// text
//       TextPart('- `text` [mandatory]: The main description of what the user is looking for. Cleo should help the user write this clearly.'),
//
//       /// mediaURLs
//       TextPart('- `mediaURLs` [optional]: A list of image or video URLs attached to the question to better explain the request. Cleo can ask if the user wants to attach media.'),
//
//       /// chatsIDs
//       TextPart('- `chatsIDs` [auto-generated]: IDs of chats related to this question. Cleo does not need to handle this.'),
//
//       /// time
//       TextPart('- `time` [auto-generated]: Timestamp when the question was created. Cleo does not need to collect this.'),
//
//       /// phids
//       TextPart("- `phids` [mandatory]: A list of keyword IDs describing what the question is about (e.g. 'Interior Design', 'Concrete Works'), max 5 keywords & Cleo should conclude and suggest relevant keywords."),
//
//       /// askerID
//       TextPart('- `askerID` [optional]: The user ID of the person asking the question. If the user is signed in, this will be filled automatically.'),
//
//       /// contacts
//       TextPart('- `contacts` [mandatory]: A list of ways companies can contact the user (e.g. phone or email). Cleo must ask how the user prefers to be contacted.'),
//
//       /// views
//       TextPart('- `views` [auto-generated]: Number of times the question has been viewed. Cleo does not handle this.'),
//
//       /// askerBzID
//       TextPart('- `askerBzID` [optional]: If the user represents a business, this is the business ID. Cleo can include this if the user is speaking on behalf of a company.'),
//
//       /// isb2b
//       TextPart('- `isb2b` [optional]: If true, the question is from one business to other businesses. Cleo can determine this based on whether the user is acting as a company.'),
//
//       /// zone
//       TextPart('- `countryID` [mandatory]: The ISO3 country id of the user'),
//       TextPart('- `cityID` [mandatory]: the cityID or the user'),
//
//       /// summery
//       TextPart('- `summery` [optional]: A short summary or title of the question. Cleo can auto-generate this after gathering the full text.'),
//
//       /// type
//       TextPart('- `type` [optional]: The type of question. Cleo must ask the user to select one of the following:'),
//       TextPart('  • `requestForInfo`: (Request for Information) The user is asking for ideas, options, or general information.'),
//       TextPart('  • `requestForPrice`: (Request for Quotation) The user wants to receive price offers or quotations from businesses.'),
//
//       /// phase
//       TextPart('- `phase` [optional]: The project phase where this question applies. Cleo must ask the user to select one of the following:'),
//       TextPart('  • `lookingForProperty`: (Looking for property) The user is searching for land, apartment, or property.'),
//       TextPart('  • `planningConstruction`: (Planning Construction) The user is preparing design, drawings, or choosing materials.'),
//       TextPart('  • `underConstruction`: (Under Construction) The user is executing the project and needs services or supplies.'),
//       TextPart('  • `furnishing`: (Furnishing) The user is completing finishes, furniture, or interior details.'),
//
//
//     ];
//   }
//   // --------------------
//   void x(){}
//   // -----------------------------------------------------------------------------
// }
