#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------
#Color		Texto	Fondo texto
#Black		30	40
#Red		31	41
#Green		32	42
#Yellow		33	43
#Blue		34	44
#Magenta	35	45
#Cyan		36	46
#Light Gray	37	47
#Gray		90	100
#Light Red	91	101
#Light Green	92	102
#Light Yellow	93	103
#Light Blue	94	104
#Light Magenta	95	105
#Light Cyan	96	106
#White		97	107

#Code	Descripción
#0	Reset/Normal
#1	Bold text
#2	Faint text
#3	Italics
#4	Underlined text

#Colores
Black="30"
Red="31"
Green="32"
Yellow="33"
Blue="34"
Magenta="35"
Cyan="36"
LightGray="37"
Gray="90"
LightRed="91"
LightGreen="92"
LightYellow="93"
LightBlue="94"
LightMagenta="95"
LightCyan="96"
White="97"

#Fondos
FBlack="40"
FRed="41"
FGreen="42"
FYellow="43"
FBlue="44"
FMagenta="45"
FCyan="46"
FLightGray="47"
FGray="100"
FLightRed="101"
FLightGreen="102"
FLightYellow="103"
FLightBlue="104"
FLightMagenta="105"
FLightCyan="106"
FWhite="107"

#-------------------------------------------------------------------------
#    Esto cambia los títulos
#
COLOR="${White}"
BGCOLOR="\e[${FBlue}m"
#
#-------------------------------------------------------------------------

#Esto es fijo para los títulos
BOLDCOLOR="\e[1;${COLOR}m"
BACKGROUND="\e[${BGCOLOR}"
ENDCOLOR="\e[0m"

#-------------------------------------------------------------------------
#
#   Esto cambia los colores de las pantallas de carga
#
Colorin="${White}"
ColorDeFondo="\e[${FCyan}m"
#
#-------------------------------------------------------------------------

#-------------------------------------------------------------------------
#   Esto es fijo paracambiar las pantallas de carga
#
ColorNegrita="\e[1;${Colorin}m"
Fondo="\e[${ColorDeFondo}"

#-------------------------------------------------------------------------
#   Esto es el color para el texto que muestra el comando 11
#
Once="\e[1;${Blue}m"
#
#-------------------------------------------------------------------------

#-------------------------------------------------------------------------
#   Esto mete una pausa al añadir "pausa" en el código
#
function pausa(){
read -p "$*"
}
#
#-------------------------------------------------------------------------

menu_choice=""
while [ "$menu_choice" != "17" ]
do
clear
echo
echo -e "${BOLDCOLOR}${BACKGROUND}Por favor, selecciona una opción${ENDCOLOR}"
echo
echo "1.  Instalar imprescindibles" 
echo "2.  Instalar drivers USB"
echo "3.  Instalar Wifite"
echo "4.  Instalar Beautiful Bash"
echo "5.  Instalar Zsh"
echo "6.  Terminar configuración Zsh"
echo "7.  Instalar fuente Hack Nerd Font"
echo
echo -e "${BOLDCOLOR}${BACKGROUND}Repositorios y Administradores de paquetes${ENDCOLOR}"
echo
echo "8.  Instalar YAY (No se puede siendo SU)"
echo "9.  Instalar Pamac (yay)"
echo "10.  Repositorios AUR (No se puede siendo SU)"
echo "11.  Repositorios BlackArch"
echo
echo -e "${BOLDCOLOR}${BACKGROUND}Opciones de personalización de Gnome${ENDCOLOR}"
echo
echo "12. Instalar Gnome Tweak Tool y Firefox (yay)"
echo "13. Extensiones a activar"
echo "14. Instalar Tema Firefox y Fix error Dash To Dock"
echo "15. Video personalización Gnome"
echo
echo -e "${BOLDCOLOR}${BACKGROUND}Opciones de mantenimiento${ENDCOLOR}"
echo
echo "16. Limpiar paquetes huerfanos"
echo "17. Limpiar Gnome"
echo "18. Actualizar sistema y limpiar cache"
echo
echo "19. Salir"
echo

