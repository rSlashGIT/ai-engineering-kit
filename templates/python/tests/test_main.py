from src.main import greet


class TestGreet:
    def test_greet_default(self) -> None:
        assert greet() == "Hello, World!"

    def test_greet_custom_name(self) -> None:
        assert greet("Python") == "Hello, Python!"
