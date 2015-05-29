# add color to grep result 
alias grep='grep --color=auto'
 
# coding "ritual"
alias startcoding='cd ~/workspace/src'

# timing commands
alias xtime="/usr/bin/time -f '%Uu %Ss %er %MkB %C' \"$@\""

# gitk tree view
alias gitka='gitk --all'

# quick db access
connect_postgres_db(){
  HOST=$1
  USER=$2
  PORT=$3
  DB=$4
  PG_PASSFILE=$5

  if [[ -n $PG_PASSFILE ]]
  then
    PGPASSFILE=$PG_PASSFILE psql -h $HOST -U $USER -p $PORT -d $DB
  else
    psql -h $HOST -U $USER -p $PORT -d $DB
  fi
}

staging_db(){
  connect_postgres_db 'ip.of.your.db' 'user' 'port' "$1" "PGPASSFILE"
}

prod_db() {
  connect_postgres_db 'ip.of.your.db' 'user' 'port' "$1" "PGPASSFILE"
}

local_db(){
  connect_postgres_db '127.0.0.1' 'postgres' '5432' "$1" "PGPASSFILE"
}

alias staging.db=staging_db
alias prod.db=prod_db
alias local.db=local_db

# custom routing for vpn traffic
alias happyvpn='sudo ~/.ssh/happyvpn'

# gofmt
gofmt_recursive(){
  files=$(find -type f -name "*.go" | grep -v Godeps)
  for file in $files; do go fmt $file; done
}
alias gofmtr=gofmt_recursive
