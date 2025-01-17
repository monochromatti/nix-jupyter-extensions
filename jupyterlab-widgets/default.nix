{ lib, python }:
let
  buildPythonPackage = python.pkgs.buildPythonPackage;
  fetchPypi = python.pkgs.fetchPypi;
  jupyter-packaging = python.pkgs.jupyter-packaging;
in
buildPythonPackage rec {
  pname = "jupyterlab-widgets";
  version = "3.0.13";
  pyproject = true;

  src = fetchPypi {
    pname = "jupyterlab_widgets";
    inherit version;
    hash = "sha256-opZtOFMowZQraDqM2WuJuN2CyLj4HdqQK7K8BtRvW+0=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace '"jupyterlab~=4.0"' ""
  '';

  nativeBuildInputs = [
    jupyter-packaging
  ];

  doCheck = false;

  pythonImportsCheck = [
    "jupyterlab_widgets"
  ];

  meta = with lib; {
    description = "Jupyter Widgets JupyterLab Extension";
    homepage = "https://github.com/jupyter-widgets/ipywidgets";
    license = licenses.bsd3;
    maintainers = [ ];
  };
}
