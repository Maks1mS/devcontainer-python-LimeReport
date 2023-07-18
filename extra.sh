packages_to_install() {
    echo -n "libclang-dev,libgl1-mesa-dev,libxkbcommon-x11-0,libdbus-1-3"

    case $QT in 
        5*)
            echo -n ",libpulse-mainloop-glib0"
        ;;
        *)
            echo -n ""
        ;;
    esac

    echo -n ",gcc-$(get_g_version),g++$(get_g_version)"
}

verlte() {
    printf '%s\n' "$1" "$2" | sort -C -V
}

verlt() {
    ! verlte "$2" "$1"
}

get_g_version() {
    if verlt $QT "6.5.0"; then
        echo -n "9"
    else
        echo -n "10"
    fi
}

switch_gcc_version() {
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$(get_g_version) 60 --slave /usr/bin/g++ g++ /usr/bin/g++-$(get_g_version)
}