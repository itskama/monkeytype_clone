import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final bool isActive;
  final bool isCompleted;
  final String initialValue;

  const InputFieldWidget({
    super.key,
    required this.onChanged,
    required this.isActive,
    this.isCompleted = false,
    this.initialValue = '',
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isCompleted && widget.isActive) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void didUpdateWidget(covariant InputFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
    
    if (!widget.isCompleted && widget.isActive) {
      _focusNode.requestFocus();
    } else if (widget.isCompleted) {
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        enabled: !widget.isCompleted,
        maxLines: 3,
        minLines: 3,
        decoration: InputDecoration(
          labelText: 'Введите текст',
          hintText: 'Начните печатать здесь...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: widget.isCompleted
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                )
              : widget.isActive
                  ? Icon(
                      Icons.play_arrow,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : const Icon(Icons.keyboard),
          filled: true,
        ),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}