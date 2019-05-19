# source the system wide bashrc if it exists
if [ -e /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

# source the users bashrc if it exists
if [ -e "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi
export GOPUB_HOME=$HOME/.gopub
export PATH=$PATH:$GOPUB_HOME/bin
source $GOPUB_HOME/bin/gopubaliases
