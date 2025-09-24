{ pkgs, ... }:

{
  dotenv.enable = true;

  git-hooks.hooks.prepare-commit-msg = {
    enable = true;
    entry = toString (
      pkgs.writers.writePython3 "prepare-commit-msg"
        {
          libraries = [ pkgs.python3Packages.openai ];
          # TODO: fix linter warnings
          doCheck = false;
        }
        ''
          import os
          import subprocess
          import sys

          from openai import OpenAI

          diff = subprocess.check_output(["git", "diff", "--cached"], text=True)

          client = OpenAI()
          response = client.responses.create(
              model="gpt-4-turbo",
              input=[
                  {"role": "system", "content": "You are an assistant that writes concise, conventional commit messages."},
                  {"role": "user", "content": f"Generate a commit message for the following git diff:\n\n{diff}"}
              ]
          )

          # output(type=message)
          # content(type=output_text)
          commit_message = response.output[0].content[0].text.strip()
          commit_msg_file = sys.argv[1]
          with open(commit_msg_file, "w") as file:
              file.write(commit_message)
        ''
    );
    stages = [ "prepare-commit-msg" ];
  };

  # See full reference at https://devenv.sh/reference/options/
}
