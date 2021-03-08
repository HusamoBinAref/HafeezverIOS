import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, DocumentSnapshot, Timestamp;
import 'package:hafeez/generated/l10n.dart';
import 'package:intl/intl.dart';

import '../../../../classes/commends/key_words.dart';
import '../../../Item/set/api/get.dart';
import '../../../../model/authentication/api/authentication.dart';
import '../widget/edit/references.dart';
import '../widget/root.dart';

import 'profile/api/get.dart';
import 'information/api/dead.dart';
import 'connection/api/email.dart';
import 'connection/api/phone.dart';
import 'experience/api/experience.dart';
import 'favorite/one/api/get.dart';
import 'favorite/set/api/get.dart';
import 'followedS/api/followed.dart';
import 'information/api/nationality.dart';
import 'information/api/prith.dart';
import 'skill/api/skills.dart';

class Account {
  static Account empty(DocumentReference documentReference) {
    return Account(
      inPutreference: documentReference,
    );
  }

  static Account build(DocumentSnapshot snapshot) {
    return Account(snapshot: snapshot);
  }

  final DocumentSnapshot snapshot;
  final DocumentReference inPutreference;

  Account({
    this.snapshot,
    this.inPutreference,
  });

  DocumentReference get reference =>
      snapshot != null ? snapshot.reference : inPutreference;

// internal feilds
  Map<String, dynamic> get _map => snapshot != null ? snapshot.data() : {};
  bool get isWork => _map['isWork'] ?? false;
  bool get isSheikh => _map['isSheikh'] ?? false;
  bool get isManager => _map['isManager'] ?? false;

  List<DocumentReference> get references =>
      List<DocumentReference>.from(_map['references'] ?? []);

  List<DocumentReference> get languages => references
      .where((language) => language.path.contains("Language"))
      .toList();

  List<DocumentReference> get specializations => references
      .where((specialization) => specialization.path.contains("Specialization"))
      .toList();

  /// * get departments of item
  AccountReferences get referencesAll => AccountReferences(
      references: List<DocumentReference>.from(_map['references'] ?? []),
      account: this);

  List<DocumentReference> get countries =>
      references.where((country) => country.path.contains("Country")).toList();

  DateTime get createAt => (_map['createAt'] as Timestamp ?? null).toDate();

  String get createString =>
      DateFormat.yMMMd(S.current.languageCode).format(createAt);

  GetFavorite get favoriteStatus => GetAuthentication().isAuth
      ? GetFavorite.buildForAccount(
          reference: reference,
          type: isSheikh ? KeyWords.isSheikh : KeyWords.isAccount)
      : GetFavorite(
          reference: reference,
          type: isSheikh ? KeyWords.isSheikh : KeyWords.isAccount,
        );

// profile data
  GetProfile get profile => GetProfile(reference: reference);

// connection E-mails and phone

  /// Account's Phone
  GetPhone get phone =>
      GetPhone(reference: reference.collection('Connection').doc('phone'));

  /// Account's Gmail
  GetEmail get gmail =>
      GetEmail(reference: reference.collection('Connection').doc('gmail'));

  /// Account's Facebook
  GetEmail get facebook =>
      GetEmail(reference: reference.collection('Connection').doc('facebook'));

  /// Account's Instagram
  GetEmail get instagram =>
      GetEmail(reference: reference.collection('Connection').doc('instagram'));

  /// Account's Twitter
  GetEmail get twitter =>
      GetEmail(reference: reference.collection('Connection').doc('twitter'));

// extra information

  /// Account's Prith day and prith location
  GetPrith get prith =>
      GetPrith(reference: reference.collection('Information').doc('prith'));

  GetDead get dead =>
      GetDead(reference: reference.collection('Information').doc('dead'));

  /// Account's nationalites
  GetNationality get nationality => GetNationality(
      reference: reference.collection('Information').doc('nationality'));

  /// skills
  GetSkills get skills => GetSkills(reference: reference.collection('Skill'));

  /// experiences
  GetExperience get experiences =>
      GetExperience(reference: reference.collection('Experience'));

  /// favorite items
  GetFavorites get favorites => GetFavorites.build(reference);

  /// voting items
  dynamic get votingItems => reference.collection('Voting');

  /// events
  dynamic get events => reference.collection('Event');

  /// items
  GetItems get items => GetItems.buildForAccount(reference);

  /// Relationships/friends/Friends
  get freinds => null;

  /// Relationships/followeds/Followeds
  GetFolloweds get followeds => GetFolloweds(
      reference: reference
          .collection('Relationships')
          .doc('followeds')
          .collection('Followeds'));

  AccountWidgets get widgets => AccountWidgets(data: this);
}
