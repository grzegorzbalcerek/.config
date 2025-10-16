# cp .profile $HOME/.profile
# cp $HOME/.config/misc/.profile $HOME/.profile

export EDITOR=vim
export OPENGNT_BASE_TEXT="$HOME/gh/OpenGNT/OpenGNT_version3_3.csv"
export PATH=".:"$PATH:"/c/helm:/c/Program Files/Mozilla Firefox:/c/Program Files/LibreOffice/program:/c/Program Files/Emacs/emacs-29.1/bin"
export PYTHONIOENCODING=utf8
export VIMINIT="source $HOME/.config/vim/vimrc"

alias cdd="cd $HOME/doc"
alias cdD="cd $HOME/Downloads"
alias cdde="cd $HOME/doc/emacs"
alias cddr="cd $HOME/doc/rbs"
alias cddrc="cd $HOME/doc/rbs/cov26"
alias cdg="cd $HOME/gh"
alias cdh="cd $HOME"
alias cdl="cd $HOME/lib"
alias cdr="cd $HOME/rep"
alias cdrr="cd $HOME/rep/rbs"
alias cdrra="cd $HOME/rep/rbs/app"
alias cdrro="cd $HOME/rep/rbs/ognt"

alias g=git
alias python=python3

rok() {
    test -n "$1" || { echo "needed 1 argument"; return; }
    convert -size 420x594 caption:$1 deleteme.png
    img2pdf --output $1.pdf -S A4 deleteme.png
    rm -f deleteme.png
}

skana4pdf() {
    test -n "$1" || { echo "needed 1 argument"; return; }
    (scanimage | convert - $1.jpg); img2pdf --pagesize A4 --output $1.pdf $1.jpg; rm -f $1.jpg
}

skana4jpg() {
    test -n "$1" || { echo "needed 1 argument"; return; }
    scanimage | convert - $1.jpg
}

skana5pdf() {
    test -n "$1" || { echo "needed 1 argument"; return; }
    (scanimage -x 148mm -y 210mm | convert - $1.jpg); img2pdf --pagesize A5 --output $1.pdf $1.jpg; rm -f $1.jpg
}

skana6pdf() {
    test -n "$1" || { echo "needed 1 argument"; return; }
    (scanimage -x 105mm -y 148mm | convert - $1.jpg); img2pdf --pagesize A6 --output $1.pdf $1.jpg; rm -f $1.jpg
}

# rep.status: status of repositories
reps() {
    find * -type d -name .git | sed -e 's|/.git||' | while read F
    do
      (
      cd $F
      echo ========== $F ==========
      git status -s
      )
    done
}

# rep.dot.out: move .git out of repositores
repdo() {
    find * -type d -name .git | while read F
    do
      echo mv -n $F X$(echo $F|sed 's|/|@|g')
    done
}

# rep.dot.in: move .git to repositores
repdi() {
    find * -type d -name '*@.git' | while read F
    do
      echo mv -n $F $(echo $F | sed 's/^.//' | sed 's|@|/|g')
    done
}

