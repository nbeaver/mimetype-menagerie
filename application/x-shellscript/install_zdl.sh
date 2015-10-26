#!/bin/bash -i

DIR="$PWD"
path_usr="/usr/local/share/zdl"
path_tmp=".zdl_tmp"

PROG=ZigzagDownLoader
name_prog=ZigzagDownLoader
prog=zdl
BIN="/usr/local/bin"
SHARE="/usr/local/share/zdl"
URL_ROOT="http://download.savannah.gnu.org/releases/zdl/"
cygaxel_url="http://www.inventati.org/zoninoz/html/upload/files/axel-2.4-1.tar.bz2" #http://fd0.x0.to/cygwin/release/axel/axel-2.4-1bl1.tar.bz2
success="Installazione completata"
failure="Installazione non riuscita"
path_conf="$HOME/.$prog"
file_conf="$path_conf/$prog.conf"

if [[ -z "$(grep 'shopt -s checkwinsize' $HOME/.bashrc)" ]]
then
    echo "shopt -s checkwinsize" >> ~/.bashrc 
fi

mkdir -p "$path_conf/extensions"

if [ ! -f "$file_conf" ]
then
    echo "# ZigzagDownLoader configuration file" > "$file_conf"
fi

if [ -e /cygdrive ]
then
    win_home=$(cygpath -u "$HOMEDRIVE$HOMEPATH")
    win_progfiles=$(cygpath -u "$PROGRAMFILES")
fi
cygdrive=$(realpath /cygdrive/?/cygwin 2>/dev/null)
[ -z "$cygdrive" ] && cygdrive=$(realpath /cygdrive/?/Cygwin 2>/dev/null)
cygdrive="${cygdrive#*cygdrive\/}"
cygdrive="${cygdrive%%\/*}"
[ -z "$cygdrive" ] && cygdrive="C"



## funzioni per Cygwin
function get-mirror {
    mirror=$(grep 'last-mirror' /etc/setup/setup.rc -A 1 | tail -n1)
}

function pkt-download {
    cscript /nologo downloader_tmp.js $1 $2 2>/dev/null
}

function last-pkt {
    path_pkt=$(grep "\@ $1$" -A 15 <<< "$setup"| grep install |head -n1 | awk '{print $2}')
    echo ${path_pkt##*\/}
}

function init {
    get-mirror
    pkt-download $mirror/x86/setup.bz2 setup.bz2
    setup=$(bzcat setup.bz2)
    unset pkts
}

function cygwinports {
    mirror=ftp://ftp.cygwinports.org/pub/cygwinports
    wget $mirror/x86/setup.bz2
    setup=$(bzcat setup.bz2)
    unset pkts
}

function required-pkt {
    if [[ ! "${pkts[*]}" =~ $1 ]]
    then 
	pkts[${#pkts[*]}]="$1"
    fi

    dep_pkt=$(grep "\@ $1$" -A 15 <<< "$setup"| grep requires |head -n1)
    for p in ${dep_pkt#* }
    do
	if [ ! -f /etc/setup/$p.lst.gz ]
	then
	    required-pkt $p
	fi
    done
}

## Axel - Cygwin
function install_axel-cygwin {
    test_axel=`command -v axel`
    if [ -z $test_axel ]; then
	cd /
	wget "$cygaxel_url"
	tar -xvjf "${cygaxel_url##*'/'}"
	cd -
    fi
}

##############


function bold {
    echo -e "\e[1m$1\e[0m"
}


#### Axel

function check_downloader {
    while [ -z "`command -v axel 2>/dev/null`" ]
    do
	bold "ATTENZIONE: Axel non è installato nel tuo sistema"
	
	echo -e "$PROG può scaricare con Wget ma raccomanda fortemente Axel, perché:\n
	- può accelerare sensibilmente il download
	- permette il recupero dei download in caso di interruzione
	
Per ulteriori informazioni su Axel: http://alioth.debian.org/projects/axel/

1) Installa automaticamente Axel da pacchetti
2) Installa automaticamente Axel da sorgenti
3) Esci da $PROG per installare Axel manualmente (puoi trovarlo qui: http://pkgs.org/search/?keyword=axel)"

	bold "Scegli cosa fare (1-3)"
	read input
	
	case $input in
	    
	    1) install_pk ;;
	    2) install_src ;;
	    3) exit ;;
	    
	esac
    done
}

function install_test {
    if [[ ! $(command -v axel 2>/dev/null) ]]
    then
	bold "Installazione automatica non riuscita"
	case $1 in
	    pk) echo "$2 non ha trovato il pacchetto di Axel" ;;
	    src) echo "Errori nella compilazione o nell'installazione";;
	esac
    fi
    echo
    bold "<Premi un INVIO per continuare>"
    read
}

function install_pk {
    echo "Installo Axel ..."
    if [[ $(command -v apt-get 2>/dev/null) ]]
    then
	DEBIAN_FRONTEND=noninteractive sudo apt-get --no-install-recommends -q -y install axel || (  echo "Digita la password di root" ; DEBIAN_FRONTEND=noninteractive su -c "apt-get --no-install-recommends -q -y install axel" )
	install_test pk apt-get

    elif [[ $(command -v yum 2>/dev/null) ]]
    then
	sudo yum install axel || ( echo "Digita la password di root" ; su -c "yum install axel" )
	install_test pk yum

    elif [[ $(command -v pacman 2>/dev/null) ]]
    then
	sudo pacman -S axel 2>/dev/null || ( echo "Digita la password di root" ; su -c "pacman -S axel" )
	install_test pk pacman
    else
	install_test
    fi
}

