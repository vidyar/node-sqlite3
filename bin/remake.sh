export ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export UNAME=$(uname -s);

cd $ROOTDIR
cd ../

if [ ${UNAME} = 'Darwin' ]; then
    rm -rf ./bin/darwin-*
    node ./build.js --target_arch=x64
    node ./build.js --target_arch=ia32
elif [ ${UNAME} = 'Linux' ]; then
    rm -rf ./bin/linux-*
    apt-get upgrade
    apt-get install git make build-essential
    git clone https://github.com/creationix/nvm.git ~/.nvm
    source ~/.nvm/nvm.sh
    nvm install 0.10
    npm install -g node-gyp
    node ./build.js --target_arch=x64
    # now do 32 bit
    NVER=`node -v`
    wget http://nodejs.org/dist/${NVER}/node-${NVER}-linux-x86.tar.gz
    tar xf node-${NVER}-linux-x86.tar.gz
    export PATH=$(pwd)/node-${NVER}-linux-x86/bin:$PATH
    # ignore: 
    # dependency problems - leaving unconfigure  gcc-4.6:i386 g++-4.6:i386 libstdc++6-4.6-dev:i386
    # E: Sub-process /usr/bin/dpkg returned an error code (1)
    apt-get install binutils:i386 cpp:i386 gcc-4.6:i386 g++-4.6:i386 libstdc++6-4.6-dev:i386
    CC=gcc-4.6 CXX=g++-4.6 node ./build.js --target_arch=ia32    
fi