read menu_choice
clear
case $menu_choice in
        1)
            echo -e "${ColorNegrita}${Fondo}Instalando imprescindibles${ENDCOLOR}"
            echo
	    sleep 2
	    cd "${HOME}"
	    mkdir github
            sudo pacman -S git base-devel nano firefox reflector flatpak terminator wget curl p7zip neofetch zoxide --noconfirm
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
	    pausa
            ;;
        2)
            echo -e "${ColorNegrita}${Fondo}Instalando drivers${ENDCOLOR}"
            echo
	    sleep 2            
            sudo pacman -S --noconfirm linux-headers dkms git bc iw
	    cd ~/Documentos/
	    mkdir -p DriversUSB
	    cd ~/Documentos/DriversUSB/
	    git clone https://github.com/morrownr/8821au-20210708.git
	    cd ~/8821au-20210708/
	    sudo dkms add ./8821au-20210708
	    sudo dkms install rtl8821au/5.12.5.2
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        3)
            echo -e "${ColorNegrita}${Fondo}Instalando Wifite y sus complementos${ENDCOLOR}"
            echo
	    sleep 2
            sudo pacman -S hcxtools hcxdumptool reaver macchanger hashcat john cowpatty bully wifite wireshark-cli --noconfirm #falta Pyrit
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
	    pausa
            ;;
        4)
            echo -e "${ColorNegrita}${Fondo}Instalando Beautiful Bash${ENDCOLOR}"
            echo
	    sleep 2
	    cd ${HOME}/github
            git clone https://github.com/christitustech/mybash
	    cd mybash/
            ./setup.sh
	    chsh -s /bin/bash
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        5)
            echo -e "${ColorNegrita}${Fondo}Instalando Zsh${ENDCOLOR}"
            echo
	    sleep 2
	    set -e
	    zshcustom=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
	    p10kdir=${zshcustom}/themes/powerlevel10k
	    fontdir=${HOME}/.local/share/fonts
	    DISTRO=$(grep -E "^NAME" /etc/os-release)
	    DISTRO_NAME=""
	
	    echo
	    echo -e "${ColorNegrita}${Fondo}Installing oh-my-zsh and powerlevel10k in Arch${ENDCOLOR}"
            echo
	   
	    #
	    echo
	    echo -e "${ColorNegrita}${Fondo}Installing tools${ENDCOLOR}"
            echo
	    #
	    sudo pacman -S git vim wget neofetch --noconfirm
	    #
	    #	
	    echo
	    echo -e "${ColorNegrita}${Fondo}Installing zsh${ENDCOLOR}"
            echo
	    sudo pacman -S zsh --noconfirm
	    #
	    echo
	    echo -e "${ColorNegrita}${Fondo}Installing oh-my-zsh${ENDCOLOR}"
            echo

	    if [ -d ${HOME}/.oh-my-zsh ]
	    then
	    echo
	    echo -e "${ColorNegrita}${Fondo}.oh-my-zsh already exist${ENDCOLOR}"
            echo
	    else
	    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	    fi
	    echo "export PATH in .zshrc"
	    sed -i -E 's/^#\s*(export PATH=\$HOME\/bin:\/usr\/local\/bin:\$PATH)$/\1/' ${HOME}/.zshrc
	
	    #
	    echo
	    echo -e "${ColorNegrita}${Fondo}Installing powerlevel10k${ENDCOLOR}"
            echo

	    if [ -d ${p10kdir} ]
	    then
	    echo "the direcotry exists: ${p10kdir}"
	    else
	    echo -e "the direcotry do not exists\ncloning the repository"
	    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${p10kdir}
	    fi
	    echo
	    echo -e "${ColorNegrita}${Fondo}Sdding theme powrlevel10k in .zshrc${ENDCOLOR}"
            echo

	    sed -i -E 's/^ZSH_THEME=.+/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ${HOME}/.zshrc
	    #
	    chsh -s $(which zsh)
	    cd /usr/share/fonts
	    sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
	
	    #Para editar configuración de powerlevel10k --> p10k configure

	    #Para editar configuración --> nano ~/.zshrc
	
	    #sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc
	    #echo 'typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet' >> ~/.zshrc
	    echo 'neofetch' >> ~/.zshrc

            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
  
        6)
            echo -e "${ColorNegrita}${Fondo}Editando configuración ZSH${ENDCOLOR}"
            echo
	    sleep 2
            
	     
 	    git clone https://MRR4bot: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@github.com/MRR4bot/dotfiles.git

            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;

        7)
            echo -e "${ColorNegrita}${Fondo}Instalando Hack Nerd Font${ENDCOLOR}"
            echo
	    sleep 2
            cd
	    cd /usr/share/fonts
	    sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
	    cd /usr/share/fonts
	    sudo unzip Hack.zip
	    sudo rm Hack.zip
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        8)
            echo -e "${ColorNegrita}${Fondo}Instalando YAY${ENDCOLOR}"
            echo
	    sleep 2
	    cd "${HOME}"
            echo "CLOING: YAY"
            git clone "https://aur.archlinux.org/yay.git"
            cd ${HOME}/yay
            makepkg -si --noconfirm
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        9)
            echo -e "${ColorNegrita}${Fondo}Instalando PAMAC${ENDCOLOR}"
            echo
	    sleep 2
            yay -S pamac-aur-git --noconfirm
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        10)
            echo -e "${ColorNegrita}${Fondo}Instalando Repositorios AUR${ENDCOLOR}"
            echo
	    sleep 2
            cd "${HOME}"
	    mkdir repos
	    cd ${HOME}/repos
	    git clone https://aur.archlinux.org/paru-bin.git
	    cd paru-bin/
	    makepkg -si --noconfirm
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        11)
            echo -e "${ColorNegrita}${Fondo}Instalando Repositorios de BlackArch${ENDCOLOR}"
            echo
	    sleep 2
            cd ${HOME}/repos
	    mkdir blackarch
	    cd ${HOME}/repos/blackarch
            curl -O https://blackarch.org/strap.sh
	    chmod +x strap.sh
	    sudo ./strap.sh
	    pacman -Sy
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        12)
            echo -e "${ColorNegrita}${Fondo}Instalando Gnome Tweak Tool Git y Firefox${ENDCOLOR}"
            echo
	    sleep 2
            sudo pacman -S firefox git --noconfirm
	    yay -S gnome-tweak-tool --noconfirm
	    flatpak install flathub com.mattjakeman.ExtensionManager -y
	    cd "${HOME}"
	    cd Descargas/
	    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
	    git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git
	    git clone https://github.com/alvatip/Nordzy-icon.git
            git clone https://github.com/alvatip/Sunity-cursors.git
	    #Descargando recursos
            echo
            echo -e "${ColorNegrita}${Fondo}Descargando recursos${ENDCOLOR}"
            echo
	    sleep 2         
            sudo pacman -S --noconfirm git bc iw
	    cd ~/Descargas/	    
	    git clone https://MRR4bot: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@github.com/MRR4bot/Personalization.git #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	    
	    #Instalando fuentes
            echo
            echo -e "${ColorNegrita}${Fondo}Instalando fuentes${ENDCOLOR}"
            echo
	    sleep 2
	    cd ~/Descargas/Personalization/
	    sudo unzip fonts.zip
            sudo mv fonts ~/.local/share/
            #instalando tema
            echo
            echo -e "${ColorNegrita}${Fondo}Instalando WhiteSur GTK Theme${ENDCOLOR}"
            echo
	    sleep 2
	    cd "${HOME}"
	    cd Descargas/WhiteSur-gtk-theme/
	    ./install.sh -l -c Dark -m -p 60 -P bigger --normal  
            #instalando Nordzy-icon
            echo
            echo -e "${ColorNegrita}${Fondo}Instalando Nordzy Icon${ENDCOLOR}"
            echo
	    sleep 2
	    cd "${HOME}"
	    cd Descargas/Nordzy-icon/
	    ./install.sh -t default -c -p
            #instalando Sunity-cursors
            echo
            echo -e "${ColorNegrita}${Fondo}Instalando Sunity Cursors${ENDCOLOR}"
            echo
	    sleep 2
	    cd "${HOME}"
	    cd Descargas/Sunity-cursors/
	    ./install.sh
            echo
            #instalando wallpapers
            echo -e "${ColorNegrita}${Fondo}Instalando Wallpapers${ENDCOLOR}"
            echo
	    sleep 2
	    cd "${HOME}"
	    cd Descargas/WhiteSur-wallpapers/
	    sudo ./install-gnome-backgrounds.sh
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        13)	
            echo -e "${ColorNegrita}${Fondo}Extensiones que tienes que instalar y activar${ENDCOLOR}"
            echo
	    sleep 2
	    echo -e "${Once}User Themes, AppIndicator and KStatusNotifierItem Suppot, Aylur's Widgets, Blur my Shell, Circular Widgets, Coverflow Alt-Tab, Desktop Cube, Dash to Dock, GSConnect, Just Perfection, Rounded Corners, Rounded Window Corners${ENDCOLOR}"
            echo
	    echo -e "${Once}Ves a Tweaks -> Apariencia -> 1. Sunity-cursosrs 2. Nordzy 3. WhiteSur-Dark y 5. WhiteSur-Dark${ENDCOLOR}"
            echo
	    echo -e "${Once}Ves a Tweaks -> Fuentes -> 1. SF Pro Display Regular tamaño 10 2. SF Pro Display Regular tamaño 10 3. FiraCode Nerd Font tamaño 10  4. SF Pro Display Regular tamaño 11${ENDCOLOR}"
            echo
	    echo -e "${Once}Ves a Tweaks -> Ventana -> Activar los botones de minimizar y tal, también meter lo de nueva ventana centrada${ENDCOLOR}"
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        14)
            echo -e "${ColorNegrita}${Fondo}Instalando Tema Firefox${ENDCOLOR}"
            echo
	    sleep 2
	    cd "${HOME}"
	    cd Descargas/WhiteSur-gtk-theme/
	    ./tweaks.sh -f monterey
            echo
            echo -e "${ColorNegrita}${Fondo}Fixeando Issue Dash to Dock${ENDCOLOR}"
            echo
	    sleep 2
	    sudo ./tweaks.sh -d
            echo
            echo -e "${ColorNegrita}${Fondo}Editando login${ENDCOLOR}"
            echo
	    sleep 2
	    sudo ./tweaks.sh -g -b ~/Descargas/WhiteSur-wallpapers/1080p/WhiteSur-morning.jpg
            echo
            echo -e "${ColorNegrita}${Fondo}Importando configuracion${ENDCOLOR}"
            echo
	    cd ~/Descargas/Personalization/
	    sudo unzip gnome-nord-extensions.zip	    
            dconf load /org/gnome/shell/extensions/ < gnome-nord-extensions.conf
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        15)
            echo -e "${ColorNegrita}${Fondo}Abriendo video${ENDCOLOR}"
            echo
	    sleep 2
	    firefox https://www.youtube.com/watch?v=zOUTasMuZl4
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        16)
            echo -e "${ColorNegrita}${Fondo}Limpiando paquetes huerfanos${ENDCOLOR}"
            echo
	    sleep 2
            sudo pacman -Rns $(pacman -Qtdq) --noconfirm
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        17)
            echo -e "${ColorNegrita}${Fondo}Limpiando Gnome${ENDCOLOR}"
            echo
	    sleep 2
            sudo pacman -Rc quadrapassel gnome-console swell-foop gnome-tetravex lightsoff five-or-more four-in-a-row gnome-chess hitori gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles gnome-sudoku gnome-robots gnome-taquin iagno epiphany polari gnome-recipes tali --noconfirm
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        18)
            echo -e "${ColorNegrita}${Fondo}Actualizando sistema y limpiando cache${ENDCOLOR}"
            echo
	    sleep 2
            sudo pacman -Syu --noconfirm
	    sudo pacman -Sc --noconfirm
            echo
	    echo -e "${BOLDCOLOR}${BACKGROUND}Pulsa [Enter] para continuar...${ENDCOLOR}"
            echo
	    pausa
            ;;
        19)
            echo -e "${ColorNegrita}${Fondo}Chao pescao${ENDCOLOR}"
            echo
	    sleep 2
            clear
	    exit
            ;;
    esac
done


# git clone https://github.com/mlaj10/Bspwm.git
#
#
#
