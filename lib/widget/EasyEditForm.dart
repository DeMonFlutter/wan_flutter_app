import 'package:flutter/material.dart';
import 'package:wan_flutter_app/style/DIcons.dart';

/// @author DeMon
/// Created on 2020/7/31.
/// E-mail 757454343@qq.com
/// Desc: 封装的TextFormField，具有三种普通模式，清除模式，密码模式

enum EditMode { none, clear, password }

class EasyEditForm extends StatefulWidget {
  EasyEditForm(
      {this.labelText,
      this.hintText,
      this.counterText,
      this.errorText,
      this.helperText,
      this.fillColor,
      this.editMode,
      this.controller,
      this.keyboardType,
      this.onChanged,
      this.textInputAction,
      this.focusNode,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.maxLines,
      this.icon,
      this.initialValue,
      this.validator,
      this.maxLength});

  final String labelText;
  final String hintText;
  final String counterText;
  final String errorText;
  final String helperText;
  final Color fillColor;
  final EditMode editMode;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final int maxLines;
  final String initialValue;
  final FormFieldValidator<String> validator;
  final int maxLength;

  @override
  State<StatefulWidget> createState() {
    return EasyEditFormState();
  }
}

class EasyEditFormState extends State<EasyEditForm> {
  bool canSee = false;
  int index = 0;
  int lines = 1;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.maxLines != null) {
      lines = widget.maxLines;
    }
    if (widget.editMode != null) {
      index = widget.editMode.index;
      if (widget.editMode.index == 2) {
        canSee = true;
        lines = 1;
      }
    }

    if (widget.controller != null) {
      _controller = widget.controller;
    }
    //controller与initialValue 不能同时存在，这里使用controller.text的赋初值
    _controller.text = widget.initialValue ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    OutlineInputBorder createBorder(Color color) {
      return OutlineInputBorder(borderSide: BorderSide(color: color), borderRadius: BorderRadius.all(Radius.circular(10)));
    }

    Widget _buildIcon() {
      switch (index) {
        case 1:
          return IconButton(
            icon: Icon(Icons.clear, size: 20, color: Colors.black45),
            onPressed: () {
              if (widget.controller == null) {
                _controller.clear();
              } else {
                widget.controller.clear();
              }
            },
          );
          break;
        case 2:
          return IconButton(
            icon: Icon(canSee ? DIcons.cant_see : DIcons.see, size: 20, color: Colors.black45),
            onPressed: () {
              setState(() => canSee = !canSee);
            },
          );
          break;
        default:
          return null;
          break;
      }
    }

    return TextFormField(
        maxLength: widget.maxLength,
        maxLines: lines,
        onFieldSubmitted: widget.onFieldSubmitted,
        onEditingComplete: widget.onEditingComplete,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        controller: _controller,
        obscureText: canSee,
        validator: widget.validator,
        decoration: InputDecoration(
          border: createBorder(theme.primaryColor),
          focusedBorder: createBorder(theme.primaryColor),
          enabledBorder: createBorder(theme.primaryColor),
          disabledBorder: createBorder(Colors.grey),
          errorBorder: createBorder(theme.primaryColorDark),
          focusedErrorBorder: createBorder(theme.primaryColorDark),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: theme.primaryColorDark),
          helperText: widget.helperText,
          helperStyle: TextStyle(color: theme.accentColor),
          suffixIcon: _buildIcon(),
          counterText: widget.counterText,
          counterStyle: TextStyle(color: theme.primaryColorDark),
          prefixIcon: widget.icon == null ? null : Icon(widget.icon),
          fillColor: widget.fillColor ?? Color(0x110099ee),
          filled: true,
          errorText: widget.errorText,
          errorStyle: TextStyle(color: Colors.red),
          errorMaxLines: 1,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          hintMaxLines: 1,
        ));
  }
}
