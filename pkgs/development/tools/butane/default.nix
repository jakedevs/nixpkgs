{ lib, fetchFromGitHub, buildGoModule }:

with lib;

buildGoModule rec {
  pname = "butane";
  version = "0.13.0";

  src = fetchFromGitHub {
    owner = "coreos";
    repo = "butane";
    rev = "v${version}";
    sha256 = "0z1cq43dnj73k0idjhc310h00a1mryk2297w3yy6k1sa95swlz9m";
  };

  vendorSha256 = null;

  doCheck = false;

  subPackages = [ "internal" ];

  buildFlagsArray = ''
    -ldflags=-X github.com/coreos/butane/internal/version.Raw=v${version}
  '';

  postInstall = ''
    mv $out/bin/{internal,butane}
  '';

  meta = {
    description = "Translates human-readable Butane configs into machine-readable Ignition configs";
    license = licenses.asl20;
    homepage = "https://github.com/coreos/butane";
    maintainers = with maintainers; [ elijahcaine ruuda ];
    platforms = platforms.unix;
  };
}
