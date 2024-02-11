import 'dart:ui';

class AppColors {
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color backgroundGrey = Color(0xFFF2F2F2);
  static const Color brandColor = Color(0xFF2196F3);

  static const Color normalColor = Color(0xFFC5BFAF);
  static const Color fightingColor = Color(0xFFE74C3C);
  static const Color flyingColor = Color(0xFFAED6F1);
  static const Color poisonColor = Color(0xFF9B59B6);
  static const Color groundColor = Color(0xFFD4AC0D);
  static const Color rockColor = Color(0xFFB7950B);
  static const Color bugColor = Color(0xFF82AE46);
  static const Color ghostColor = Color(0xFF6C648B);
  static const Color steelColor = Color(0xFF95A5A6);
  static const Color fireColor = Color(0xFFF39C12);
  static const Color waterColor = Color(0xFF3498DB);
  static const Color grassColor = Color(0xFF2ECC71);
  static const Color electricColor = Color(0xFFF4D03F);
  static const Color psychicColor = Color(0xFFE08283);
  static const Color iceColor = Color(0xFFA2D9CE);
  static const Color dragonColor = Color(0xFF8E44AD);
  static const Color darkColor = Color(0xFF34495E);
  static const Color fairyColor = Color(0xFFFAD02E);
  static const Color unknownColor = Color(0xFFD2B4DE);
  static const Color shadowColor = Color(0xFF5D6D7E);

  static Color getColorType(String type) {
    switch (type) {
      case "normal":
        return AppColors.normalColor.withOpacity(0.3);
      case "fighting":
        return AppColors.fightingColor.withOpacity(0.3);
      case "flying":
        return AppColors.flyingColor.withOpacity(0.3);
      case "poison":
        return AppColors.poisonColor.withOpacity(0.3);
      case "ground":
        return AppColors.groundColor.withOpacity(0.3);
      case "rock":
        return AppColors.rockColor.withOpacity(0.3);
      case "bug":
        return AppColors.bugColor.withOpacity(0.3);
      case "ghost":
        return AppColors.ghostColor.withOpacity(0.3);
      case "steel":
        return AppColors.steelColor.withOpacity(0.3);
      case "fire":
        return AppColors.fireColor.withOpacity(0.3);
      case "water":
        return AppColors.waterColor.withOpacity(0.3);
      case "grass":
        return AppColors.grassColor.withOpacity(0.3);
      case "electric":
        return AppColors.electricColor.withOpacity(0.3);
      case "psychic":
        return AppColors.psychicColor.withOpacity(0.3);
      case "ice":
        return AppColors.iceColor.withOpacity(0.3);
      case "dragon":
        return AppColors.dragonColor.withOpacity(0.3);
      case "dark":
        return AppColors.darkColor.withOpacity(0.3);
      case "fairy":
        return AppColors.fairyColor.withOpacity(0.3);
      case "unknown":
        return AppColors.unknownColor.withOpacity(0.3);
      case "shadow":
        return AppColors.shadowColor.withOpacity(0.3);
    }
    return AppColors.unknownColor.withOpacity(0.3);
  }
}
