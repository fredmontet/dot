from setuptools import setup, find_packages

setup(
    name="jam",
    version="0.1.0",
    description="Dotfiles manager transformed into a Python project",
    packages=find_packages(),
    include_package_data=True,
    install_requires=["typer"],
    entry_points={
        "console_scripts": [
            "jam=jam.cli:main",
        ],
    },
    python_requires=">=3.6",
)