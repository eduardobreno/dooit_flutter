import 'package:flutter/material.dart';

class TodoItemComp extends StatefulWidget {
  TodoItemComp(
      {this.isChecked,
      this.text,
      this.onChange,
      this.onBlur,
      this.onCheck,
      this.delete});

  final bool isChecked;
  final String text;
  final Function onChange;
  final Function onBlur;
  final Function onCheck;
  final Function delete;

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItemComp> {
  final _focusNode = new FocusNode();
  final TextEditingController _textController = new TextEditingController();

  _focusListener() {
    setState(() {});
    if (!_focusNode.hasFocus) {
      widget.onBlur(_textController.text);
    }
  }

  @override
  void initState() {
    _focusNode.addListener(_focusListener);
    _textController.addListener(_onChangeTextField);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _textController.dispose();

    super.dispose();
  }

  _onChangeTextField() {
    // _textController.selection =
    //     TextSelection.collapsed(offset: _textController.text.length);
    widget.onChange(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Checkbox(
            value: widget.isChecked,
            onChanged: (value) => {widget.onCheck()},
          ),
        ),
        Expanded(
          child: TextField(
            controller: _textController..text = widget.text,
            // onChanged: (text) => _onChangeTextField(text),
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: "Item da lista",
              border: _focusNode.hasFocus ? null : InputBorder.none,
            ),
          ),
        ),
        Visibility(
          visible: _focusNode.hasFocus,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => widget.delete(),
            ),
          ),
        )
      ],
    );
  }
}
