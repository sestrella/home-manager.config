{ ... }:

{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        addKeysToAgent = "yes";
        extraOptions.UseKeychain = "yes";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
      };
      github-personal = {
        addKeysToAgent = "yes";
        extraOptions.UseKeychain = "yes";
        hostname = "github.com";
        identitiesOnly = true;
        identityFile = "~/.ssh/personal.id_ed25519";
      };
    };
  };
}
