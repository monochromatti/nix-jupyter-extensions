{ lib, python }:
let
  buildPythonPackage = python.pkgs.buildPythonPackage;
  fetchPypi = python.pkgs.fetchPypi;
in
buildPythonPackage rec {
  pname = "jupyterlab-search-replace";
  version = "1.1.0";
  pyproject = true;

  src = fetchPypi {
    pname = "jupyterlab_search_replace";
    inherit version;
    hash = "sha256-8Tm9femqm5xnpvpOA1St5NnAfoRY4y8Ch2YcMNuRcj8=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace '"jupyterlab>=4.0.0,<5",' ""
  '';

  nativeBuildInputs = with python.pkgs; [
    hatchling
    hatch-jupyter-builder
    hatch-nodejs-version
    jupyterlab-server
  ];

  doCheck = false;

  pythonImportsCheck = [ "jupyterlab_search_replace" ];

  meta = with lib; {
    description = "Search and replace across files";
    homepage = "https://github.com/jupyterlab-contrib/search-replace";
    license = licenses.bsd3;
    maintainers = [ ];
  };
}
