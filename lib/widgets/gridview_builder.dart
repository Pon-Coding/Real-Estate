import 'dart:typed_data';
import 'package:blue_real_estate/helpers/converters/image_source_converter.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../helpers/HelperGrialIconsLine.dart';
import '../helpers/fonts/text_style_theme.dart';
import 'package:hexcolor/hexcolor.dart';

class GridViewBuilder extends StatelessWidget {
  final List<GridViewBuilderItem> listItems;
  final Function? onTap;
  const GridViewBuilder(this.listItems, {Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: key,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Container container = new Container();
        switch (listItems[index].icon.runtimeType) {
          case IconData:
            container = Container(
                width: 38.0,
                height: 38.0,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(RadiusConstants.small)),
                    border: Border.all(
                        color: ColorConstants.primaryColor, width: 1)),
                child: Icon(listItems[index].icon!,
                    color: ColorConstants.primaryColor));
            break;

          case String:
            container = Container(
              width: 38.0,
              height: 38.0,
              // padding: const EdgeInsets.all(PaddingConstants.small),
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
                          // style: TextStyle(
                          //     fontSize: 28,
                          //     fontFamily: Constants.fontGrialFill,
                          //     color:  ColorConstants.secondaryColor),
                          style: TextStyleTheme().headline3(
                            textColor: ColorConstants.secondaryColor,
                            fontFamily: Constants.fontGrialFill,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : listItems[index].icon != ""
                          ? Container(
                              margin:
                                  const EdgeInsets.all(PaddingConstants.small),
                              decoration: BoxDecoration(
                                color: listItems[index].color != "" &&
                                        Constants.isValidHexaCode(
                                            listItems[index].color!)
                                    ? HexColor(
                                        listItems[index].color.toString())
                                    : ColorConstants.primaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(RadiusConstants.small)),
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

        // Row content = Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       container,
        //       //  _buildTitlebreakWord(listItems[index].title),
        //       Text(
        //         listItems[index].title,
        //         textAlign: TextAlign.center,
        //         style: TextStyleTheme().headline6(
        //           textColor: ColorConstants.primaryColor,
        //         ),
        //         softWrap: true,
        //         overflow: TextOverflow.ellipsis,
        //         maxLines: 2,
        //       )
        //     ]);
        Container content = Container(
            margin: const EdgeInsets.symmetric(
                horizontal: PaddingConstants.small,
                vertical: PaddingConstants.small),
            // margin: const EdgeInsets.only(
            //     left: PaddingConstants.small,
            //     top: PaddingConstants.small,
            //     right: PaddingConstants.small,
            //     bottom: PaddingConstants.small),
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingConstants.medium,
                vertical: PaddingConstants.small),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: HexColor("ECECEC"),
                borderRadius: BorderRadius.circular(RadiusConstants.small)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    //width: MediaQuery.of(context).size.width / 3,
                    child: container,
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(
                      left: PaddingConstants.small,
                    ),
                    child: Text(
                      listItems[index].title,
                      textAlign: TextAlign.start,
                      style: TextStyleTheme().headline6(
                        textColor: ColorConstants.onSecondaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ))
                ]));

        return GestureDetector(
            onTap: onTap != null ? () => onTap!(index, listItems[index]) : null,
            child: content);
      },
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 6),
      ),
      itemCount: listItems.length,
    );
  }

  _buildTitlebreakWord(String title) {
    var titleSplit = title.split(' ').map((i) {
      if (i == " ") {
        return const Divider();
      } else {
        return Text(
          i,
          textAlign: TextAlign.center,
          style: TextStyleTheme().headline6(
            textColor: ColorConstants.primaryColor,
          ),

          overflow: TextOverflow.ellipsis,
          // maxLines: 1,
          softWrap: true,
        );
      }
    }).toList();
    var displayElement = Column(children: titleSplit);

    return displayElement;
  }

  // bool isValidHexaCode(String str) {
  //   RegExp hexColor = RegExp(r'^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
  //   if (str.isNotEmpty) {
  //     return false;
  //   }

  //   if (hexColor.hasMatch(str)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}

class GridViewBuilderItem {
  final String title;
  final dynamic icon;
  final String? iconType;
  final String? color;
  final Object? obj;
  GridViewBuilderItem(this.title,
      {this.icon, this.iconType, this.color, this.obj});
}
