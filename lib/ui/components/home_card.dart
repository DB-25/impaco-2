import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../impaco_theme.dart';
import '../screen_utils.dart';

class HomeCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String desc;
  final Color color;
  final VoidCallback onTap;
  final bool isSearchable;

  HomeCard({
    Key key,
    @required this.iconPath,
    @required this.title,
    @required this.desc,
    @required this.color,
    @required this.onTap,
    this.isSearchable = true,
  }) : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard>
    with SingleTickerProviderStateMixin {
  final descStyle = TextStyle(
    color: TEXT_COLOR,
    fontSize: iw(13),
    fontWeight: FontWeight.w200,
  );

  final _descKey = GlobalKey();

  Size get barSize {
    if (_descKey.currentContext == null) return Size.zero;
    final RenderBox renderBoxRed = _descKey.currentContext.findRenderObject();
    return renderBoxRed.size;
  }

  AnimationController _animationController;

  Animation<double> _searchBarFlyAnimation;
  Animation<double> _searchBarFadeAnimation;

  FocusNode _focusNode = FocusNode();

//  bool isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeOutCubic,
      parent: _animationController,
    );
    _searchBarFlyAnimation =
        Tween<double>(begin: -1, end: 0).animate(curvedAnimation);
    _searchBarFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    _focusNode.addListener(() {
      if(!_focusNode.hasFocus) {
        toggleSearchBar(false);
      } else if (_focusNode.hasFocus) {
        toggleSearchBar(true);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buildSearchBar() {
    if (barSize.height == 0) return Container();
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Positioned(
          right: barSize.width * _searchBarFlyAnimation.value,
          bottom: 0,
          child: Opacity(
            opacity: _searchBarFadeAnimation.value,
            child: Container(
              width: barSize.width,
              height: barSize.height + ih(8),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 2),
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                  ),
                  BoxShadow(
                    offset: Offset(-2, -2),
                    color: Colors.white.withOpacity(0.25),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        child: TextField(
                          focusNode: _focusNode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter PIN Code",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: ih(14),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: ih(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void toggleSearchBar(bool flyIn) {
    if (_animationController.isAnimating) return;
    !flyIn
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          if (widget.isSearchable) {
            if(_focusNode.hasFocus) FocusScope.of(context).requestFocus(new FocusNode());
            else _focusNode.requestFocus();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(ih(23)),
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.5),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(ih(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  widget.iconPath,
                  width: iw(34),
                  height: iw(34),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(),
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: TEXT_COLOR,
                    fontSize: iw(24),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: iw(14), bottom: iw(4)),
                      child: Text(
                        widget.desc,
                        key: _descKey,
                        style: descStyle,
                      ),
                    ),
                    buildSearchBar(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
