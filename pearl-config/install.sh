function post_install(){
    info "Installing Awesome terminal fonts..."
    cd "${PEARL_PKGDIR}/awesome-terminal-fonts"
    ./install.sh

    info "Installing Powerline fonts..."
    cd "${PEARL_PKGDIR}/powerline-fonts"
    ./install.sh

    cd ${HOME}/.fonts
    local font

    info "Installing Adobe fonts..."
    [[ -f ${HOME}/.fonts/SourceSansVariable-Italic.ttf ]] || \
        download https://github.com/adobe-fonts/source-sans-pro/releases/download/variable-fonts/SourceSansVariable-Italic.ttf
    [[ -f ${HOME}/.fonts/SourceSansVariable-Roman.ttf ]] || \
        download https://github.com/adobe-fonts/source-sans-pro/releases/download/variable-fonts/SourceSansVariable-Roman.ttf
    [[ -f ${HOME}/.fonts/SourceCodeVariable-Italic.otf ]] || \
        download https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.otf
    [[ -f ${HOME}/.fonts/SourceCodeVariable-Roman.otf ]] || \
        download https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.otf
    [[ -f ${HOME}/.fonts/SourceSerifVariable-Roman.otf ]] || \
        download https://github.com/adobe-fonts/source-serif-pro/releases/download/variable-fonts/SourceSerifVariable-Roman.otf

    info "Installing Cantarell fonts..."
    for font in "Cantarell-Regular" "Cantarell-Bold" "Cantarell-BoldOblique" "Cantarell-Oblique"
    do
        [[ -f ${HOME}/.fonts/$font.ttf ]] || \
            download "https://github.com/google/fonts/blob/master/ofl/cantarell/$font.ttf?raw=true" "$font.ttf"
    done

    info "Installing Ubuntu fonts..."
    for font in "Ubuntu-Bold" "Ubuntu-BoldItalic" "Ubuntu-Italic" "Ubuntu-Light" "Ubuntu-LightItalic" "Ubuntu-Medium" "Ubuntu-MediumItalic" "Ubuntu-Regular"
    do
        [[ -f ${HOME}/.fonts/$font.ttf ]] || \
        download "https://github.com/google/fonts/blob/master/ufl/ubuntu/$font.ttf?raw=true" "$font.ttf"
    done

    font="UbuntuCondensed-Regular"
    [[ -f ${HOME}/.fonts/$font.ttf ]] || \
        download "https://github.com/google/fonts/blob/master/ufl/ubuntucondensed/$font.ttf?raw=true" "$font.ttf"

    for font in "UbuntuMono-Bold" "UbuntuMono-BoldItalic" "UbuntuMono-Italic" "UbuntuMono-Regular"
    do
        [[ -f ${HOME}/.fonts/$font.ttf ]] || \
            download "https://github.com/google/fonts/blob/master/ufl/ubuntumono/$font.ttf?raw=true" "$font.ttf"
    done

    fc-cache -f ${HOME}/.fonts

    return 0
}

function post_update(){
    post_install
}

function pre_remove(){
    # PATH needs to be updated since GNU Findutils is required in OSX
    # environments.
    GNUBIN_FINDUTILS="/usr/local/opt/findutils/libexec/gnubin"
    [ -d "$GNUBIN_FINDUTILS" ] && PATH="$GNUBIN_FINDUTILS:$PATH"

    if [[ $(uname) == 'Darwin' ]]; then
        local fonts_path=${HOME}/Library/Fonts
    else
        local fonts_path=${HOME}/.local/share/fonts
    fi

    info "Removing Awesome terminal fonts..."
    find "${PEARL_PKGDIR}/awesome-terminal-fonts/build" \( -name '*.ttf' -or -name '*.sh' \) -type f -printf "%f\0" | \
        xargs -0 -I {}  rm -f ${HOME}/.fonts/{}
    find "${PEARL_PKGDIR}/awesome-terminal-fonts/config" -name '*.conf' -printf "%f\0" | \
        xargs -0 -I {}  rm -f ${HOME}/.config/fontconfig/conf.d/{}

    info "Removing Powerline fonts..."
    find "${PEARL_PKGDIR}/powerline-fonts" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -printf "%f\0" | \
        xargs -0 -I {} rm -f ${fonts_path}/{}

    local font

    info "Removing Adobe fonts..."
    for font in "SourceSansVariable-Italic.ttf" "SourceSansVariable-Roman.ttf" "SourceCodeVariable-Italic.otf" "SourceCodeVariable-Roman.otf" "SourceSerifVariable-Roman.otf"
    do
        rm -f "${HOME}/.fonts/$font"
    done

    info "Removing Cantarell fonts..."
    for font in "Cantarell-Regular" "Cantarell-Bold" "Cantarell-BoldOblique" "Cantarell-Oblique"
    do
        rm -f "${HOME}/.fonts/$font.ttf"
    done

    info "Removing Ubuntu fonts..."
    for font in "Ubuntu-Bold" "Ubuntu-BoldItalic" "Ubuntu-Italic" "Ubuntu-Light" \
        "Ubuntu-LightItalic" "Ubuntu-Medium" "Ubuntu-MediumItalic" "Ubuntu-Regular" \
        "UbuntuMono-Bold" "UbuntuMono-BoldItalic" "UbuntuMono-Italic" "UbuntuMono-Regular" "UbuntuCondensed-Regular"
    do
        rm -f "${HOME}/.fonts/$font.ttf"
    done

    fc-cache -vf ${HOME}/.fonts
    fc-cache -vf ${fonts_path}

    return 0
}
