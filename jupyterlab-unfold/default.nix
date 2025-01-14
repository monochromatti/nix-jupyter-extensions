{ lib, python }:
let
  buildPythonPackage = python.pkgs.buildPythonPackage;
  fetchPypi = python.pkgs.fetchPypi;
in
buildPythonPackage rec {
  pname = "jupyterlab-unfold";
  version = "0.3.2";
  pyproject = true;

  src = fetchPypi {
    pname = "jupyterlab_unfold";
    inherit version;
    hash = "sha256-u4zfhCld/a2vdrEVJRtqO1401A9uUzNv9M1LfoCVHAk=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace '"jupyterlab>=4.0.0,<5",' ""
  '';

  nativeBuildInputs = with python.pkgs; [
    hatch-jupyter-builder
    hatch-nodejs-version
    hatchling
  ];

  doCheck = false;

  pythonImportsCheck = [ ];

  meta = with lib; {
    description = "A vscode-like file browser";
    homepage = "https://github.com/firai/jupyterlab-indent-guides";
    license = licenses.bsd3;
    maintainers = [ ];
  };
}