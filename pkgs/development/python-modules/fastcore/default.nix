{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  packaging,
  pytestCheckHook,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "fastcore";
  version = "1.5.51";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "fastai";
    repo = "fastcore";
    rev = "refs/tags/${version}";
    hash = "sha256-Dx+HnrVsceiwOORRW1PmmjvHJNcKzWjdIYIOW19FT7U=";
  };

  build-system = [ setuptools ];

  dependencies = [ packaging ];

  # Module has no tests
  doCheck = false;

  pythonImportsCheck = [ "fastcore" ];

  meta = with lib; {
    description = "Python module for Fast AI";
    homepage = "https://github.com/fastai/fastcore";
    changelog = "https://github.com/fastai/fastcore/blob/${version}/CHANGELOG.md";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
