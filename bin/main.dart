import 'dart:io';
import 'package:trab_petitparser/expression_parser.dart';

void main() async {
  final parser = ExpressionParser();

  final inputFilePath = 'assets/input.txt';
  final outputFilePath = 'assets/output.txt';

  final inputFile = File(inputFilePath);
  final expressions = await inputFile.readAsLines();

  final outputFile = File(outputFilePath);
  final sink = outputFile.openWrite();

  sink.writeln('-----------------------------------------');
  for (final expression in expressions) {
    try {
      final result = parser.evaluate(expression);
      sink.writeln('Resultado de $expression = $result');
      sink.writeln('-----------------------------------------');
    } catch (e) {
      sink.writeln('Erro na expressao: $expression');
      sink.writeln('-----------------------------------------');
    }
  }

  await sink.close();
  print('Resultados salvos em $outputFilePath');
}
