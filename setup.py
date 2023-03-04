from setuptools import setup, find_packages

with open("requirements.txt") as f:
	install_requires = f.read().strip().split("\n")

# get version from __version__ variable in librarymanagement/__init__.py
from librarymanagement import __version__ as version

setup(
	name="librarymanagement",
	version=version,
	description="Library Management",
	author="Library Management",
	author_email="abc@xyz.com",
	packages=find_packages(),
	zip_safe=False,
	include_package_data=True,
	install_requires=install_requires
)
