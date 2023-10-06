import 'dart:typed_data';
import 'package:blue_real_estate/helpers/converters/image_source_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/constants.dart';
import '../helpers/HelperGrialIconsLine.dart';
import '../helpers/fonts/text_style_theme.dart';
import 'package:hexcolor/hexcolor.dart';

class ListViewSepListTile extends StatelessWidget {
  final List<ListViewSepListTileItem> listItems;
  final Function? onTap;
  final bool? isWidthHeight;
  final bool? isScrollable;
  const ListViewSepListTile(this.listItems,
      {Key? key, this.onTap, this.isWidthHeight, this.isScrollable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: ListView.separated(
      key: key,
      shrinkWrap: true,
      physics: isScrollable != true
          ? (const ClampingScrollPhysics())
          : const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Widget? trailing;
        switch (listItems[index].trail.runtimeType) {
          case IconData:
            trailing = Icon(listItems[index].trail);
            break;
          case String:
            trailing = listItems[index].iconType != "icon"
                ? trailing = Text(listItems[index].trail)
                : Text(listItems[index].trail,
                    style: TextStyle(
                        fontSize: FontSizeTheme().headline5,
                        fontFamily: Constants.fontGrialFill,
                        color: listItems[index].trailColor));
            break;
        }
        Widget? leading;
        switch (listItems[index].icon.runtimeType) {
          case IconData:
            leading = Container(
                width: 28.0,
                height: 28.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(RadiusConstants.small)),
                    border: Border.all(
                        color: ColorConstants.primaryColor, width: 1)),
                child: Icon(listItems[index].icon!,
                    color: ColorConstants.primaryColor));
            break;

          case String:
            leading = listItems[index].iconType == "profile"
                ? Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: listItems[index].icon != ""
                            ? DecorationImage(
                                fit: BoxFit.fill,
                                image: MemoryImage(
                                  ImageSourceConverter.converter(
                                      listItems[index].icon!)!,
                                ),
                              )
                            : null),
                    child: listItems[index].icon == ""
                        ? SvgPicture.asset(
                            PhotoConstants.defaultProfile,
                            fit: BoxFit.contain,
                            width: double.infinity,
                          )
                        : null)
                : Container(
                    width: 28.0,
                    height: 28.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: listItems[index].color != "" &&
                              Constants.isValidHexaCode(listItems[index].color!)
                          ? HexColor(listItems[index].color.toString())
                          : ColorConstants.primaryColor,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(RadiusConstants.small)),
                      // border: Border.all(
                      //     color: listItems[index].color != "" &&
                      //             Constants.isValidHexaCode(listItems[index].color!)
                      //         ? HexColor(listItems[index].color.toString())
                      //         : ColorConstants.primaryColor,
                      //     width: 1)
                    ),
                    child: listItems[index].iconType != ""
                        ? listItems[index].iconType != "image"
                            ? Text(
                                HelperGrialIconsLine.isExistIcon(
                                        listItems[index].icon)
                                    ? HelperGrialIconsLine.getIconData(
                                        listItems[index].icon)
                                    : "",
                                style: TextStyleTheme().headline5(
                                  textColor: ColorConstants.secondaryColor,
                                  fontFamily: Constants.fontGrialFill,
                                ),
                              )
                            : listItems[index].icon != ""
                                ? Container(
                                    margin: const EdgeInsets.all(
                                        PaddingConstants.small - 1),
                                    decoration: BoxDecoration(
                                      color: listItems[index].color != "" &&
                                              Constants.isValidHexaCode(
                                                  listItems[index].color!)
                                          ? HexColor(
                                              listItems[index].color.toString())
                                          : ColorConstants.primaryColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              RadiusConstants.small)),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: MemoryImage(
                                          ImageSourceConverter.converter(
                                              listItems[index].icon!)!,
                                        ),
                                      ),
                                    ),
                                  )
                                : null
                        : null,
                  );
            break;
        }
        ListTile listTile = ListTile(
          key: Key(index.toString()),
          dense: true,
          visualDensity: listItems[index].iconType == "profile"
              ? null
              : const VisualDensity(vertical: -2),
          contentPadding: const EdgeInsets.symmetric(
            vertical: PaddingConstants.none,
            horizontal: PaddingConstants.large,
          ),
          leading: leading,
          title: Text(
            listItems[index].title.toString(),
            style: TextStyleTheme().headline6(
                fontWeight: FontWeight.bold,
                textColor: listItems[index].titleColor),
          ),
          subtitle: listItems[index].subTitle != null
              ? Text(
                  listItems[index].subTitle.toString(),
                  style: TextStyleTheme().headline7(),
                )
              : null,
          trailing: trailing,
          onTap: onTap != null ? () => onTap!(index, listItems[index]) : null,
        );
        if (listItems.length == 1) {
          return Column(
            children: [
              const Divider(height: 1),
              listTile,
              const Divider(height: 1),
            ],
          );
        }
        if (index == 0) {
          return Column(
            children: [
              const Divider(height: 1),
              listTile,
            ],
          );
        } else if (index == listItems.length - 1) {
          return Column(
            children: [
              listTile,
              const Divider(height: 1),
            ],
          );
        }
        return listTile;
      },
      itemCount: listItems.length,
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: PaddingConstants.large),
        child: Divider(height: 1),
      ),
    ));
  }
}

class ListViewSepListTileItem {
  final String title;
  final dynamic trail;
  final Object? obj;
  final dynamic icon;
  final String? iconType;
  final String? color;
  final String? subTitle;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? trailColor;
  final String? objectType;
  final String? searchPageType;
  final bool? isAllowCreate;
  ListViewSepListTileItem(this.title, this.trail,
      {this.obj,
      this.icon,
      this.iconType,
      this.color,
      this.subTitle,
      this.titleColor,
      this.subTitleColor,
      this.trailColor,
      this.objectType,
      this.searchPageType,
      this.isAllowCreate});
}
