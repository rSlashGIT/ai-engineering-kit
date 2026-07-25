import sys


def greet(name: str = "World") -> str:
    return f"Hello, {name}!"


def main() -> int:
    args = sys.argv[1:]
    name = args[0] if args else "World"
    print(greet(name))
    return 0


if __name__ == "__main__":
    sys.exit(main())
