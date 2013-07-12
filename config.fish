# Seeking help?
# - Tutorial -> http://fishshell.com/tutorial.html
# - Docs -> http://fishshell.com/docs/current/
# - Manuals -> man (shell), help (browser)
# - IRC -> #fish on irc.oftc.net or irc.freenode.net
#
# Notes:
# - all variables in fish are really lists
#   so you can iterate over them with a for loop
#   e.g. for val in $PATH
#          echo $val
#        end
# - a list cannot contain other lists
# - a variable is a list of strings
# - you can append (or prepend) to a list
#   e.g. set PATH $PATH /usr/local/bin (which is like PATH += /usr/local/bin)
#   note: if you want to permanently add to your $PATH, use this instead:
#           set -U fish_user_paths $fish_user_paths /usr/local/bin
#         or directly in config.fish (universal variables preffered):
#           set -x PATH $PATH /urs/local/bin
# - access elements using bracket notation
#   e.g. $PATH[1] -> first element
#        $argv[-1] -> last element
# - access ranges of elements using slices (also works starting from -1)
#   e.g. $PATH[1..2] -> first and second element
# - more on lists: http://fishshell.com/tutorial.html#tut_lists
# - command substitution uses the output of a command as input to another
#   (doesn't work in double quotes, you can temporarily close quotes and reopen)
#   e.g. >  echo In (pwd), running (uname)
#        In /home/dennis, running Linux
# - && = and, || = or
#   e.g. cp file1 file1.bak; and echo "Backup successful"; or echo "Backup failed"
#
# Tips:
# - you can configure fish via the browser, fish_config
# - use alt+up (instead of !$) to get last part of previous command
#   - note: doesn't work if you hit up first
# - use alt+left and alt+right to skip words in the prompt
# - use alt+left and alt+right to navigate directory history if prompt is empty
# - use math for calculations
# - use open to open a file in its default application

set fish_greeting # Clear greeting

# Show ANSI colour sequences in less when viewing man pages.
set -x LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
set -x LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
set -x LESS_TERMCAP_me \e'[0m'           # end mode
set -x LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -x LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
set -x LESS_TERMCAP_ue \e'[0m'           # end underline
set -x LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# Install hub for github if we don't have it yet.
begin # Create a block scope so variables created exist only in this scope.
  if test (uname) = Linux
    if test (which hub) != /home/(whoami)/bin/hub
      read -l -p "echo 'Install hub? [Y/n] '" input
      switch $input
        case '' 'y' 'Y'
          curl http://github.github.com/hub/standalone -sLo ~/bin/hub
          chmod +x ~/bin/hub
          hub version
        case '*'
          echo 'Aborting hub installation'
      end
    end
  else
    echo 'Follow the instructions at https://github.com/github/hub to install hub'
  end
end

##########
# Aliases 
##########
# A list of some useful (and not so useful) aliases.
# If an alias requires special usage (e.g. an argument) it will say so in the
# comments. Otherwise assume that the alias requires no arguments.

alias alert 'notify-send --urgency=low --icon=(test $status = 0; and echo terminal; or echo error)'
# An "alert" for long running commands. Icon is determined by exit status.
# E.g. sleep 10; alert title message

alias mp 'mplayer -really-quiet -playlist' # For playing a playlist.

alias ... 'cd ../..'

alias addgpl 'wget -q http://www.gnu.org/licenses/gpl.txt -O LICENSE'

alias addcrapl 'wget -q http://matt.might.net/articles/crapl/CRAPL-LICENSE.txt -O LICENSE'

alias clr 'echo "BAD DENNIS! Use ctrl+L"'

alias cls 'clear; and ls'

alias distro 'cat /etc/os-release | head --lines=2'
# 'lsb_release -rd' also works but doesn't contain the distro's codename.

#alias grep grep --colour' # TODO

#alias rgrep rgrep --colour' # TODO

alias ipconfig ifconfig

