{ lib
, writeShellApplication
, ...
}:

writeShellApplication
{
  name = "joshuto-open";
  checkPhase = "";
  text = ''
    CWD_FILE="/tmp/joshuto-cwd"
    env joshuto --output-file "${CWD_FILE}" --path "$(pwd)" $@

    if [ -e "${CWD_FILE}" ]; then
        JOSHUTO_CWD=$(cat "${CWD_FILE}")
        rm "${CWD_FILE}" &>/dev/null && JOSHUTO_CWD=${JOSHUTO_CWD} zsh -c 'cd "${JOSHUTO_CWD}"; clear; zsh -i'
    fi
  '';
} 
