shopt -s histappend
shopt -s cmdhist
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%F %T '
export PROMPT_COMMAND='history -a'

export CDPATH=.:~/git:~:/tmp

# Color definitions, stolen from
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[10;95m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

# host name up to the first dot
SHORT_HOSTNAME=`echo $HOSTNAME|cut -d. -f1`

# tty with leading "/dev/" removed
TTY=`tty|sed s#/dev/##`

# The prompt function tries to use bash built-ins instead of external processes
# as much as possible.  The prompt function gets called frequently, so spawning
# a lot of external processes could harm performance, particularly on
# Windows/Cygwin.
function prompt() {
    if [[ $PWD == $HOME ]]; then
        local lpwd='~'
    else
        # last component of current directory
        local lpwd=${PWD##*/}
    fi

    # Scan up the directory tree to find out if we're in a path controlled by a
    # source control management repository.
    local repo=''
    local repoDir=$PWD
    while [[ $repoDir ]]; do
        if [[ -d $repoDir/.hg ]]; then
            # We found a Mercurial repository.
            hgRepo=$(<"$repoDir/.hg/branch")
            repo="(hg:$hgRepo)"
            break
        elif [[ -d $repoDir/.git ]]; then
            # We found a git repository.
            gitRepo=$(<"$repoDir/.git/HEAD")
            repo="(git:${gitRepo##*/})"
            break
        elif [[ -d $repoDir/.svn ]]; then
            # We found an svn repository.
            # TODO: check svn info URL for trunk or branches/{branch} or tags/{branch}
            repo="(svn)"
            break
        fi

        repoDir=${repoDir%/*}
    done

    # Build format string for the left prompt.
    local promptLeft=""
    promptLeft+="[$BCyan%s$Color_Off@"
    promptLeft+="$BCyan%s$Color_Off:"
    promptLeft+="$BCyan%s$Color_Off]"
    promptLeft+=' '
    promptLeft+="$BYellow%s$Color_Off"

    # Build format string for the right prompt.  This requires recalculating the
    # left prompt, without the color escape sequences, so that we can figure out
    # the correct size for the right justification calculation.
    local promptLeftLength="[$USER@$SHORT_HOSTNAME:$TTY] $lpwd"
    local promptRight=""
    promptRight+="$BPurple%$(($COLUMNS-${#promptLeftLength}))s$Color_Off"

    # Print the prompt.
    printf "$promptLeft$promptRight\n> " "$USER" "$SHORT_HOSTNAME" "$TTY" "$lpwd" "$repo"
}

PS1='$(prompt)'

# Don't wait for job termination notification
set -o notify

# Don't use ^D to exit
set -o ignoreeof

export ANT_HOME=~/apache-ant-1.9.7
export AWS_CLI_HOME=/usr/local/Cellar/awscli/1.14.40
export CASSANDRA_HOME=~/apache-cassandra-2.2.8
export FINDBUGS_HOME=~/findbugs-1.3.9
export GRADLE_HOME=~/gradle-3.2
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export MAVEN_HOME=~/apache-maven-3.3.9
export MAVEN_OPTS='-Xmx1G'
export MONGO_HOME=~/mongodb-osx-x86_64-3.0.14-1-g8abafec
export POSTGRES_HOME=/usr/local/Cellar/postgresql94/9.4.9_1
export PROTOC_HOME=~/protobuf-2.5.0
export REDIS_HOME=~/redis-3.2.5
export SCALA_HOME=~/scala-2.12.0
export TERRAFORM_HOME=~/terraform_0.11.2_darwin_amd64

export PATH=$ANT_HOME/bin:$AWS_CLI_HOME/bin:$CASSANDRA_HOME/bin:$GRADLE_HOME/bin:$MAVEN_HOME/bin:$MONGO_HOME/bin:$POSTGRES_HOME/bin:$PROTOC_HOME/src:$REDIS_HOME/src:$SCALA_HOME/bin:$TERRAFORM_HOME:$PATH:~/um-scripts:~/gp-scripts

# complete -C aws_completer aws

alias cp='cp -i'

if [[ $OSTYPE == *cygwin* ]]; then
    # My Cygwin installation uses slightly different options for ls.
    alias ls='ls -hF --color'
else
    alias ls='ls -hF -G'
fi

alias awk=/usr/bin/awk
alias dir='ls -G --format=vertical'
alias grep='grep --color'
alias l='ls -CF'
alias la='ls -A'
alias less='less -r'
alias ll='ls -l'
alias mv='mv -i'
alias rm='rm -i'
alias vdir='ls -G --format=long'

alias hjl='humanize-json-logs.py'
alias rhop='redis-sentinel-hop.sh'

if [[ $OSTYPE == *cygwin* ]]; then
    # Windows-specific alias for jumping to the C drive.
    alias c:='cd /cygdrive/c'
fi

#if [[ $OSTYPE == *darwin* ]]; then
#    # My Mac has Maven 3.0.3 as the default, but I need 2.2.1 by default.
#    export MAVEN_HOME=/usr/share/java/maven-2.2.1
#    alias mvn="$MAVEN_HOME/bin/mvn"
#    alias p4='~/Downloads/p4'
#    alias octave='/Applications/Octave.app/Contents/Resources/bin/octave'
#fi

# Given a timestamp represented as seconds since epoch, convert it to ISO 8601
# format.  The timestamp is interpreted in the system time zone.  The function
# also accepts an optional argument that overrides the system time zone by
# setting TZ.
#
# Unfortunately, the date utility is not standardized across platforms, so we
# need to detect GNU vs. BSD and call the command correctly.
function timestamp_seconds_to_datetime {
  local ts=$1
  local tz=$2
  if [[ $(uname -s) == Linux ]]; then
    eval "$tz date -d @$ts '+%Y-%m-%dT%H:%M:%S+%z'"
  else
    eval "$tz date -j -f %s $ts '+%Y-%m-%dT%H:%M:%S%z'"
  fi
}

function title() {
    echo -ne "\033]0;$*\007"
}

# Reads from each line of stdin a single timestamp represented as seconds since
# epoch and for each one returns a single line consisting of the input
# timestamp, the date/time in the local time zone, and the date/time in UTC.
# Each field is delimited by a space, and each date/time is in ISO 8601 format.
function ts() {
  local localtz
  localtz=${1:+"TZ=$1"}
  while read -r ts; do
    local localdt
    localdt=$(timestamp_seconds_to_datetime "$ts" "$localtz")
    local utcdt
    utcdt=$(timestamp_seconds_to_datetime "$ts" 'TZ=UTC')
    echo "$ts $localdt $utcdt"
  done
}

       # BASH_SUBSHELL
       #        Incremented by one each time a subshell or subshell  environment
       #        is spawned.  The initial value is 0.

       # HISTCMD
       #        The history number, or index in the history list, of the current
       #        command.  If HISTCMD is unset, it loses its special  properties,
       #        even if it is subsequently reset.

       # SECONDS
       #        Each time this parameter is referenced, the  number  of  seconds
       #        since  shell  invocation is returned.  If a value is assigned to
       #        SECONDS, the value returned upon subsequent  references  is  the
       #        number  of seconds since the assignment plus the value assigned.
       #        If SECONDS is unset, it loses its special properties, even if it
       #        is subsequently reset.

       # SHLVL  Incremented by one each time an instance of bash is started.

       # HOSTFILE
       #        Contains  the  name  of  a file in the same format as /etc/hosts
       #        that should be read when the shell needs to complete a hostname.
       #        The  list  of possible hostname completions may be changed while
       #        the shell is running;  the  next  time  hostname  completion  is
       #        attempted  after the value is changed, bash adds the contents of
       #        the new file to the existing list.  If HOSTFILE is set, but  has
       #        no value, bash attempts to read /etc/hosts to obtain the list of
       #        possible hostname completions.   When  HOSTFILE  is  unset,  the
       #        hostname list is cleared.

       # /dev

       # TIMEFORMAT
       #        The  value of this parameter is used as a format string specify-
       #        ing how the timing information for pipelines prefixed  with  the
       #        time  reserved word should be displayed.  The % character intro-
       #        duces an escape sequence that is expanded to  a  time  value  or
       #        other  information.  The escape sequences and their meanings are
       #        as follows; the braces denote optional portions.
       #        %%        A literal %.
       #        %[p][l]R  The elapsed time in seconds.
       #        %[p][l]U  The number of CPU seconds spent in user mode.
       #        %[p][l]S  The number of CPU seconds spent in system mode.
       #        %P        The CPU percentage, computed as (%U + %S) / %R.

       #        The optional p is a digit specifying the precision,  the  number
       #        of fractional digits after a decimal point.  A value of 0 causes
       #        no decimal point or fraction to be output.  At most three places
       #        after  the  decimal  point may be specified; values of p greater
       #        than 3 are changed to 3.  If p is not specified, the value 3  is
       #        used.

       #        The  optional l specifies a longer format, including minutes, of
       #        the form MMmSS.FFs.  The value of p determines  whether  or  not
       #        the fraction is included.

       #        If  this  variable  is not set, bash acts as if it had the value
       #        $'\nreal\t%3lR\nuser\t%3lU\nsys%3lS'.  If the value is null,  no
       #        timing  information  is  displayed.  A trailing newline is added
       #        when the format string is displayed.

# traps
# umask

   # Readline Key Bindings

   # Readline Variables

       # The shell allows control over which commands are saved on  the  history
       # list.  The HISTCONTROL and HISTIGNORE variables may be set to cause the
       # shell to save only a subset of the commands entered.  The cmdhist shell
       # option,  if enabled, causes the shell to attempt to save each line of a
       # multi-line command in the same history entry, adding  semicolons  where
       # necessary  to preserve syntactic correctness.  The lithist shell option
       # causes the shell to save the command with embedded newlines instead  of
       # semicolons.  See the description of the shopt builtin below under SHELL
       # BUILTIN  COMMANDS  for  information  on  setting  and  unsetting  shell
       # options.

       # Several shell options settable with the shopt builtin may  be  used  to
       # tailor  the  behavior  of  history  expansion.  If the histverify shell
       # option is enabled (see the description of the shopt builtin), and read-
       # line is being used, history substitutions are not immediately passed to
       # the shell parser.  Instead, the expanded  line  is  reloaded  into  the
       # readline editing buffer for further modification.  If readline is being
       # used, and the histreedit shell option is enabled, a failed history sub-
       # stitution will be reloaded into the readline editing buffer for correc-
       # tion.  The -p option to the history builtin command may be used to  see
       # what a history expansion will do before using it.  The -s option to the
       # history builtin may be used to add commands to the end of  the  history
       # list  without  actually  executing them, so that they are available for
       # subsequent recall.

              # cdspell If set, minor errors in the spelling of a directory com-
              #         ponent  in  a  cd command will be corrected.  The errors
              #         checked for are transposed characters, a missing charac-
              #         ter,  and  one  character  too many.  If a correction is
              #         found, the corrected file name is printed, and the  com-
              #         mand  proceeds.  This option is only used by interactive
              #         shells.

              # hostcomplete
              #         If set, and readline is being used, bash will attempt to
              #         perform  hostname  completion when a word containing a @
              #         is  being  completed  (see  Completing  under   READLINE
              #         above).  This is enabled by default.

       # trap [-lp] [[arg] sigspec ...]
