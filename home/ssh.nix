{ ... }:

{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;
    settings = {
      "github.com" = {
        AddKeysToAgent = "yes";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
        UseKeychain = "yes";
      };
      github-personal = {
        AddKeysToAgent = "yes";
        Hostname = "github.com";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/personal.id_ed25519";
        UseKeychain = "yes";
      };
    };
  };
}
