import 'package:flutter/material.dart';

class PasswordCheckerWidget extends StatefulWidget {
  final String password;
  final int minimumCharacters;
  final bool requireUppercase;
  final bool requireLowercase;
  final bool requireNumber;
  final bool requireSpecialChar;

  const PasswordCheckerWidget({
    super.key,
    required this.password,
    required this.minimumCharacters,
    required this.requireUppercase,
    required this.requireLowercase,
    required this.requireNumber,
    required this.requireSpecialChar,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PasswordCheckerWidgetState createState() => _PasswordCheckerWidgetState();
}

class _PasswordCheckerWidgetState extends State<PasswordCheckerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.password.isNotEmpty)
          _buildRuleCheckbox(_ruleCheckString(), _ruleCheckResult)
      ],
    );
  }

  Widget _buildRuleCheckbox(String label, bool Function() ruleCheck) {
    return Row(
      children: [
        Checkbox(
          value: ruleCheck(),
          onChanged: null,
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.all<Color>(Colors.pink),
          shape: const CircleBorder(),
        ),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )
      ],
    );
  }

  bool _passwordLengthCheck() {
    return widget.password.length >= widget.minimumCharacters;
  }

  bool _containsUppercase() {
    return widget.requireUppercase &&
        RegExp(r'[A-Z]').hasMatch(widget.password);
  }

  bool _containsLowercase() {
    return widget.requireLowercase &&
        RegExp(r'[a-z]').hasMatch(widget.password);
  }

  bool _containsNumber() {
    return widget.requireNumber && RegExp(r'\d').hasMatch(widget.password);
  }

  bool _containsSpecialChar() {
    return widget.requireSpecialChar &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(widget.password);
  }

  String _ruleCheckString() {
    if (!_passwordLengthCheck()) {
      return 'Minimum ${widget.minimumCharacters} characters';
    } else if (!_containsUppercase()) {
      return 'Require Uppercase';
    } else if (!_containsLowercase()) {
      return 'Require Lowercase';
    } else if (!_containsNumber()) {
      return 'Require Number';
    } else if (!_containsSpecialChar()) {
      return 'Require Special Character';
    }
    return 'Good!';
  }

  bool _ruleCheckResult() {
    return _passwordLengthCheck() &&
        _containsUppercase() &&
        _containsLowercase() &&
        _containsNumber() &&
        _containsSpecialChar();
  }
}
