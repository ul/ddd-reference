{ pkgs ? import <nixpkgs> {} }:

let
  resilientVersion = builtins.replaceStrings [ "\n" " " ] [ "" "" ]
    (builtins.readFile ./.resilient-version);

  build = pkgs.writeShellScriptBin "build" ''
    exec sile --luarocks-tree lua_modules -u inputters.silm ddd-reference.silm "$@"
  '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    sile
    lua5_1
    luarocks
    gcc
    gentium-plus
    build
  ];

  FONTCONFIG_FILE = pkgs.makeFontsConf {
    fontDirectories = [ pkgs.gentium-plus ];
  };

  shellHook = ''
    echo "Installing resilient.sile ${resilientVersion}..."
    luarocks --lua-version 5.1 --tree lua_modules install resilient.sile ${resilientVersion}

    echo "Run 'build' to generate the PDF."
  '';
}