alias l 'ls -rt' 

#alias la ls -A'

#alias ll ls -l'

#alias ls ls --color=auto'

#alias lsg ls | grep'

#alias lsp ls -1 /var/log/packages/ > package-list'

alias lsd 'ls -d */' # List all directories in current directory.

alias nano 'nano --const' # Constantly show the cursor position in nano.

alias sandcastle 'ssh di07ty@sandcastle.cosc.brocku.ca'

alias temp 'sensors 2>/dev/null'

alias ins 'sudo apt-get install'

alias install 'sudo apt-get install'

alias upd 'sudo apt-get update'

alias update 'sudo apt-get update'

alias upg 'sudo apt-get upgrade'

alias upgrade 'sudo apt-get upgrade'

alias rem 'sudo apt-get remove' # Removes the package.

alias remove 'sudo apt-get remove' # Removes the package.

alias purge 'sudo apt-get purge' # Removes the package and its configuration files.

alias rep 'sudo add-apt-repository' # Add a new PPA to the repository.

alias repository 'sudo add-apt-repository'

alias web 'links2 -g -download-dir ~/Downloads/ www.google.com'
# Browse the web in a basic browser.

alias bookmarks 'eval $EDITOR /home/dennis/.gtk-bookmarks'
# Opens the file with your bookmarked directories.

alias md5 md5sum

alias cman 'man 3' # Manual pages from the library section.

alias disk 'df --human-readable --total --print-type' # Disk space + file system type.

alias show-ram 'free --human' # RAM usage in human-readable form.

alias java-decompiler '/usr/local/bin/jd-gui'

alias t 'python ~/.t/t.py --task-dir ~/tasks --list tasks'

alias update-di07ty 'scp index.html di07ty@sandcastle.cosc.brocku.ca:public_html/'

alias pngcrush 'pngcrush -rem alla -reduce -brute'
# pngcrush is best used when the options are optimized for the image.
# For something easier, try an online tool like http://kraken.io.

alias mac 'ifconfig | grep HWaddr | awk \'{print $1 " " $5}\''
# Shows the MAC address of your network devices.

alias convertvideo 'mencoder -oac mp3lame -ovc lavc -o'
# example: convertvideo video.ogg output.avi

alias minecraft 'java -Xmx1024M -Xms512M -cp ~/games/minecraft.jar net.minecraft.LauncherFrame'

alias dirsize 'du -ch | grep total | cut -f 1'
# Total size of the current directory (human readable)

alias size 'du --human-readable'
# Human readable size of the file/directory you pass it.

alias units 'units --verbose'
# Converts units (e.g. kg to lbs).

alias pinknoise 'play -t sl -r48000 -c2 - synth -1 pinknoise tremolo .1 40 <  /dev/zero'

alias whitenoise 'cat /dev/urandom | aplay -f cd'

alias snipe 'ps xw | grep --ignore-case'
# Handy for finding a process (e.g. when it's unresponsive).

alias external_ip 'curl ifconfig.me'

alias eth0ip "/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print \"eth: \" \$1}'"
# Shows your wired IP address.

alias wlan0ip "/sbin/ifconfig wlan0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print \"wlan: \" \$1}'"
# Shows your wireless IP address.

alias serve 'eth0ip; and wlan0ip; and python -m SimpleHTTPServer'
# Serves current directory on local network, port 8000.

alias broadcast 'echo "Client can watch your terminal live with \'nc your_ip 5000\'."; and script -qf | tee >(nc -l -p 5000)'
# Streams your terminal for others to view.
# Warning: NOT YET TESTED. Do not use for pair programming!
# Note: Supposedly to broadcast over UDP on port 5000, use:
#       script -qf >(nc -ub 192.168.1.255 5000)

alias imagify 'jp2a --colors'
# Displays a JPEG image as coloured ASCII in stdout.
# Also check out picture-tube which is for PNGs.
# Usage: imagify file1, file2, ...

