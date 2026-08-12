{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      permission = {
        read = {
          "*" = "allow";
          "**/.env" = "deny";
          "**/.env.*" = "deny";
          "**/.aws/**" = "deny";
          "**/.ssh/**" = "deny";
          "**/.gnupg/**" = "deny";
          "**/.kube/**" = "deny";
          "**/.netrc" = "deny";
          "**/*.pem" = "deny";
          "**/*.key" = "deny";
          "**/*.p12" = "deny";
          "**/*.pfx" = "deny";
          "**/secrets/**" = "deny";
          "**/credentials/**" = "deny";
        };

        edit = {
          "*" = "allow";
          "**/.git/**" = "ask";
        };

        bash = {
          "*" = "allow";
          "rm -rf *" = "deny";
          "sudo rm *" = "deny";
          "git reset --hard*" = "deny";
          "git clean -fd*" = "deny";
          "git rebase*" = "deny";
          "git filter-branch*" = "deny";
          "git filter-repo*" = "deny";
          "git push --force*" = "deny";
          "git push -f*" = "deny";
          "mkfs*" = "deny";
          "dd *" = "deny";
        };

        glob = {
          "*" = "allow";
          "**/.ssh/**" = "deny";
          "**/.aws/**" = "deny";
          "**/.kube/**" = "deny";
        };

        grep = {
          "*" = "allow";
          "password|secret|token|private_key|credential" = "ask";
        };

        external_directory = "ask";
        task = "ask";
        skill = "ask";
        webfetch = "ask";
        websearch = "allow";
        doom_loop = "ask";
      };
    };

    tui.theme = "system";
  };
}
