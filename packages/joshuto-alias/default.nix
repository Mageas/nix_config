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
        rm "$cwd_file" &>/dev/null && cd "$joshuto_cwd"
    fi
  '';
} 
