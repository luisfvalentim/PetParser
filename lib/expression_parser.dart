import 'expression_grammar.dart';
import 'package:petitparser/petitparser.dart';

class ExpressionParser {
  final Parser _parser;

  ExpressionParser() : _parser = ExpressionGrammarDefinition().build();

  num evaluate(String input) {
    final result = _parser.parse(input);
    if (result.isSuccess) {
      return _evaluateTree(result.value);
    } else {
      throw FormatException('Invalid expression: $input');
    }
  }

  num _evaluateTree(dynamic node) {
    if (node is List) {
      if (node.length == 3 && node[1] == '+') {
        return _evaluateTree(node[0]) + _evaluateTree(node[2]);
      } else if (node.length == 3 && node[1] == '-') {
        return _evaluateTree(node[0]) - _evaluateTree(node[2]);
      } else if (node.length == 3 && node[1] == '*') {
        return _evaluateTree(node[0]) * _evaluateTree(node[2]);
      } else if (node.length == 3 && node[1] == '/') {
        return _evaluateTree(node[0]) / _evaluateTree(node[2]);
      } else {
        return _evaluateTree(node[1]);
      }
    } else if (node is String) {
      return int.parse(node);
    }
    throw FormatException('Unexpected node: $node');
  }
}