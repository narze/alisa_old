_alisa() {
  #TODO: Skip if same command was ran < 3 times
  #TODO: Skip if already alias'ed

  cmd="$*"
  cmd_len=${#cmd}

  if (( $cmd_len > 6 )); then
    read -q "REPLY?This command is too long! Do you want me to alias it? (y/N) "
    echo "/n"

    if [[ $REPLY =~ ^(Y|y) ]]; then
      #Get shortened command (using first letter of each word)
      cmd_short=$(echo $cmd | awk '{for (i=1;i<=NF;i++) printf(substr($i,1,1))}')
      # echo "Cmd short is $cmd_short"

      #TODO: Check if command is not already aliased
      #TODO: Alias command
      #TODO: Add alias into ~/.alisa for later use
    fi
  fi
}

_alisa_precmd() {
  # For preexec use "${@: -1}" instead
  _alisa $history[$[HISTCMD-1]]
}

# ZSH : Add into precmd_functions
[[ -n "${precmd_functions[(r)_alisa_precmd]}" ]] || {
  precmd_functions[$(($#precmd_functions+1))]=_alisa_precmd
}

# Source ~/.alisa
[[ -r "$HOME/.alisa" ]] && {
  . "$HOME/.alisa"
}

