import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class Constants {
  //Radius
  static double radius = 50;

  //Action Colors
  static Color colourActionPrimary = HexColor.fromHex("#39a0bf");
  static Color colourActionSecondary = HexColor.fromHex("#262e41");

  //Action Status Colors
  static Color colourActionStatusHoverPrimary = HexColor.fromHex("#98d1e2");
  static Color colourActionStatusHoverSecondary = HexColor.fromHex("#e1e3e7");
  static Color colourActionStatusPressedPrimary = HexColor.fromHex("#2c809a");
  static Color colourActionStatusPressedSecondary = HexColor.fromHex("#8f94a2");
  static Color colourActionStatusDisable = HexColor.fromHex("#e1e3e7");

  //Background Colors
  static Color colourBackgroundDark = HexColor.fromHex("#262e41");
  static Color colourBackgroundNeutral = HexColor.fromHex("#f6f7fa");
  static Color colourBackgroundColor = HexColor.fromHex("#dff3f6");
  static Color colourBackgroundOncolor = HexColor.fromHex("#ffffff");
  static Color colourBackgroundOverlay = HexColor.fromHex("#262e41");

  //Border Colors
  static Color colourBorderDefault = HexColor.fromHex("#ee7326");
  static Color colourBorderColor1 = HexColor.fromHex("#262e41");
  static Color colourBorderColor2 = HexColor.fromHex("#39a0bf");
  static Color colourBorderDisable = HexColor.fromHex("#aaaeb9");

  //Neutral Colors
  static Color globalColorNeutral100 = HexColor.fromHex("#1f2637");
  static Color globalColorNeutral90 = HexColor.fromHex("#262e41");
  static Color globalColorNeutral80 = HexColor.fromHex("#40475a");
  static Color globalColorNeutral70 = HexColor.fromHex("#5a6172");
  static Color globalColorNeutral60 = HexColor.fromHex("#747b8a");
  static Color globalColorNeutral50 = HexColor.fromHex("#8f94a2");
  static Color globalColorNeutral40 = HexColor.fromHex("#aaaeb9");
  static Color globalColorNeutral30 = HexColor.fromHex("#c5c8d0");
  static Color globalColorNeutral20 = HexColor.fromHex("#e1e3e7");
  static Color globalColorNeutral10 = HexColor.fromHex("#f6f7fa");
  static Color globalColorNeutral0 = HexColor.fromHex("#ffffff");

  //Primary Colors
  static Color globaColorPrimary90 = HexColor.fromHex("#010202");
  static Color globaColorPrimary80 = HexColor.fromHex("#133f4c");
  static Color globaColorPrimary70 = HexColor.fromHex("#1f6074");
  static Color globaColorPrimary60 = HexColor.fromHex("#2c809a");
  static Color globaColorPrimary50 = HexColor.fromHex("#39a0bf");
  static Color globaColorPrimary40 = HexColor.fromHex("#68b9d1");
  static Color globaColorPrimary30 = HexColor.fromHex("#98d1e2");
  static Color globaColorPrimary20 = HexColor.fromHex("#dff3f6");
  static Color globaColorPrimary10 = HexColor.fromHex("#f4f9fb");

  //Secondary Colors
  static Color globaColorSecondary90 = HexColor.fromHex("#fbde82");
  static Color globaColorSecondary70 = HexColor.fromHex("#fce6a1");
  static Color globaColorSecondary50 = HexColor.fromHex("#f8eecc");
  static Color globaColorSecondary30 = HexColor.fromHex("#fef9e7");
  static Color globaColorSecondary10 = HexColor.fromHex("#fffdf7");

  //Semantics Colors
  //Red
  static Color globalColorSemanticsRed80 = HexColor.fromHex("#79130c");
  static Color globalColorSemanticsRed50 = HexColor.fromHex("#b33129");
  static Color globalColorSemanticsRed30 = HexColor.fromHex("#fff1f0");
  //Yellow
  static Color globalColorSemanticsYellow80 = HexColor.fromHex("#7c5212");
  static Color globalColorSemanticsYellow50 = HexColor.fromHex("#dd9221");
  static Color globalColorSemanticsYellow30 = HexColor.fromHex("#fff8ed");
  //Green
  static Color globalColorSemanticsGreen80 = HexColor.fromHex("#38482e");
  static Color globalColorSemanticsGreen50 = HexColor.fromHex("#92d161");
  static Color globalColorSemanticsGreen30 = HexColor.fromHex("#f1fbf7");
  //Blue
  static Color globalColorSemanticsBlue80 = HexColor.fromHex("#122255");
  static Color globalColorSemanticsBlue50 = HexColor.fromHex("#4f73f4");
  static Color globalColorSemanticsBlue30 = HexColor.fromHex("#eff2ff");

  //Terciary Colors
  static Color globalColorTerciary90 = HexColor.fromHex("#153536");
  static Color globalColorTerciary80 = HexColor.fromHex("#265b5d");
  static Color globalColorTerciary70 = HexColor.fromHex("#388183");
  static Color globalColorTerciary60 = HexColor.fromHex("#4aa7a9");
  static Color globalColorTerciary50 = HexColor.fromHex("#5dcbce");
  static Color globalColorTerciary40 = HexColor.fromHex("#81d9dc");
  static Color globalColorTerciary30 = HexColor.fromHex("#a7e7e8");
  static Color globalColorTerciary20 = HexColor.fromHex("#cef2f3");
  static Color globalColorTerciary10 = HexColor.fromHex("#f4fcfc");

  //Icon Colors
  static Color colourIconDefault = HexColor.fromHex("#153536");
  static Color colourIconColor = HexColor.fromHex("#39a0bf");
  static Color colourIconOncolor = HexColor.fromHex("#ffffff");
  static Color colourIconDisable = HexColor.fromHex("#aaaeb9");

  //Semantic Colors
  //Danger
  static Color colourSemanticDanger1 = HexColor.fromHex("#b33129");
  static Color colourSemanticDanger2 = HexColor.fromHex("#fff1f0");
  //Warning
  static Color colourSemanticWarning1 = HexColor.fromHex("#ffdb59");
  static Color colourSemanticWarning2 = HexColor.fromHex("#fff8ed");
  //Succesful
  static Color colourSemanticSuccesful1 = HexColor.fromHex("#05a169");
  static Color colourSemanticSuccesful2 = HexColor.fromHex("#f1fbf7");
  //Info
  static Color colourSemanticInfo1 = HexColor.fromHex("#4f73f4");
  static Color colourSemanticInfo2 = HexColor.fromHex("#eff2ff");

  //Text
  static Color colourTextDefault = HexColor.fromHex("#262e41");
  static Color colourTextSecondary = HexColor.fromHex("#747b8a");
  static Color colourTextColor = HexColor.fromHex("#39a0bf");
  static Color colourTextOncolor = HexColor.fromHex("#ffffff");
  static Color colourTextDisable = HexColor.fromHex("#aaaeb9");

  //Icon Size
  static double globalIconSizeL = 32;
  static double globalIconSizeM = 24;
  static double globalIconSizeS = 16;

  //Radius
  static double globalRadiusSizeFull = 120;
  static double globalRadiusSizeM = 16;
  static double globalRadiusSizeS = 8;
  static double globalRadiusSizeXS = 4;

  //Spacing
  static double globalSpacingSize30 = 120;
  static double globalSpacingSize20 = 80;
  static double globalSpacingSize18 = 72;
  static double globalSpacingSize16 = 64;
  static double globalSpacingSize14 = 56;
  static double globalSpacingSize12 = 48;
  static double globalSpacingSize10 = 40;
  static double globalSpacingSize9 = 36;
  static double globalSpacingSize8 = 32;
  static double globalSpacingSize7 = 28;
  static double globalSpacingSize6 = 24;
  static double globalSpacingSize5 = 20;
  static double globalSpacingSize4 = 16;
  static double globalSpacingSize3 = 12;
  static double globalSpacingSize2 = 8;
  static double globalSpacingSize1 = 4;
  static double globalSpacingSize0 = 0;

  //Spacing Medidas Absolutas
  static double globalSpacingSizeXXL = 48;
  static double globalSpacingSizeXL = 32;
  static double globalSpacingSizeL = 24;
  static double globalSpacingSizeM = 16;
  static double globalSpacingSizeS = 12;
  static double globalSpacingSizeXS = 8;
  static double globalSpacingSizeXXS = 4;

  //Font Size
  static double globalTypographyFontSize700 = 64;
  static double globalTypographyFontSize600 = 44;
  static double globalTypographyFontSize500 = 36;
  static double globalTypographyFontSize400 = 32;
  static double globalTypographyFontSize300 = 24;
  static double globalTypographyFontSize200 = 20;
  static double globalTypographyFontSize150 = 18;
  static double globalTypographyFontSize100 = 16;
  static double globalTypographyFontSize75 = 14;
  static double globalTypographyFontSize50 = 12;
  static double globalTypographyFontSize25 = 10;

  //Font Weight
  static FontWeight globalTypographyFontWeight700 = FontWeight.w700;
  static FontWeight globalTypographyFontWeight600 = FontWeight.w600;
  static FontWeight globalTypographyFontWeight500 = FontWeight.w500;
  static FontWeight globalTypographyFontWeight400 = FontWeight.w400;
  static FontWeight globalTypographyFontWeight300 = FontWeight.w300;

  //Font Style
  static FontStyle globalTypographyFontStyleStandard = FontStyle.normal;
  static TextDecoration globalTypographyFontStyleUnderline =
      TextDecoration.underline;

  //Letter Spacing
  static double globalTypographyFontSpacingS = 0;

  //Line Height
  static double globalTypographyLineHeight700 = 64;
  static double globalTypographyLineHeight600 = 44;
  static double globalTypographyLineHeight500 = 36;
  static double globalTypographyLineHeight400 = 32;
  static double globalTypographyLineHeight300 = 24;
  static double globalTypographyLineHeight200 = 20;
  static double globalTypographyLineHeight100 = 16;

  //Bold Style
  static TextStyle typographyBoldL = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize100,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight600,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBoldM = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize75,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight600,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBoldS = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize50,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight600,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBlackBoldL = TextStyle(
    fontFamily: 'Inter',
    color: globalColorNeutral100,
    fontSize: globalTypographyFontSize100,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight600,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBlackBoldM = TextStyle(
    fontFamily: 'Inter',
    color: globalColorNeutral100,
    fontSize: globalTypographyFontSize75,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight600,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBlackBoldS = TextStyle(
    fontFamily: 'Inter',
    color: globalColorNeutral100,
    fontSize: globalTypographyFontSize50,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight600,
    fontStyle: globalTypographyFontStyleStandard,
  );

  //Body Style
  static TextStyle typographyBodyL = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize100,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBodyM = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize75,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBodyS = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize50,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBlackBodyL = TextStyle(
    fontFamily: 'Inter',
    color: globalColorNeutral100,
    fontSize: globalTypographyFontSize100,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBlackBodyM = TextStyle(
    fontFamily: 'Inter',
    color: globalColorNeutral100,
    fontSize: globalTypographyFontSize75,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyBlackBodyS = TextStyle(
    fontFamily: 'Inter',
    color: globalColorNeutral100,
    fontSize: globalTypographyFontSize50,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    fontStyle: globalTypographyFontStyleStandard,
  );

  //Link Style
  static TextStyle typographyLinkL = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize100,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    decoration: globalTypographyFontStyleUnderline,
  );
  
  static TextStyle typographyLinkM = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize75,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    decoration: globalTypographyFontStyleUnderline,
  );

  static TextStyle typographyLinkS = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize50,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    decoration: globalTypographyFontStyleUnderline,
  ); 

  //Button Style
  static TextStyle typographyButtonM = TextStyle(
    fontFamily: 'Inter',
    color: colourTextDefault,
    fontSize: globalTypographyFontSize100,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight500,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyButtonMSecondary = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize100,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight500,
    fontStyle: globalTypographyFontStyleStandard,
  );

  //Heading Style
  static TextStyle typographyHeadingL = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize400,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight600,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyHeadingM = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize300,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight600,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle typographyHeadingS = TextStyle(
    fontFamily: 'Inter',
    color: colourTextColor,
    fontSize: globalTypographyFontSize150,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight500,
    fontStyle: globalTypographyFontStyleStandard,
  );

  //Label Style
  static TextStyle labelDefaultState = TextStyle(
    fontFamily: 'Inter',
    color: globalColorNeutral70,
    fontSize: globalTypographyFontSize100,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    fontStyle: globalTypographyFontStyleStandard,
  );

  static TextStyle labelErrorState = TextStyle(
    fontFamily: 'Inter',
    color: colourSemanticDanger1,
    fontSize: globalTypographyFontSize50,
    letterSpacing: globalTypographyFontSpacingS,
    fontWeight: globalTypographyFontWeight400,
    fontStyle: globalTypographyFontStyleStandard,
  );
}
