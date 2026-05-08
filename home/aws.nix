{ pkgs, ... }:

{
  home.sessionVariables.AWS_VAULT_KEYCHAIN_NAME = "login";

  home.packages = [
    pkgs.aws-vault
    pkgs.awscli2
  ];
}
