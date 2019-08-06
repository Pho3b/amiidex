import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class I18n implements WidgetsLocalizations {
  static GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  static I18n of(BuildContext context) =>
      Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  Map<String, String> _localizedValues = <String, String>{};

  String text(String id) {
    return _localizedValues[id] ?? '** "$id" not found';
  }
}

class _I18nEnUS extends I18n {
  _I18nEnUS() {
    _localizedValues = <String, String>{
      'appname': 'AmiiDex',
      'en_US': 'English',
      'fr_FR': 'Français',
      'settings-general': 'General',
      'settings-language': 'Language',
      'settings-theme': 'Theme',
      'settings-light-theme': 'Light Theme',
      'settings-dark-theme': 'Dark Theme',
      'settings-collection': 'Collection',
      'settings-collection-reset': 'Reset',
      'settings-collection-reset-question':
          'Do you want to reset your amiibo collection?',
      'settings-collection-reset-cancel-button': 'Cancel',
      'settings-collection-reset-reset-button': 'Reset',
      'collection-search': 'Search amiibo',
      'collection-unlocked': 'Collection locked',
      'collection-locked': 'Collection unlocked',
      'missing-added': 'Added %s to collection.',
      'owned-removed': 'Removed %s from collection.',
      'privacy-title': 'Privacy Policy',
      'amiibo-actionbar-sort-by': 'Sort by',
      'actionbar-sort-name': 'Name',
      'actionbar-sort-release-date': 'Release date',
      'actionbar-region-title': 'Region',
      'actionbar-region-europe': 'Europe',
      'actionbar-region-japan': 'Japan',
      'actionbar-region-north-america': 'North America',
      'actionbar-viewas-title': 'View As',
      'actionbar-viewas-list': 'List',
      'actionbar-viewas-grid-small-icons': 'Grid - small icons',
      'actionbar-viewas-grid-large-icons': 'Grid - large icons',
      'bottom-navbar-collection': 'Collection',
      'bottom-navbar-owned': 'Owned',
      'bottom-navbar-missing': 'Missing',
      'bottom-navbar-statistics': 'Stats',
      'detail-nothing-to-display': 'No amiibo to display!',
      'drawer-settings': 'Settings',
      'drawer-privacy': 'Privacy',
      'drawer-github-source-code': 'Source Code on Github',
      'drawer-github-issue': 'Report Issue on Github',
      'drawer-about': 'About',
      'drawer-about-copyright': 'Copyright © 2019, C. Bonello',
      'fab-scan-add-dialog-title': 'Add amiibo',
      'fab-scan-add-dialog-owned': 'No new amiibo!',
      'fab-scan-add-dialog-add': 'Add amiibo to collection?',
      'fab-scan-barcode': 'Barcode: %s',
      'fab-scan-amiibo-name': 'Name: %s',
      'fab-scan-amiibo-status-owned': 'Status: Owned',
      'fab-scan-amiibo-status-not-owned': 'Status: Not owned',
      'fab-scan-error-dialog-title': 'Barcode Scan',
      'fab-scan-unknown-barcode':
          'Scanned barcode %s does not correspond to a known amiibo box.',
      'cancel-button': 'Cancel',
      'add-button': 'Add',
      'ok-button': 'OK',
      'error-dialog-title': 'Erreur',
      'webview-title': 'Nintendo',
      'webview-no-back-history': 'No back history item',
      'webview-no-forward-history': 'No forward history item',
      'stats-amiibo-count': 'Number of amiibo: %d',
      'piechart-owned': 'Owned (%d)',
      'piechart-missing': 'Missing (%d)',
      'ssb': 'Super Smash Bros.',
      'ssb_mario': 'Mario',
      'ssb_peach': 'Peach',
      'ssb_yoshi': 'Yoshi',
      'ssb_donkey_kong': 'Donkey Kong',
      'ssb_link': 'Link',
      'ssb_fox': 'Fox',
      'ssb_samus': 'Samus',
      'ssb_wii_fit_trainer': 'Wii Fit Trainer',
      'ssb_villager': 'Villager',
      'ssb_pikachu': 'Pikachu',
      'ssb_kirby': 'Kirby',
      'ssb_marth': 'Marth',
      'ssb_zelda': 'Zelda',
      'ssb_diddy_kong': 'Diddy Kong',
      'ssb_luigi': 'Luigi',
      'ssb_little_mac': 'Little Mac',
      'ssb_pit': 'Pit',
      'ssb_captain_falcon': 'Captain Falcon',
      'ssb_rosalina': 'Rosalina',
      'ssb_bowser': 'Bowser',
      'ssb_lucario': 'Lucario',
      'ssb_toon_link': 'Toon Link',
      'ssb_sheik': 'Sheik',
      'ssb_ike': 'Ike',
      'ssb_shulk': 'Shulk',
      'ssb_sonic': 'Sonic',
      'ssb_megaman': 'Mega Man',
      'ssb_king_dedede': 'King Dedede',
      'ssb_meta_knight': 'Meta Knight',
      'ssb_robin': 'Robin',
      'ssb_lucina': 'Lucina',
      'ssb_wario': 'Wario',
      'ssb_charizard': 'Charizard',
      'ssb_ness': 'Ness',
      'ssb_pacman': 'PAC_MAN',
      'ssb_greninja': 'Greninja',
      'ssb_jigglypuff': 'Jigglypuff',
      'ssb_palutena': 'Palutena',
      'ssb_dark_pit': 'Dark Pit',
      'ssb_zero_suit_samus': 'Zero Suit Samus',
      'ssb_ganondorf': 'Ganondorf',
      'ssb_dr_mario': 'Dr. Mario',
      'ssb_bowser_jr': 'Bowser Jr.',
      'ssb_olimar': 'Olimar',
      'ssb_mr_game_watch': 'Mr. Game & Watch',
      'ssb_rob_ness': 'R.O.B.',
      'ssb_duck_hunt': 'Duck Hunt',
      'ssb_mii_brawler': 'Mii Brawler',
      'ssb_mii_swordfighter': 'Mii Swordfighter',
      'ssb_mii_gunner': 'Mii Gunner',
      'ssb_mewtwo': 'Mewtwo',
      'ssb_falco': 'Falco',
      'ssb_lucas': 'Lucas',
      'ssb_rob_famicom': 'R.O.B. (Famicom)',
      'ssb_roy': 'Roy',
      'ssb_ryu': 'Ryu',
      'ssb_cloud': 'Cloud',
      'ssb_cloud_player_2': 'Cloud - Player 2',
      'ssb_corrin': 'Corrin',
      'ssb_corrin_player_2': 'Corrin - Player 2',
      'ssb_bayonetta': 'Bayonetta',
      'ssb_bayonetta_player_2': 'Bayonetta - Player 2',
      'ssb_inkling': 'Inkling',
      'ssb_ridley': 'Ridley',
      'ssb_wolf': 'Wolf',
      'ssb_piranha_plant': 'Piranha Plant',
      'ssb_king_k_rool': 'King K. Rool',
      'ssb_ice_climbers': 'Ice Climbers',
      'ssb_ken': 'Ken',
      'ssb_young_link': 'Young Link',
      'ssb_daisy': 'Daisy',
      'ssb_pokémon_trainer': 'Pokémon Trainer',
      'ssb_pichu': 'Pichu',
      'ssb_isabelle': 'Isabelle',
      'sm': 'Super Mario',
      'sm_mario': 'Mario',
      'sm_luigi': 'Luigi',
      'sm_peach': 'Peach',
      'sm_yoshi': 'Yoshi',
      'sm_toad': 'Toad',
      'sm_bowser': 'Bowser',
      'sm_mario_gold_edition': 'Mario - Gold Edition',
      'sm_mario_silver_edition': 'Mario - Silver Edition',
      'sm_wario': 'Wario',
      'sm_waluigi': 'Waluigi',
      'sm_daisy': 'Daisy',
      'sm_rosalina': 'Rosalina',
      'sm_boo': 'Boo',
      'sm_donkey_kong': 'Donkey Kong',
      'sm_diddy_kong': 'Diddy Kong',
      'sm_goomba': 'Goomba',
      'sm_koopa_troopa': 'Koopa Troopa',
      'smo': 'Super Mario Odyssey',
      'smo_mario_wedding_outfit': 'Mario (Wedding Outfit)',
      'smo_peach_wedding_outfit': 'Peach (Wedding Outfit)',
      'smo_bowser_wedding_outfit': 'Bowser (Wedding Outfit)',
      'smb30': 'Super Mario Bros. 30th Anniversary',
      'smb30_mario_classic_color': 'Mario - Classic Color',
      'smb30_mario_modern_color': 'Mario - Modern Color',
      'zld': 'The Legend of Zelda',
      'zld_wolf_link': 'Wolf Link',
      'zld_link_archer': 'Link (Archer)',
      'zld_link_rider': 'Link (Rider)',
      'zld_guardian': 'Guardian',
      'zld_zelda': 'Zelda',
      'zld_bokoblin': 'Bokoblin',
      'zld_revali': 'Revali',
      'zld_mipha': 'Mipha',
      'zld_daruk': 'Daruk',
      'zld_urbosa': 'Urbosa',
      'zld_link_ocarina_of_time': 'Link - Ocarina of Time',
      'zld_link_the_legend_of_zelda': 'Link - The Legend of Zelda',
      'zld_toon_link_the_wind_waker': 'Toon Link - The Wind Waker',
      'zld_zelda_the_wind_waker': 'Zelda - The Wind Waker',
      'zld_link_majora_s_mask': 'Link - Majora\'s Mask',
      'zld_link_twilight_princess': 'Link - Twilight Princess',
      'zld_link_skyward_sword': 'Link - Skyward Sword',
      'spl': 'Splatoon',
      'spl_inkling_girl_1': 'Inkling Girl',
      'spl_inkling_boy_1': 'Inkling Boy',
      'spl_inkling_squid_1': 'Inkling Squid',
      'spl_callie': 'Callie',
      'spl_marie': 'Marie',
      'spl_inkling_girl_2': 'Inkling Girl',
      'spl_inkling_boy_2': 'Inkling Boy',
      'spl_inkling_squid_2': 'Inkling Squid',
      'spl_inkling_girl_3': 'Inkling Girl',
      'spl_inkling_boy_3': 'Inkling Boy',
      'spl_inkling_squid_3': 'Inkling Squid',
      'spl_pearl': 'Pearl',
      'spl_marina': 'Marina',
      'spl_octoling_girl': 'Octoling Girl',
      'spl_octoling_boy': 'Octoling Boy',
      'spl_octoling_octopus': 'Octoling Octopus',
      'ac': 'Animal Crossing',
      'ac_isabelle_winter_outfit': 'Isabelle - Winter Outfit',
      'ac_tom_nook': 'Tom Nook',
      'ac_kk': 'K.K.',
      'ac_mabel': 'Mabel',
      'ac_digby': 'Digby',
      'ac_lottie': 'Lottie',
      'ac_cyrus': 'Cyrus',
      'ac_reese': 'Reese',
      'ac_blathers': 'Blathers',
      'ac_celeste': 'Celeste',
      'ac_resetti': 'Resetti',
      'ac_kicks': 'Kicks',
      'ac_timmy_tommy': 'Timmy & Tommy',
      'ac_kapp_n': 'Kapp\'n',
      'ac_rover': 'Rover',
      'ac_isabelle_summer_outfit': 'Isabelle - Summer Outfit',
      'yww': 'Yoshi\'s Woolly World',
      'yww_green_yarn_yoshi': 'Green Yarn Yoshi',
      'yww_pink_yarn_yoshi': 'Pink Yarn Yoshi',
      'yww_light_blue_yarn_yoshi': 'Light Blue Yarn Yoshi',
      'yww_mega_yarn_yoshi': 'Mega Yarn Yoshi',
      'yww_poochy': 'Poochy',
      'krb': 'Kirby',
      'krb_kirby': 'Kirby',
      'krb_meta_knight': 'Meta Knight',
      'krb_king_dedede': 'King Dedede',
      'krb_waddle_dee': 'Waddle Dee',
      'fe': 'Fire Emblem',
      'fe_alm': 'Alm',
      'fe_celica': 'Celica',
      'fe_chrom': 'Chrom',
      'fe_tiki': 'Tiki',
      'mtr': 'Metroid',
      'mtr_samus_aran': 'Samus Aran',
      'mtr_metroid': 'Metroid',
      'sk': 'Shovel Knight',
      'sk_shovel_knight': 'Shovel Knight',
      'cr': 'Chibi_Robo',
      'cr_chibi_robo': 'Chibi_Robo',
      'bb': 'Box Boy!',
      'bb_qbby': 'Qbby',
      'pkm': 'Pikmin',
      'pkm_pikmin': 'Pikmin',
      'dpk': 'Detective Pikachu',
      'dpk_detective_pikachu': 'Detective Pikachu',
      'dks': 'Dark Souls',
      'dks_solaire_of_astora': 'Solaire of Astora',
      'mgmce': 'Mega Man Collector\'s Edition',
      'mgmce_megaman_gold': 'Mega Man - Gold Edition'
    };
  }

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18nFrFR extends I18n {
  _I18nFrFR() {
    _localizedValues = <String, String>{
      'appname': 'AmiiDex',
      'en_US': 'English',
      'fr_FR': 'Français',
      'settings-general': 'Général',
      'settings-language': 'Langue',
      'settings-theme': 'Thème',
      'settings-light-theme': 'Thème clair',
      'settings-dark-theme': 'Thème sombre',
      'settings-collection': 'Collection',
      'settings-collection-reset': 'Réinitialisation',
      'settings-collection-reset-question':
          'Voulez-vous réinitialiser votre collection d\'amiibo ?',
      'settings-collection-reset-cancel-button': 'Annuler',
      'settings-collection-reset-reset-button': 'Réinitialiser',
      'collection-search': 'Recherche amiibo',
      'collection-unlocked': 'Collection verrouillée',
      'collection-locked': 'Collection déverrouillée',
      'missing-added': '%s a été ajouté à la collection.',
      'owned-removed': '%s a été enlevé de la collection.',
      'privacy-title': 'Politique de confidentialité',
      'amiibo-actionbar-sort-by': 'Trier par',
      'actionbar-sort-name': 'Nom',
      'actionbar-sort-release-date': 'Date de sortie',
      'actionbar-region-title': 'Région',
      'actionbar-region-europe': 'Europe',
      'actionbar-region-japan': 'Japon',
      'actionbar-region-north-america': 'Amérique du nord',
      'actionbar-viewas-title': 'Afficher comme',
      'actionbar-viewas-list': 'Liste',
      'actionbar-viewas-grid-small-icons': 'Grille - petites icônes',
      'actionbar-viewas-grid-large-icons': 'Grille - grandes icônes',
      'bottom-navbar-collection': 'Collection',
      'bottom-navbar-owned': 'Possédé',
      'bottom-navbar-missing': 'Manquant',
      'bottom-navbar-statistics': 'Statistiques',
      'detail-nothing-to-display': 'Aucuns amiibo !',
      'drawer-settings': 'Paramètres',
      'drawer-privacy': 'Confidentialité',
      'drawer-github-source-code': 'Code source sur Github',
      'drawer-github-issue': 'Signaler un problème sur Github',
      'drawer-about': 'A propos',
      'drawer-about-copyright': 'Copyright © 2019, C. Bonello',
      'fab-scan-add-dialog-title': 'Ajouter amiibo',
      'fab-scan-add-dialog-owned': 'Aucun nouvel amiibo n\'a été détecté !',
      'fab-scan-add-dialog-add':
          'Voulez-vous ajouter l\'amiibo à votre collection ?',
      'fab-scan-barcode': 'Code barre: %s',
      'fab-scan-amiibo-name': 'Nom: %s',
      'fab-scan-amiibo-status-owned': 'Status: possédé',
      'fab-scan-amiibo-status-not-owned': 'Status: manquant',
      'fab-scan-error-dialog-title': 'Code-barres',
      'fab-scan-unknown-barcode':
          'Le code-barres scanné %s ne correspond pas à un amiibo reconnu par AmiiDex.',
      'cancel-button': 'Annuler',
      'add-button': 'Ajouter',
      'ok-button': 'OK',
      'error-dialog-title': 'Erreur',
      'webview-title': 'Nintendo',
      'webview-no-back-history': 'Pas d\'historique',
      'webview-no-forward-history': 'Pas d\'historique',
      'stats-amiibo-count': 'Nombre d\'amiibo: %d',
      'piechart-owned': 'Possédé (%d)',
      'piechart-missing': 'Manquant (%d)',
      'ssb': 'Super Smash Bros.',
      'ssb_mario': 'Mario',
      'ssb_peach': 'Peach',
      'ssb_yoshi': 'Yoshi',
      'ssb_donkey_kong': 'Donkey Kong',
      'ssb_link': 'Link',
      'ssb_fox': 'Fox',
      'ssb_samus': 'Samus',
      'ssb_wii_fit_trainer': 'Entraîneuse Wii Fit',
      'ssb_villager': 'Villageois',
      'ssb_pikachu': 'Pikachu',
      'ssb_kirby': 'Kirby',
      'ssb_marth': 'Marth',
      'ssb_zelda': 'Zelda',
      'ssb_diddy_kong': 'Diddy Kong',
      'ssb_luigi': 'Luigi',
      'ssb_little_mac': 'Little Mac',
      'ssb_pit': 'Pit',
      'ssb_captain_falcon': 'Captain Falcon',
      'ssb_rosalina': 'Harmonie',
      'ssb_bowser': 'Bowser',
      'ssb_lucario': 'Lucario',
      'ssb_toon_link': 'Link Cartoon',
      'ssb_sheik': 'Sheik',
      'ssb_ike': 'Ike',
      'ssb_shulk': 'Shulk',
      'ssb_sonic': 'Sonic',
      'ssb_megaman': 'Mega Man',
      'ssb_king_dedede': 'Roi DaDiDou',
      'ssb_meta_knight': 'Meta Knight',
      'ssb_robin': 'Daraen',
      'ssb_lucina': 'Lucina',
      'ssb_wario': 'Wario',
      'ssb_charizard': 'Dracaufeu',
      'ssb_ness': 'Ness',
      'ssb_pacman': 'PAC_MAN',
      'ssb_greninja': 'Amphinobi',
      'ssb_jigglypuff': 'Rondoudou',
      'ssb_palutena': 'Palutena',
      'ssb_dark_pit': 'Pit maléfique',
      'ssb_zero_suit_samus': 'Samus sans armure',
      'ssb_ganondorf': 'Ganondorf',
      'ssb_dr_mario': 'Dr. Mario',
      'ssb_bowser_jr': 'Bowser Jr.',
      'ssb_olimar': 'Olimar',
      'ssb_mr_game_watch': 'Mr. Game & Watch',
      'ssb_rob_ness': 'R.O.B.',
      'ssb_duck_hunt': 'Duo Duck Hunt',
      'ssb_mii_brawler': 'Boxeur Mii',
      'ssb_mii_swordfighter': 'Épéiste Mii',
      'ssb_mii_gunner': 'Tireuse Mii',
      'ssb_mewtwo': 'Mewtwo',
      'ssb_falco': 'Falco',
      'ssb_lucas': 'Lucas',
      'ssb_rob_famicom': 'R.O.B. (couleurs Famicom)',
      'ssb_roy': 'Roy',
      'ssb_ryu': 'Ryu',
      'ssb_cloud': 'Cloud',
      'ssb_cloud_player_2': 'Cloud (joueur 2)',
      'ssb_corrin': 'Corrin',
      'ssb_corrin_player_2': 'Corrin (joueur 2)',
      'ssb_bayonetta': 'Bayonetta',
      'ssb_bayonetta_player_2': 'Bayonetta (joueur 2)',
      'ssb_inkling': 'Inkling',
      'ssb_ridley': 'Ridley',
      'ssb_wolf': 'Wolf',
      'ssb_piranha_plant': 'Plante Piranha',
      'ssb_king_k_rool': 'King K. Rool',
      'ssb_ice_climbers': 'Ice Climbers',
      'ssb_ken': 'Ken',
      'ssb_young_link': 'Link enfant',
      'ssb_daisy': 'Daisy',
      'ssb_pokémon_trainer': 'Dresseur de Pokémon',
      'ssb_pichu': 'Pichu',
      'ssb_isabelle': 'Marie',
      'sm': 'Super Mario',
      'sm_mario': 'Mario',
      'sm_luigi': 'Luigi',
      'sm_peach': 'Peach',
      'sm_yoshi': 'Yoshi',
      'sm_toad': 'Toad',
      'sm_bowser': 'Bowser',
      'sm_mario_gold_edition': 'Mario (édition or)',
      'sm_mario_silver_edition': 'Mario (édition argent)',
      'sm_wario': 'Wario',
      'sm_waluigi': 'Waluigi',
      'sm_daisy': 'Daisy',
      'sm_rosalina': 'Harmonie',
      'sm_boo': 'Boo',
      'sm_donkey_kong': 'Donkey Kong',
      'sm_diddy_kong': 'Diddy Kong',
      'sm_goomba': 'Goomba',
      'sm_koopa_troopa': 'Koopa',
      'smo': 'Super Mario Odyssey',
      'smo_mario_wedding_outfit': 'Mario',
      'smo_peach_wedding_outfit': 'Peach',
      'smo_bowser_wedding_outfit': 'Bowser',
      'smb30': 'Mario 30th Anniversary',
      'smb30_mario_classic_color': 'Mario (couleurs classiques)',
      'smb30_mario_modern_color': 'Mario (couleurs modernes)',
      'zld': 'The Legend of Zelda',
      'zld_wolf_link': 'Link Loup',
      'zld_link_archer': 'Link (archer)',
      'zld_link_rider': 'Link (à cheval)',
      'zld_guardian': 'Guardien',
      'zld_zelda': 'Zelda',
      'zld_bokoblin': 'Bokoblin',
      'zld_revali': 'Revali',
      'zld_mipha': 'Mipha',
      'zld_daruk': 'Daruk',
      'zld_urbosa': 'Urbosa',
      'zld_link_ocarina_of_time': 'Link (Ocarina of Time)',
      'zld_link_the_legend_of_zelda': 'Link (The Legend of Zelda)',
      'zld_toon_link_the_wind_waker': 'Link cartoon (The Wind Waker)',
      'zld_zelda_the_wind_waker': 'Zelda (The Wind Waker)',
      'zld_link_majora_s_mask': 'Link (Majora\'s Mask)',
      'zld_link_twilight_princess': 'Link (Twilight Princess)',
      'zld_link_skyward_sword': 'Link (Skyward Sword)',
      'spl': 'Splatoon',
      'spl_inkling_girl_1': 'Fille Inkling',
      'spl_inkling_boy_1': 'Garçon Inkling',
      'spl_inkling_squid_1': 'Calamar Inkling',
      'spl_callie': 'Callie',
      'spl_marie': 'Marie',
      'spl_inkling_girl_2': 'Fille Inkling',
      'spl_inkling_boy_2': 'Garçon Inkling',
      'spl_inkling_squid_2': 'Calamar Inkling',
      'spl_inkling_girl_3': 'Fille Inkling',
      'spl_inkling_boy_3': 'Garçon Inkling',
      'spl_inkling_squid_3': 'Calamar Inkling',
      'spl_pearl': 'Pearl',
      'spl_marina': 'Marina',
      'spl_octoling_girl': 'Fille Octoling',
      'spl_octoling_boy': 'Garçon Octoling',
      'spl_octoling_octopus': 'Calamar Octoling',
      'ac': 'Animal Crossing',
      'ac_isabelle_winter_outfit': 'Marie (tenue d\'été) ',
      'ac_tom_nook': 'Tom Nook',
      'ac_kk': 'Kéké',
      'ac_mabel': 'Layette',
      'ac_digby': 'Max',
      'ac_lottie': 'Lou',
      'ac_cyrus': 'Serge',
      'ac_reese': 'Risette',
      'ac_blathers': 'Thibou',
      'ac_celeste': 'Céleste',
      'ac_resetti': 'Resetti',
      'ac_kicks': 'Blaise',
      'ac_timmy_tommy': 'Méli et Mélo',
      'ac_kapp_n': 'Amiral',
      'ac_rover': 'Charly',
      'ac_isabelle_summer_outfit': 'Marie',
      'yww': 'Yoshi\'s Woolly World',
      'yww_green_yarn_yoshi': 'Yoshi de laine vert',
      'yww_pink_yarn_yoshi': 'Yoshi de laine rose',
      'yww_light_blue_yarn_yoshi': 'Yoshi de laine bleu ciel',
      'yww_mega_yarn_yoshi': 'Méga Yoshi de laine',
      'yww_poochy': 'Poochy',
      'krb': 'Kirby',
      'krb_kirby': 'Kirby',
      'krb_meta_knight': 'Meta Knight',
      'krb_king_dedede': 'Roi DaDiDou',
      'krb_waddle_dee': 'Waddle Dee',
      'fe': 'Fire Emblem',
      'fe_alm': 'Alm',
      'fe_celica': 'Celica',
      'fe_chrom': 'Chrom',
      'fe_tiki': 'Tiki',
      'mtr': 'Metroid',
      'mtr_samus_aran': 'Samus',
      'mtr_metroid': 'Metroid',
      'sk': 'Shovel Knight',
      'sk_shovel_knight': 'Shovel Knight',
      'cr': 'Chibi_Robo',
      'cr_chibi_robo': 'Chibi_Robo',
      'bb': 'Box Boy!',
      'bb_qbby': 'Qbby',
      'pkm': 'Pikmin',
      'pkm_pikmin': 'Pikmin',
      'dpk': 'Detective Pikachu',
      'dpk_detective_pikachu': 'Détective Pikachu',
      'dks': 'Dark Souls',
      'dks_solaire_of_astora': 'Solaire d\'Astora',
      'mgmce': 'Mega Man Collector\'s Edition',
      'mgmce_megaman_gold': 'Mega Man (édition or)'
    };
  }

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  GeneratedLocalizationsDelegate();

  final Map<Locale, I18n> _locales = <Locale, I18n>{
    const Locale('en', 'US'): _I18nEnUS(),
    const Locale('fr', 'FR'): _I18nFrFR(),
  };

  List<Locale> get supportedLocales {
    return _locales.keys.toList();
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    final String lang = locale != null ? locale.toString() : '';
    final String languageCode = locale != null ? locale.languageCode : '';

    for (Locale l in supportedLocales) {
      if (lang == l.toString() || languageCode == l.languageCode) {
        return SynchronousFuture<WidgetsLocalizations>(_locales[l]);
      }
    }

    return SynchronousFuture<WidgetsLocalizations>(_I18nEnUS());
  }

  @override
  bool isSupported(Locale locale) {
    for (int i = 0; i < supportedLocales.length && locale != null; i++) {
      final Locale l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}
