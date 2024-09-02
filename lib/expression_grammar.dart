import 'package:petitparser/petitparser.dart';

class ExpressionGrammarDefinition extends GrammarDefinition {
  @override
  Parser start() => ref0(expression).end();

  Parser expression() =>
      ref0(term) & (char('+') | char('-')).trim() & ref0(expression) |
      ref0(term);

  Parser term() =>
      ref0(factor) & (char('*') | char('/')).trim() & ref0(term) |
      ref0(factor);

  Parser factor() =>
      ref0(number) |
      char('(').trim() & ref0(expression) & char(')').trim();

  Parser number() => digit().plus().flatten().trim();
}
