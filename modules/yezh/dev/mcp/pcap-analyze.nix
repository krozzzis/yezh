{ delib, pkgs, lib, ... }:
let
  mcpPcapAnalyze = pkgs.writeShellScriptBin "mcp-pcap-analyze" ''
    export UV_PYTHON_PREFERENCE=only-system
    export UV_PYTHON=${lib.getExe pkgs.python3}
    exec ${pkgs.uv}/bin/uvx mcp-wireshark "$@"
  '';
in
delib.module {
  name = "user.dev";

  myconfig.ifEnabled = {
    user.dev.mcp."pcap-analyze" = {
      enable = true;
      type = "local";
      command = [ "${mcpPcapAnalyze}/bin/mcp-pcap-analyze" ];
    };
  };

  home.ifEnabled = {
    home.packages = [ pkgs.uv mcpPcapAnalyze ];
  };
}
