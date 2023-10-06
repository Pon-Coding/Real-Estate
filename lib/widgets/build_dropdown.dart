import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BuildDropdown<T> extends StatefulWidget {
  final Widget child;

  final void Function(T, int) onChange;

  final List<DropdownItem<T>> items;
  final DropdownStyle dropdownStyle;

  final DropdownButtonStyle dropdownButtonStyle;

  final Icon? icon;
  final bool hideIcon;
  ScrollController? scrollController;

  final bool leadingIcon;
  BuildDropdown(
    this.child,
    this.items,
    this.onChange, {
    Key? key,
    this.hideIcon = false,
    this.dropdownStyle = const DropdownStyle(),
    this.dropdownButtonStyle = const DropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<BuildDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.25).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    // link the overlay to the button
    final Widget innerItemsWidget;

    if (widget.items.isEmpty) {
      innerItemsWidget = Container();
    } else {
      innerItemsWidget = SizedBox(height: style.height);
    }
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        width: style.width,
        height: style.height,
        color: ColorConstants.secondaryColor,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: style.padding,
            backgroundColor: style.backgroundColor,
            elevation: style.elevation,
            primary: style.primaryColor,
            shape: style.shape,
            side: const BorderSide(color: ColorConstants.primaryColor),
          ),
          onPressed: _toggleDropdown,
          child: Row(
            mainAxisAlignment:
                style.mainAxisAlignment ?? MainAxisAlignment.center,
            textDirection:
                widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_currentIndex == -1) ...[
                widget.child,
              ] else ...[
                widget.items[_currentIndex],
              ],
              Expanded(child: innerItemsWidget),
              if (!widget.hideIcon)
                RotationTransition(
                  turns: _rotateAnimation,
                  child: widget.icon ?? const Icon(Icons.navigate_next),
                ),
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.dropdownStyle.width ?? size.width,
                child: CompositedTransformFollower(
                  offset:
                      widget.dropdownStyle.offset ?? Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    shape: widget.dropdownStyle.shape,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(18.0),
                    //     side: BorderSide(color: Colors.red)),
                    // shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(RadiusConstants.medium))),
                    // color: ColorConstants.secondaryColor,
                    elevation: widget.dropdownStyle.elevation ?? 0,
                    // borderRadius:
                    //     widget.dropdownStyle.borderRadius ?? BorderRadius.zero,
                    color: widget.dropdownStyle.color,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle.constraints ??
                            BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height -
                                  topOffset -
                                  15,
                              // maxHeight:
                              //     widget.dropdownStyle.maxHeight ?? size.height,
                            ),
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            scrollbars: false,
                            overscroll: false,
                            physics: const ClampingScrollPhysics(),
                            platform: Theme.of(context).platform,
                          ),
                          child: Scrollbar(
                              isAlwaysShown: true,
                              radius:
                                  const Radius.circular(RadiusConstants.small),
                              thickness: 2,
                              child: ListView(
                                padding: widget.dropdownStyle.padding ??
                                    EdgeInsets.zero,
                                shrinkWrap: true,
                                children:
                                    widget.items.asMap().entries.map((item) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() => _currentIndex = item.key);
                                      widget.onChange(
                                          item.value.value, item.key);
                                      _toggleDropdown();
                                    },
                                    child: item.value,
                                  );
                                }).toList(),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry!.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

class DropdownItem<T> extends StatelessWidget {
  final T value;
  final Widget child;

  const DropdownItem(this.child, this.value, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final OutlinedBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;
  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation,
    this.padding,
    this.shape,
  });
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Offset? offset;
  final double? width;
  final double? maxHeight;
  final ShapeBorder? shape;
  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.maxHeight,
    this.elevation,
    this.color,
    this.padding,
    this.borderRadius,
    this.shape,
  });
}
