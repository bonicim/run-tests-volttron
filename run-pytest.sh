source env/bin/activate

pip install -e .

pytest volttrontesting/testutils -rf -o junit_family=xunit2
--junitxml=output/test-testutils-${{ inputs.os }}-${{ inputs.python_version }}-results.xml
