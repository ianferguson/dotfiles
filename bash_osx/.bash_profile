# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend
export PATH="$HOME/.bin:$PATH"
export workspace="$HOME/opower"
export PATH="/usr/local/bin:$PATH"
export GITHUB_HOST=github.va.opower.it
export POSE_USER=ian.ferguson
export GIT_USER=ian-ferguson
source "$workspace/opower.bash/opower.bash"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
export PATH="/usr/local/mysql/bin:$PATH"
