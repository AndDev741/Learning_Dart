void main(List<String> arguments) {
  print('Hello World');

  assert(arguments.length == 1);

  print("Your name: ${arguments[0]}");
}