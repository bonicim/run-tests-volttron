# Run Volttron Tests

A GitHub Action that sets up a Volttron test environment and runs a user-specified Volttron suite of tests. 

## Example

Below is a complete Workflows example. Note that there are two pre-steps before the run-tests-volttron Action is run:

````yaml
---
name: Testing testutils directory
on: [push, pull_request]

jobs:
  build:
    strategy:
      fail-fast: false
      matrix:
        os: [ ubuntu-18.04, ubuntu-20.04 ]
        python-version: [ 3.6, 3.7 ]

    runs-on: ${{ matrix.os }}

    steps:
      - uses: actions/checkout@v2

      - name: Set up Python ${{matrix.os}} ${{ matrix.python-version }}
        uses: actions/setup-python@v2
        with:
          python-version: ${{ matrix.python-version }}

      - name: Run pytest on ${{ matrix.python-version }}, ${{ matrix.os }}
        uses: bonicim/run-tests-volttron@v0.2-beta
        with:
            python_version: ${{ matrix.python-version }}
            os: ${{ matrix.os }}
            test_path: volttrontesting/testutils
            test_output_suffix: testutils
````

## Inputs

### `operating system (os)`
The operating system used to run the tests. The os's are virtual environments provided by GitHub Actions. For a list of available environments, see: https://github.com/actions/virtual-environments

### `python version`
The version of Python that will be used to setup and run the Volttron tests. To know more about testing different versions of Python in GitHub Actions, see: https://docs.github.com/en/actions/guides/building-and-testing-python

### `test_path`
The path to a directory or file that contains Volttron-specific tests from the [Volttron repo](https://github.com/VOLTTRON/volttron).

### `test_output_suffix`
The suffix to be appended to the name of the output file generated from running Volttron tests.

## License

This project is licensed under the [Apache-2.0 License](LICENSE).