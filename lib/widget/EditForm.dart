import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_flutter_app/style/DIcons.dart';

/// @author DeMon
/// Created on 2020/7/24.
/// E-mail 757454343@qq.com
/// Desc:
class EditForm extends StatefulWidget {
  EditForm({this.icon, this.hintText, this.controller, this.keyboardType, this.obscureText, this.onChanged, this.textInputAction, this.focusNode, this.onEditingComplete});

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;

  @override
  State<StatefulWidget> createState() {
    return EditFormState();
  }
}

class EditFormState extends State<EditForm> {
  bool canSee = false;

  @override
  void initState() {
    if (widget.obscureText != null) {
      canSee = widget.obscureText;
    }
    super.initState();
  }

  Widget buildPwdIcon() {
    return Offstage(
        offstage: (widget.obscureText == null || !widget.obscureText),
        child: IconButton(
          icon: Icon(canSee ? DIcons.cant_see : DIcons.see, size: 25, color: Colors.black45),
          onPressed: () {
            setState(() => canSee = !canSee);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Icon(
                  widget.icon,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  obscureText: canSee,
                  onChanged: widget.onChanged,
                  textInputAction: widget.textInputAction,
                  focusNode: widget.focusNode,
                  onEditingComplete: widget.onEditingComplete,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              buildPwdIcon()
            ],
          ),
        )
      ],
    );
  }
}
