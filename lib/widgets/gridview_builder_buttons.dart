import 'package:blue_real_estate/helpers/converters/image_source_converter.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../helpers/HelperGrialIconsLine.dart';
import '../helpers/fonts/text_style_theme.dart';
import 'package:hexcolor/hexcolor.dart';

class GridViewBuilderButtons extends StatelessWidget {
  final List<GridViewBuilderButtonsItem> listItems;
  final Function? onTap;
  const GridViewBuilderButtons(this.listItems, {Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 62.0,
        child: ListView.builder(
          key: key,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Container container = Container();
            switch (listItems[index].icon.runtimeType) {
              case IconData:
                container = Container(
                    width: 38.0,
                    height: 38.0,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(RadiusConstants.medium)),
                        border: Border.all(
                            color: ColorConstants.primaryColor, width: 1)),
                    child: Icon(listItems[index].icon!,
                        color: ColorConstants.primaryColor));
                break;

              case String:
                container = Container(
                  width: 38.0,
                  height: 38.0,
                  padding: const EdgeInsets.all(PaddingConstants.small),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(RadiusConstants.medium)),
                      border: Border.all(
                          color: listItems[index].color != "" &&
                                  Constants.isValidHexaCode(
                                      listItems[index].color!)
                              ? HexColor(listItems[index].color.toString())
                              : ColorConstants.primaryColor,
                          width: 1)),
                  child: listItems[index].iconType != ""
                      ? listItems[index].iconType != "image"
                          ? Text(
                              HelperGrialIconsLine.isExistIcon(
                                      listItems[index].icon)
                                  ? HelperGrialIconsLine.getIconData(
                                      listItems[index].icon)
                                  : "",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: Constants.fontGrialLine,
                                  color: listItems[index].color != "" &&
                                          Constants.isValidHexaCode(
                                              listItems[index].color!)
                                      ? HexColor(
                                          listItems[index].color.toString())
                                      : ColorConstants.primaryColor),
                              textAlign: TextAlign.center,
                            )
                          : listItems[index].icon != ""
                              ? Container(
                                  width: 38.81,
                                  height: 38.81,
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
            SizedBox content = SizedBox(
                width: (MediaQuery.of(context).size.width / listItems.length) -
                    PaddingConstants.medium,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      container,
                      Text(
                        listItems[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyleTheme().headline6(
                          textColor: ColorConstants.primaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      )
                    ]));

            return GestureDetector(
                onTap: onTap != null
                    ? () => onTap!(index, listItems[index])
                    : null,
                child: content);
          },
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: listItems.length,
        ));
  }
}

class GridViewBuilderButtonsItem {
  final String title;
  final dynamic icon;
  final String? iconType;
  final String? color;
  final Object? obj;
  GridViewBuilderButtonsItem(this.title,
      {this.icon, this.iconType, this.color, this.obj});
}
