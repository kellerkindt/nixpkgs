{ lib
, buildPythonPackage
, fetchPypi
, pytest
, coverage
}:

buildPythonPackage rec {
  pname = "pytest-cov";
  version = "2.12.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-JhzuuMIntyYkmzdrhSa2APOGZ+4xT5EDU/oxjKoB9Nc=";
  };

  buildInputs = [ pytest ];

  propagatedBuildInputs = [ coverage ];

  # xdist related tests fail with the following error
  # OSError: [Errno 13] Permission denied: 'py/_code'
  doCheck = false;
  checkPhase = ''
    # allow to find the module helper during the test run
    export PYTHONPATH=$PYTHONPATH:$PWD/tests
    py.test tests
  '';

  pythonImportsCheck = [ "pytest_cov" ];

  meta = with lib; {
    description = "Plugin for coverage reporting with support for both centralised and distributed testing, including subprocesses and multiprocessing";
    homepage = "https://github.com/pytest-dev/pytest-cov";
    license = licenses.mit;
  };
}
