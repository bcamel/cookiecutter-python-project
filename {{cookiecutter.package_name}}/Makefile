# This makefile has been created to help developers perform common actions.
# Most actions assume it is operating in a virtual environment where the
# python command links to the appropriate virtual environment Python.

MAKEFLAGS += --no-print-directory

ifeq ($(OS),Windows_NT)
	VENV_CMD = venv/Scripts/python.exe -m pip install pip --upgrade && venv/Scripts/python.exe -m pip install setuptools --upgrade
	VENV_HLP = @echo "Enter virtual environment using: venv\Scripts\activate.bat"
else
	VENV_CMD = @/bin/bash -c "source venv/bin/activate && python -m pip install pip --upgrade && python -m pip install setuptools --upgrade"
	VENV_HLP = @echo "Enter virtual environment using: source venv/bin/activate"
endif

# Do not remove this block. It is used by the 'help' rule when
# constructing the help output.
# help:
# help: {{cookiecutter.package_display_name}} Makefile help
# help:

# help: help                           - display this makefile's help information
.PHONY: help
help:
	@grep "^# help\:" Makefile | grep -v grep | sed 's/\# help\: //' | sed 's/\# help\://'


# help: check-docs                     - quick check docs consistency
.PHONY: check-docs
check-docs:
	@cd docs; make dummy


# help: check-format                   - check code format compliance
.PHONY: check-format
check-format:
	@black --check {{cookiecutter.package_name}} tests examples


# help: check-lint                     - run static analysis checks
.PHONY: check-lint
check-lint:
	@pylint --rcfile=.pylintrc {{cookiecutter.package_name}} ./tests setup.py ./examples  || pylint-exit $$?


# help: check-sort-imports             - check imports are sorted
.PHONY: check-sort-imports
check-sort-imports:
	@isort . --check-only --profile black


# help: check-static-analysis          - check code style compliance
.PHONY: check-static-analysis
check-static-analysis: check-lint check-types


# help: check-style                    - check code style compliance
.PHONY: check-style
check-style: check-sort-imports check-format


# help: check-types                    - check type hint annotations
.PHONY: check-types
check-types:
	@mypy -p {{cookiecutter.package_name}} --ignore-missing-imports


# help: clean                          - clean all files using .gitignore rules
.PHONY: clean
clean:
	@git clean -X -f -d


# help: coverage                       - perform test coverage checks
.PHONY: coverage
coverage:
	@pytest --junitxml=junit/test-results.xml --cov=. --cov-report=xml


# help: docs                           - generate project documentation
.PHONY: docs
docs: coverage
	@cd docs; rm -rf source/api/{{cookiecutter.package_name}}*.rst source/api/modules.rst build/*
	@cd docs; make html


# help: dist                           - create a wheel distribution package
.PHONY: dist
dist:
	@python setup.py bdist_wheel


# help: dist-test                      - test a whell distribution package
.PHONY: dist-test
dist-test: dist
	@cd dist && ../tests/test-dist.bash ./{{cookiecutter.package_name}}-*-py3-none-any.whl


# help: dist-upload                    - upload a wheel distribution package
.PHONY: dist-upload
dist-upload:
	@twine upload dist/{{cookiecutter.package_name}}-*-py3-none-any.whl


# help: format                         - perform code style format
.PHONY: format
format:
	@black {{cookiecutter.package_name}} tests examples


# help: requirements-txt               - generate requirements[-dev].txt files
.PHONY: requirements-txt
requirements-txt:
	@pip-compile --generate-hashes --quiet --rebuild --output-file requirements.txt
	@pip-compile --generate-hashes --quiet --rebuild --output-file requirements.dev.txt requirements.txt requirements.dev.in


# help: serve-docs                     - serve project html documentation
.PHONY: serve-docs
serve-docs:
	@cd docs/build; python -m http.server --bind 127.0.0.1


# help: sort-imports                   - apply import sort ordering
.PHONY: sort-imports
sort-imports:
	@isort . --profile black


# help: style                          - perform code style format
.PHONY: style
style: sort-imports format


# help: test                           - run tests
.PHONY: test
test:
	@pytest


# help: venv                           - create a virtual environment for development
.PHONY: venv
venv:
	@rm -Rf venv
	@python -m venv venv --prompt {{cookiecutter.package_name}}
	$(VENV_CMD)
	$(VENV_HLP)


# Keep these lines at the end of the file to retain nice help
# output formatting.
# help:
