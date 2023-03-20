#!/usr/bin/env bash

# Setup eth genesis

set -o errexit
set -o pipefail

# Get keyword arguments
for argument in "${@}"; do
    case ${argument} in
        -e=* | --executionbin=*)
            EXEC_BIN="${argument#*=}"
            shift
            ;;
        -d=* | --datadir=*)
            DATADIR="${argument#*=}"
            shift
            ;;
        -g=* | --genesisjson=*)
            GJSON="${argument#*=}"
            shift
            ;;
        *)
            echo 'Error: Argument is not supported.'
            exit 1
            ;;
    esac
done

if  [ -z $EXEC_BIN ] || [ ! -x $EXEC_BIN ]; then
    echo "Execution binary not provided"
    exit 1
fi

if [ -z $DATADIR ] || [ ! -d $DATADIR ]; then
    echo "execution data directory not provided"
    exit 1
fi

if [ -z $GJSON ] || [ ! -e $GJSON ]; then
    echo "Genesis json not found"
    exit 1
fi

if [ -d ${DATADIR}/geth ]; then
    echo "Datadir contains blockchain data"
else
    echo "Initializing genesis state in ${DATADIR} with ${GJSON}"
    ${EXEC_BIN} --datadir ${DATADIR} init ${GJSON}
fi


