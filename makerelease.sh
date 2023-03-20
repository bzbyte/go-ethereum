set -eEuo pipefail

cd "$(dirname "$0")"
REPO_ROOT="$(git rev-parse --show-toplevel)"
rm -rf $REPO_ROOT/build/bin/genesis.sh
strip $REPO_ROOT/build/bin/*
rm -rf ./build/release.tar.gz

# copy genesis service script
cp ./network_config/scripts/_genesis.sh $REPO_ROOT/build/bin/genesis.sh

# copy network config
tar -cvf ./build/release.tar ./network_config

# copy binaries 
cd $REPO_ROOT/build
tar -rvf ../build/release.tar ./bin
cd $REPO_ROOT
gzip ./build/release.tar 
tar -tvf ./build/release.tar.gz

