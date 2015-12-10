
alias mate='subl'
alias gsu='git submodule sync && git submodule update --init --recursive'

function PR() {
    BRANCH=`git rev-parse --abbrev-ref HEAD`
    git pull-request -b mindsnacks:$1 -h mindsnacks:$BRANCH
}

function gpush()
{
    branch=$(git branch | grep "*" | cut -d " " -f2)
    echo "git push origin $branch"
    git push origin $branch
}

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function parse_git_tag () {
  git describe --tags 2> /dev/null
}

function parse_git_branch_or_tag() {
  local OUT="$(parse_git_branch)"
  if [ "$OUT" == " ((no branch))" ]; then
    OUT="($(parse_git_tag))";
  fi
  echo $OUT
}

PS1="\[\033[1;31m\]\$(parse_git_branch_or_tag)\[\033[0m\]\W:/> "