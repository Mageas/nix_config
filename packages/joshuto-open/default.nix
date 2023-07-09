{ lib
, writeShellApplication
, ...
}:

writeShellApplication
{
  name = "joshuto-open";
  checkPhase = "";
  text = ''
    cwd_file="/tmp/joshuto-cwd"
    env joshuto --output-file "$cwd_file" --path "$(pwd)" $@

    if [ -e "$cwd_file" ]; then
        joshuto_cwd=$(cat "$cwd_file")
        rm "$cwd_file" &>/dev/null && joshuto_cwd=$joshuto_cwd zsh -c 'cd "$joshuto_cwd"; clear; zsh -i'
    fi
  '';
} 
