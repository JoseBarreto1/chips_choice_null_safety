import 'package:flutter/material.dart';
import 'model/choice_item.dart';
import 'model/choice_style.dart';

/// Default choice item widget
class C2Chip<T> extends StatelessWidget {
  /// choice item data
  final C2Choice<T> data;

  /// unselected choice style
  final C2ChoiceStyle style;

  /// selected choice style
  final C2ChoiceStyle activeStyle;

  /// label widget
  final Widget? label;

  /// avatar widget
  final Widget? avatar;

  /// default constructor
  C2Chip({
    Key? key,
    required this.data,
    required this.style,
    required this.activeStyle,
    this.label,
    this.avatar,
  }) : super(key: key);

  /// get shape border
  static OutlinedBorder getShapeBorder({
    required Color color,
    double? width,
    BorderRadiusGeometry? radius,
    BorderStyle? style,
  }) {
    final BorderSide side = BorderSide(
        color: color, width: width ?? 1.0, style: style ?? BorderStyle.solid);
    return radius == null
        ? StadiumBorder(side: side)
        : RoundedRectangleBorder(
            borderRadius: radius,
            side: side,
          );
  }

  /// get shape border
  static OutlinedBorder getAvatarShapeBorder({
    required Color color,
    double? width,
    BorderRadiusGeometry? radius,
    BorderStyle? style,
  }) {
    final BorderSide side = BorderSide(
        color: color, width: width ?? 1.0, style: style ?? BorderStyle.solid);
    return radius == null
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(
            borderRadius: radius,
            side: side,
          );
  }

  /// default border opacity
  static final double defaultBorderOpacity = .2;

  @override
  Widget build(BuildContext context) {
    final C2ChoiceStyle effectiveStyle = data.selected ? activeStyle : style;

    final bool isDark = effectiveStyle.brightness == Brightness.dark;

    final Color backgroundColor = isDark
        ? Colors.black
        : (effectiveStyle.backgroundColor ?? Colors.grey.shade100);

    final Color borderColor =
        isDark ? Colors.black : (effectiveStyle.borderColor ?? Colors.white);

    final Color? textColor = isDark ? Colors.white : effectiveStyle.color;

    final Color? checkmarkColor = isDark ? textColor : activeStyle.color;

    return Padding(
      padding: effectiveStyle.margin != null
          ? effectiveStyle.margin!
          : EdgeInsets.symmetric(vertical: 4),
      child: RawChip(
        padding: effectiveStyle.padding,
        label: label ?? Text(data.label),
        labelStyle:
            TextStyle(color: textColor).merge(effectiveStyle.labelStyle),
        labelPadding: effectiveStyle.labelPadding,
        avatar: avatar,
        avatarBorder: effectiveStyle.avatarBorderShape ??
            getAvatarShapeBorder(
              color: borderColor,
              radius: effectiveStyle.borderRadius,
            ),
        tooltip: data.tooltip,
        shape: effectiveStyle.borderShape ??
            getShapeBorder(
              color: borderColor,
              radius: effectiveStyle.borderRadius,
            ),
        clipBehavior: effectiveStyle.clipBehavior ?? Clip.none,
        elevation: effectiveStyle.elevation ?? 0,
        pressElevation: effectiveStyle.pressElevation ?? 0,
        shadowColor: style.color,
        selectedShadowColor: activeStyle.color,
        backgroundColor: backgroundColor,
        selectedColor: backgroundColor,
        checkmarkColor: checkmarkColor,
        showCheckmark: effectiveStyle.showCheckmark,
        materialTapTargetSize: effectiveStyle.materialTapTargetSize,
        disabledColor:
            effectiveStyle.disabledColor ?? Colors.blueGrey.withOpacity(.1),
        isEnabled: data.disabled != true,
        selected: data.selected,
        onSelected: (_selected) =>
            data.select != null ? data.select!(_selected) : null,
      ),
    );
  }
}
