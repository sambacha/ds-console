#!/bin/bash
 local deps;
  local sep; sep=""

  printf %s "{
  \"contracts\": {"

  echo >&2 "$repos"
  for path in $(cut -d " " -f1 <<<"$repos"); do

    if [[ $path != "$root" ]]; then
      printf %s "$sep"; sep=","
      if [[ -f "$path/.dapp.json" ]]; then
        jq .contracts "$path/.dapp.json" | sed '1d;$d'
      else
        spec "$path"
      fi
    fi
  done

    printf %s "
  };"
  },
  \"this\": {
$(spec "$path" | sed '1,2d;$d')
  }
}"
}
