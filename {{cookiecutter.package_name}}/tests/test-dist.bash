#!/usr/bin/env bash
#
# This script creates a virtual environment and installs a distribution of
# this project into the environment and then executes the unit tests. This
# provides a crude check that the distribution is installable and that the
# package is minimally functional.
#

if [ -z "$1" ]; then
  echo "usage: $0 {{cookiecutter.package_name}}-YY.MM.MICRO-py3-none-any.whl"
  exit
fi

RELEASE_ARCHIVE="$1"

echo "Release archive: $RELEASE_ARCHIVE"

echo "Removing any old artefacts"
rm -rf test_venv

echo "Creating test virtual environment"
python -m venv test_venv

if [[ "${OS}" != "Windows_NT" ]]
then
  echo "Entering test virtual environment"
  source test_venv/bin/activate
fi

echo "Upgrading pip"
if [[ "${OS}" == "Windows_NT" ]]
then
  test_venv/Scripts/python.exe -m pip install pip --upgrade
else
  python -m pip install pip --upgrade
fi

echo "Installing $RELEASE_ARCHIVE"
if [[ "${OS}" == "Windows_NT" ]]
then
  test_venv/Scripts/python.exe -m pip install $RELEASE_ARCHIVE
else
  python -m pip pip install $RELEASE_ARCHIVE
fi

echo "Running tests"
if [[ "${OS}" == "Windows_NT" ]]
then
  test_venv/Scripts/python.exe -m unittest discover -s ../tests
else
  cd ../tests
  python -m unittest discover -s .
fi

if [[ "${OS}" != "Windows_NT" ]]
then
  echo "Exiting test virtual environment"
  deactivate
fi
