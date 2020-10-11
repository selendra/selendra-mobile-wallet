/* This file hold app configurations. */
class AppConfig { 

  /* Background Color */ 
  static const String darkBlue50 = "#344051", bgdColor = "#090D28"; // App Theme using darkBlue75

  /* ------------------- Logo -----------------  */

  // Welcome Screen, Login Screen, Sign Up Screen
  static String logoName = "assets/sld_logo.svg";

  // Dashbaord Menu
  static String logoAppBar = "assets/images/zeetomic-logo-header.png";

  // Bottom App Bar 
  static String logoBottomAppBar = "assets/images/sld_qr.png";

  // QR Embedded
  static String logoQrEmbedded = "assets/sld_stroke.png";

  // Portfolio
  static String logoPortfolio = 'assets/images/sld_logo.png';
  
  // Transaction History
  static String logoTrxHistory = 'assets/images/sld_logo.png';

  /* Splash Screen */
  static String splashLogo = "assets/images/zeetomic-logo-header.png";
  
  /* Transaction Acivtiy */
  static String logoTrxActivity = 'assets/images/sld_logo.png';

  /* Zeetomic api user data*/
  // Main Net API
  static final url = "https://testnet-api.selendra.com/pub/v1";

  // sld_market net API 
  // https://sld_marketnet-api.selendra.com/pub/v1
}