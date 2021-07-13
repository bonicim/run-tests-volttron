# Run Volttron Tests

A GitHub Action that sets up a Volttron test environment and runs the Volttron suite of tests. 

## Example

Below is a complete Workflows example. Note that there are two pre-steps before the run-tests-volttron Action is run and one post-step after the Action is finished:

````yaml
---
name: Testing testutils directory
on: [push, pull_request]

jobs:
  build:
    # The strategy allows customization of the build and allows matrixing the version of os and software
    # https://docs.github.com/en/free-pro-team@l.atest/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstrategy
    strategy:
      fail-fast: false
      matrix:
        # Each entry in the os and python-version matrix will be run so for the 2 x 2 there will be 4 jobs run
        os: [ ubuntu-18.04 ]
        python-version: [ 3.6, 3.7]

    runs-on: ${{ matrix.os }}

    steps:
      # checkout the volttron repository and set current directory to it
      - uses: actions/checkout@v2

      # Attempt to restore the cache from the build-dependency-cache workflow if present then
      # the output value steps.check_files.outputs.files_exists will be set (see the next step for usage)
      - name: Set up Python ${{matrix.os}} ${{ matrix.python-version }}
        uses: actions/setup-python@v2
        with:
          python-version: ${{ matrix.python-version }}

      # Run the specified tests and save the results to a unique file that can be archived for later analysis.
      - name: Run pytest on ${{ matrix.python-version }}, ${{ matrix.os }}
        uses: bonicim/run-tests-volttron@v1
        with:
            python_version: ${{ matrix.python-version }}
            os: ${{ matrix.os }}

#       Archive the results from the pytest to storage.
      - name: Archive test results
        uses: actions/upload-artifact@v2
        if: always()
        with:
          name: pytest-report
          path: output/test-testutils-${{matrix.os}}-${{ matrix.python-version }}-results.xml
````

## Inputs

### `operating system (os)`
The operating system used to run the tests. The os's are virtual environments provided by GitHub Actions. For a list of available environments, see: https://github.com/actions/virtual-environments

### `python version`
The version of Python that will be used to setup and run the Volttron tests. To know more about testing different versions of Python in GitHub Actions, see: https://docs.github.com/en/actions/guides/building-and-testing-python


## License

This project is licensed under the [Apache-2.0 License](LICENSE).