function _update_fonts() {
    if ! osx_detect
    then
        local fontspath="${HOME}/.local/share/fonts"
        fc-cache -frv "$fontspath"
        # Deprecated directory for fonts
        local fontspath="${HOME}/.fonts"
        fc-cache -frv "$fontspath"
    fi
    return 0
}

function _clean_up() {
    if osx_detect
    then
        local fontpath="${HOME}/Library/Fonts"
    else
       local fontpath="${HOME}/.local/share/fonts"
    fi

    local nerdfontspath="${fontpath}/nerd-fonts"
    # Remove existing fonts first
    [[ -e $nerdfontspath ]] && rm -rf "$nerdfontspath"

    local jetbrainsfontpath="${fontpath}/jet-brains-font"
    # Remove existing fonts first
    [[ -e $jetbrainsfontpath ]] && rm -rf "$jetbrainsfontpath"

    return 0
}

function _get_installed_nerd_fonts() {
    info "Currently installed Nerd fonts":
    if osx_detect
    then
        local nerdfontspath="${HOME}/Library/Fonts/nerd-fonts"
        [[ -e $nerdfontspath ]] && ls "$nerdfontspath"
    else
        local nerdfontspath="${HOME}/.local/share/fonts/nerd-fonts"
        # Disable pipefail as this may fail if list of fonts is empty
        set +o pipefail
        fc-list | grep "$nerdfontspath" | cut -d: -f2 | sort -u
        set -o pipefail
    fi

    return 0
}

function _install_nerd_fonts() {
    info "Installing Nerd fonts (https://github.com/ryanoasis/nerd-fonts)..."
    if osx_detect
    then
        local nerdfontspath="${HOME}/Library/Fonts/nerd-fonts"
    else
        local nerdfontspath="${HOME}/.local/share/fonts/nerd-fonts"
    fi

    _get_installed_nerd_fonts

    font_installed=false

    while ask "Do you want to install additional Nerd Fonts?" "N"
    do
        info "For list of all versions: https://github.com/ryanoasis/nerd-fonts/tags"
        local nerdfontsversion=$(input "Which Nerd Fonts version?" "2.0.0")
        info "For list of all available fonts take a look at the assets section here: https://github.com/ryanoasis/nerd-fonts/releases/tag/v$nerdfontsversion"
        local fontname=$(input "Which font would you like to install?" "UbuntuMono")

        local fontpath="$nerdfontspath/$fontname"

        mkdir -p "$fontpath"
        cd "$fontpath"

        download https://github.com/ryanoasis/nerd-fonts/releases/download/v${nerdfontsversion}/$fontname.zip
        unzip -o $fontname.zip
        rm $fontname.zip*

        font_installed=true
        _get_installed_nerd_fonts
    done

    $font_installed && _update_fonts

    return 0
}


function _install_jet_brains_font() {
    info "Installing Jet Brains font (https://www.jetbrains.com/lp/mono/)..."
    if osx_detect
    then
        local fontpath="${HOME}/Library/Fonts/jet-brains-font"
    else
        local fontpath="${HOME}/.local/share/fonts/jet-brains-font"
    fi

    if ask "Do you want to install Jet Brains Font?" "N"
    then
        mkdir -p "$fontpath"
        cd "$fontpath"
        local fontname="JetBrainsMono-1.0.2"

        download https://download.jetbrains.com/fonts/$fontname.zip

        unzip -o $fontname.zip
        rm $fontname.zip*

        _update_fonts
    fi


    return 0
}

function post_install(){
    _install_nerd_fonts
    _install_jet_brains_font

    return 0
}


function post_update(){
    post_install
}


function pre_remove(){
    _clean_up
    _update_fonts

    return 0
}
