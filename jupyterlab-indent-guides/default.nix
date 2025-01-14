{ lib, python }:
let
  buildPythonPackage = python.pkgs.buildPythonPackage;
  fetchPypi = python.pkgs.fetchPypi;
in
buildPythonPackage rec {
  pname = "jupyterlab-indent-guides";
  version = "0.1.0";
  pyproject = true;

  src = fetchPypi {
    pname = "jupyterlab_indent_guides";
    inherit version;
    hash = "sha256-UetIM3yAUzez78lSYCZAPISm9bVjchUZPI+tDng9ugE=";
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

  # has no tests
  doCheck = false;

  pythonImportsCheck = [ "jupyterlab_indent_guides" ];

  meta = with lib; {
    description = "Indentation guides for JupyterLab";
    homepage = "https://github.com/firai/jupyterlab-indent-guides";
    license = licenses.bsd3;
    maintainers = [ ];
  };
}