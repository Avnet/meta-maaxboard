#!/bin/sh

CWD=$(pwd)

log_error(){
    echo -ne "\e[31m $1 \e[0m\n"
}

usage(){
    echo "Usage:"
    echo " MACHINE=<machine> source maaxboard-setup.sh <build-dir>"
    echo "Options:"
    echo "  <machine>    machine name"
    echo "               - maaxboard-8ulp"
    echo "  * [-b build-dir]: Build directory, if unspecified script uses 'build' as output directory"
    echo "  * [-h]: help"
    echo "Examples: "
    echo "$ MACHINE=maaxboard-8ulp source sources/meta-maaxboard-8ulp/tools/maaxboard-setup.sh -b maaxboard-8ulp/build"
    echo
}

cleanup_EULA(){
    cd $CWD/sources/meta-freescale
    if [ -h EULA ]; then
        echo Cleanup meta-freescale/EULA...
        git checkout -- EULA
    fi
    if [ ! -f classes/fsl-eula-unpack.bbclass ]; then
        echo Cleanup meta-freescale/classes/fsl-eula-unpack.bbclass...
        git checkout -- classes/fsl-eula-unpack.bbclass
    fi
    cd -
}

file_override() {
    source_path=$1
    override_root=$2
    if [ -f $source_path ]; then
        override_path=$override_root/`basename $source_path`
        if [ -f $override_path ]; then
            echo "\

WARNING: The file '$CWD/$source_path' is replacing the upstream file '$CWD/$override_path'. \
Overrides by file replacement are error-prone and discouraged. Please find an \
alternative override mechanism that uses meta-data only.
"
            rm $override_path
        fi
    fi
}

machine_overrides() {
    layer=$1
    upstream_layer=$2
    machines="../sources/$layer/conf/machine/*"
    machine_includes="../sources/$layer/conf/machine/include/*"
    for machine in $machines; do
        file_override $machine ../sources/$upstream_layer/conf/machine
    done
    for machine_include in $machine_includes; do
        file_override $machine_include ../sources/$upstream_layer/conf/machine/include
    done
}

bbclass_overrides() {
    layer=$1
    upstream_layer=$2
    bbclasses="../sources/$layer/classes/*"
    for bbclass in $bbclasses; do
        file_override $bbclass ../sources/$upstream_layer/classes
    done
}

hook_in_layer() {

    layer=$1
    shift
    if [ "$1" = "" ]; then
        upstream_layers="meta-freescale"
    else
        upstream_layers="$@"
    fi

    # echo "BBLAYERS += \"\${BSPDIR}/sources/$layer\"" >> conf/bblayers.conf
    for upstream_layer in $upstream_layers; do
        machine_overrides $layer $upstream_layer
        bbclass_overrides $layer $upstream_layer
    done
}

maaxboard_conf_set(){
    local build_dir=$1
    if [ $MACHINE == "maaxboard-8ulp" ];then
        cp $CWD/sources/meta-maaxboard-8ulp/conf/local.conf.8ulp.sample $CWD/${build_dir}/conf/local.conf
        cp $CWD/sources/meta-maaxboard-8ulp/conf/bblayers.conf.8ulp.sample $CWD/${build_dir}/conf/bblayers.conf
    fi
}

run(){
    local build_dir=$1
    local oeroot=$CWD/sources/poky
    if [ -e $CWD/sources/oe-core ]; then
        oeroot=$CWD/sources/oe-core
    fi
    . $oeroot/oe-init-build-env $CWD/$build_dir > /dev/null
    if [ ! -e conf/local.conf ]; then
        log_error "oe-init-build-env does not generated."
        exit -1
    fi
    maaxboard_conf_set $build_dir

    # Clean up PATH, because if it includes tokens to current directories somehow,
    # wrong binaries can be used instead of the expected ones during task execution
    export PATH="`echo $PATH | sed 's/\(:.\|:\)*:/:/g;s/^.\?://;s/:.\?$//'`"
    
    cat <<EOF
    Welcome to Freescale Community BSP

    The Yocto Project has extensive documentation about OE including a
    reference manual which can be found at:
        http://yoctoproject.org/documentation

    For more information about OpenEmbedded see their website:
        http://www.openembedded.org/

    You can now run 'bitbake <target>'

    Common targets are:
        lite-image
EOF
    
    hook_in_layer meta-imx/meta-bsp
    hook_in_layer meta-imx/meta-sdk
    hook_in_layer meta-imx/meta-ml
    hook_in_layer meta-imx/meta-v2x
    hook_in_layer meta-nxp-demo-experience
}

start(){
    if [ "$(whoami)" = "root" ]; then
        echo "ERROR: do not use the BSP as root. Exiting..."
        exit -1
    fi
    local BUILD_DIR;
    local OLD_OPTIND=$OPTIND

    while getopts "b:h" fsl_setup_flag
    do
        case $fsl_setup_flag in
            b) 
                BUILD_DIR="$OPTARG";
                echo -e "\n Build directory is " $BUILD_DIR
                ;;
            h) 
                usage
                exit
                ;;
            \?) 
                usage
                exit -1;;
        esac
    done
    shift $((OPTIND-1))

    OPTIND=$OLD_OPTIND

    if [ -z "$BUILD_DIR" ]; then
        BUILD_DIR='build'
    fi
    if [ -z "$MACHINE" ]; then
        echo setting to default machine
        MACHINE='maaxboard'
    fi
    cleanup_EULA;

    mkdir -p $BUILD_DIR
    run $BUILD_DIR
}

start $@
