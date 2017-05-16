#curl -L http://git.io/vB5Sa | bash
#bash <(curl -L http://git.io/vB5Sa)
curl -L https://github.com/raghavgautam/init/archive/master.zip -o /tmp/`whoami`.zip
unzip -o -d /tmp/`whoami`/ /tmp/`whoami`.zip
chmod -R 777 /tmp/`whoami`/
mkdir ~/.emacs.d/
rm -rf ~/.emacs.d/lisp
mv /tmp/`whoami`/init-master/* /tmp/`whoami`/init-master/.[^.]* ~/.emacs.d/
~/.emacs.d/setup.sh

#install packages
PKGS=(emacs screen tree git tmux)
if ( sudo -v ); then
    if hash yum 2>/dev/null; then
        for p in "${PKGS[@]}"; do sudo yum -y install "$p"; done
    elif hash apt-get 2>/dev/null; then
        for p in "${PKGS[@]}"; do sudo apt-get -y install "$p"; done
    elif hash zypper 2>/dev/null; then
        if [ -f "/etc/SuSE-release" ]; then
            sudo zypper --non-interactive addrepo http://download.opensuse.org/distribution/11.4/repo/oss/ oss
        fi
        for p in "${PKGS[@]}"; do sudo zypper --non-interactive --no-gpg-checks -n install "$p"; done
    else
        echo "unknown package manager"
    fi
else
    echo "not installing anything"
fi
