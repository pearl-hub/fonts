function post_install(){
    info "Installing Awesome terminal fonts..."
    cd "${PEARL_PKGDIR}/awesome-terminal-fonts"
    ./install.sh

    info "Installing Powerline fonts..."
    cd "${PEARL_PKGDIR}/powerline-fonts"
    ./install.sh

    info "Installing Adobe fonts..."
    cd ${HOME}/.fonts
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

    info "Removing Adobe fonts..."
    rm -f ${HOME}/.fonts/SourceSansVariable-Italic.ttf
    rm -f ${HOME}/.fonts/SourceSansVariable-Roman.ttf
    rm -f ${HOME}/.fonts/SourceCodeVariable-Italic.ttf
    rm -f ${HOME}/.fonts/SourceSerifVariable-Roman.otf

    fc-cache -vf ${HOME}/.fonts
    fc-cache -vf ${fonts_path}

    return 0
}