function install_src {
    cd /usr/src
    wget https://alioth.debian.org/frs/download.php/file/3015/axel-2.4.tar.gz

    tar -xzvf axel-2.4.tar.gz
    cd axel-2.4
    
    make
    sudo make install || ( echo "Digita la password di root" ; su -c "make install" )
    make clean
    install_test src
    cd -
}


## Xterm
function check_xterm {
    while [ -z "`command -v xterm 2>/dev/null`" ]
    do
	bold "ATTENZIONE: XTerm non è installato nel tuo sistema"
	
	echo -e "$name_prog utilizza XTerm se avviato da un'applicazione grafica come Firefox/Iceweasel/Icecat (tramite Flashgot), Chrome/Chromium (attraverso Download Assistant o Simple Get), XXXTerm/Xombrero e Conkeror:

1) Installa automaticamente XTerm da pacchetti
2) Installa automaticamente XTerm da sorgenti
3) Esci da $name_prog per installare Xterm manualmente (puoi trovarlo qui: http://pkgs.org/search/?keyword=xterm)"

	bold "Scegli cosa fare (1-3)"
	read input
	
	case $input in
	    1) install_pk_xterm ;;
	    2) install_src_xterm ;;
	    3) exit ;;
	esac
    done
}

function install_test_xterm {
    if [[ ! $(command -v xterm 2>/dev/null) ]]
    then
	bold "Installazione automatica non riuscita"
	case $1 in
	    pk) echo "$2 non ha trovato il pacchetto di XTerm" ;;
	    src) echo "Errori nella compilazione o nell'installazione";;
	esac
    fi
    echo
    bold "<Premi un INVIO per continuare>"
    read
}

function install_pk_xterm {
    echo "Installo XTerm ..."

    if [[ $(command -v apt-get 2>/dev/null) ]]
    then
	DEBIAN_FRONTEND=noninteractive sudo apt-get --no-install-recommends -q -y install xterm || (  echo "Digita la password di root" ; DEBIAN_FRONTEND=noninteractive su -c "apt-get --no-install-recommends -q -y install xterm" )
	install_test_xterm pk apt-get
	
    elif [[ $(command -v yum 2>/dev/null) ]]
    then
	sudo yum install xterm || ( echo "Digita la password di root" ; su -c "yum install xterm" )
	install_test_xterm pk yum

    elif [[ $(command -v pacman 2>/dev/null) ]]
    then
	sudo pacman -S xterm 2>/dev/null || ( echo "Digita la password di root" ; su -c "pacman -S xterm" )
	install_test_xterm pk pacman
	
    else
	install_test_xterm
    fi
}

function install_src_xterm {
    cd /usr/src
    wget http://invisible-island.net/datafiles/release/xterm.tar.gz

    tar -xzvf xterm.tar.gz
    cd xterm-300
    
    make
    sudo make install || ( echo "Digita la password di root" ; su -c "make install" )
    make clean
    install_test_xterm src
    cd -
}


echo "Installazione di ZigzagDownLoader (ZDL)"

mkdir -p "$path_conf/src"
cd "$path_conf/src"
rm *.tar.gz* $prog -rf

echo "Download in corso: attendere..."

if [ -e /cygdrive ]
then
    cd /tmp

    echo -e 'var WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");
WinHttpReq.Open("GET", WScript.Arguments(0), /*async=*/false);
WinHttpReq.Send();
//WScript.Echo(WinHttpReq.ResponseText);

BinStream = new ActiveXObject("ADODB.Stream");
BinStream.Type = 1;
BinStream.Open();
BinStream.Write(WinHttpReq.ResponseBody);
BinStream.SaveToFile(WScript.Arguments(1));' > downloader_tmp.js 

    if [[ ! $(command -v wget 2>/dev/null) ]] 
    then
	echo -e "
Installazione di Wget
...attendi...

"
	init
	required-pkt wget

	for p in ${pkts[*]}
	do
	    echo "Installing $p..."
	    last-pkt $p
	    tarball=${path_pkt##*\/}
	    pkt-download $mirror/$path_pkt $tarball

	    cd /
	    [ "$tarball" != "${tarball%.xz}" ] && tar -xvJf /tmp/$tarball
	    [ "$tarball" != "${tarball%.bz2}" ] && tar -xvjf /tmp/$tarball
	    cd /tmp
	done

	cd /tmp
	rm -f downloader_tmp.js setup.bz2 *.tar.*
    fi

fi

wget "$URL_ROOT" -r -l 1 -A sig,txt -np -nd -q
wget "http://git.savannah.gnu.org/cgit/zdl.git/snapshot/zdl-1.0.tar.gz" -q 
cp *.sig "$path_conf"/zdl.sig

package=$(ls *.tar.gz)
tar -xzf "$package"

rm -fr "$prog"
mv "${package%.tar.gz}" $prog
cd $prog

chmod +rx -R .

## UPDATER ########
installer="true"

source updater.sh
source ui/widgets.sh
source ui/ui.sh

update
###################

## Axel
if [ -e "/cygdrive" ]
then
    install_axel-cygwin
else
    check_downloader
    [ -n "$(command -v X 2>/dev/null )" ] && check_xterm
fi

cd "$DIR"
rm -fr "$path_conf/src"

bold "$success"
bold "Per informazioni su ZigzagDownLoader (zdl): zdl --help"
exit
