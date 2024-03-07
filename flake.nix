{
  inputs = rec {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    zls-overlay.url = "github:zigtools/zls/300770c";
  };
  outputs = inputs@{ self, nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      zig = inputs.zig-overlay.packages.x86_64-linux.master-2024-03-06;
      zls = inputs.zls-overlay.packages.x86_64-linux.zls.overrideAttrs
        (old: { nativeBuildInputs = [ zig ]; });
    in {
      devShells.x86_64-linux.default =
        pkgs.mkShell { packages = with pkgs; [ lldb zig zls ]; };
    };
}