alias vi 'vi -O'
# Vertical-split windows if multiple files given.
# Usage: vi file1, file2, ...

alias combineimgs 'convert +append'
# Combines images horizontally (side-by-side).
# Usage: combineimgs infile1, infile2, ..., outfile

alias combinepdfs 'convert -density 200'
# Combines PDFs vertically.
# Usage: combinepdfs infile1, infile2, ..., outfile
# Alternatives: pdfunite, pdftk

alias spaces2tabs "sed -i 's/ \+ /\t/g'"
# Replaces multiple spaces with a tab.
# Usage: spaces2tabs textfile

alias chromecache 'cd ~/.cache/google-chrome/Default/Cache/; and file (ls -rt | tail)'
# Brings you to Chrome's cache directory and shows filetypes for recent files.

alias showpkg 'apt-cache showpkg'
# Shows some general information for a single package.
# Usage: showpkg package_name

alias search 'apt-cache search'
# Searches the package list for a regex pattern.
# Usage: search some_pattern

alias copysshkey "xclip -sel clip < ~/.ssh/id_rsa.pub; and echo 'copied to cliboard'"
# Copies your ssh key to your clipboard.

alias rmiv 'rm -iv' # Prompt before clobbering and be verbose.
alias cpiv 'cp -iv'
alias mviv 'mv -iv'

alias kernelversion "uname -mrs"
# Shows the Linux kernel version (e.g. Linux 3.2.0-38-generic x86_64)

alias restartshell 'eval exec $SHELL'
# Restarts the shell so new changes can take effect.

alias difference 'grep --fixed-strings --line-regexp --invert-match --file'
# Shows the difference between two text files, one item per line.
# Usage: difference file1 file2
# Notes:
#   Shorthand: grep -Fxvf
#   Alternative: comm -13 <(sort file1) <(sort file2)
#   Alternative: diff file1 file2 | grep '>'

alias bitch, sudo
# Sometimes your computer doesn't obey unless you threaten it.

alias copy 'xclip -selection clip <'
# Copies the contents of a text file to your clipboard.
# Assumes you're running X.
# Usage: copy file

#alias node 'env NODE_NO_READLINE=1 rlwrap -pGreen -S ">>> " node'
# Get history from previous node REPLs and use a better prompt, at the expense
# of losing coloured output and variable autocompletion.

alias du 'du --total --human-readable --max-depth=1'
# Show the size of all items in current directory (and not any lower).
# Shorthand: du -chd 1

alias which 'which -a'
# Show all matches.

alias symlink 'ln -s'
# Create a symbolic link between files. Useful for large files.
# Usage: symlink file.txt pointer-to-file.txt

alias rcp 'rsync -apz'
# A better secure copy for remote and local. Faster and more efficient than scp.
# Preserve files, keep permissions, and compress during transfer.
# Example usage: rcp junk.txt aws:~/

### Git aliases (some from @holman)
alias gl 'git log --oneline --decorate' # Also shows tags!
alias glog "git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp 'git push origin HEAD'
alias gd 'git diff'
alias gc 'git commit'
alias gcm 'git commit -m'
alias gca 'git commit -a'
alias gcam 'git commit -am'
alias gco 'git checkout'
alias gb 'git branch'
alias gs 'git status -sb' # Upgrade your git if -sb breaks for you.
alias ga 'git add'
alias gu 'git add -u'
#alias grm "git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias grm "gs | grep ' D ' | sed 's/^ D //' | xargs git rm" # Holman's version doesn't handle whitespaces.
alias git hub # Git wrapper. See http://defunkt.io/hub/
alias ggrep 'git grep --line-number --heading --break --show-function' # greps files tracked with git.
alias gcb "gb | grep \* | sed 's/^* //'" # Show git's current branch.
alias gup 'git fetch; and git rebase --preserve-merges origin/(gcb)' # A friendlier git pull --rebase.
