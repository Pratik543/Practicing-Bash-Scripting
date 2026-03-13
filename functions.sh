#! /bin/bash

# Fucntions

add() {
  echo "Addition is $(($1 + $2))"
}

subtract() {
  echo "Subtraction is $(($1 - $2))"
}

multiply() {
  echo "Multiplication is $(($1 * $2))"
}

greet() {
  echo "Good Morning $1, From System Admin: $2"
}

# Calling Functions

add 394 232
subtract 23829 4389
multiply 230 222
greet harley david
