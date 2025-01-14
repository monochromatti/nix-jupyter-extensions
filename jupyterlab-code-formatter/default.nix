{ lib, python }:
let
  buildPythonPackage = python.pkgs.buildPythonPackage;
  fetchPypi = python.pkgs.fetchPypi;
in
buildPythonPackage rec {
  pname = "jupyterlab-code-formatter";
  version = "3.0.2";
  pyproject = true;

  src = fetchPypi {
    pname = "jupyterlab_code_formatter";
    inherit version;
    hash = "sha256-Va24+oub1Y8LOefT6tbB6GLp68FESmbNtCM9jcY1HUs=";
  };

  # jupyterlab is required to build from source but we use the pre-build package
  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace '"jupyterlab>=4.0.0,<5",' ""
  '';

  nativeBuildInputs = with python.pkgs; [
    hatch-jupyter-builder
    hatch-nodejs-version
    hatchling
  ];

  propagatedBuildInputs = with python.pkgs; [
    jupyterlab-server
  ];

  doCheck = false;

  pythonImportsCheck = [ "jupyterlab_code_formatter" ];

  meta = with lib; {
    description = "A JupyterLab plugin to facilitate invocation of code formatters.";
    homepage = "https://jupyterlab-code-formatter.readthedocs.io";
    license = licenses.bsd3;
    maintainers = [ ];
  };
}
