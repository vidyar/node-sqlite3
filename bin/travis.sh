if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "rebuilding binaries for node v${TRAVIS_NODE_VERSION}\n"
  echo `pwd`
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"
  git clone --quiet --branch=${TRAVIS_BRANCH} https://${GH_TOKEN}@github.com/developmentseed/node-sqlite3.git node-sqlite3-bin > /dev/null
  cd node-sqlite3-bin
  BINARY=$(node -e "console.log(process.platform +'-'+process.arch+'-v8-'+(/[0-9]+\.[0-9]+/.exec(process
.versions.v8)[0]))")
  cp ${TRAVIS_BUILD_DIR}/bin/$BINARY/*node ./bin/${BINARY}/
  git add ./bin/${BINARY}/*node
  git commit -a -m "update ${BINARY} binary"
  #git remote rm origin
  #git remote add origin https://@github.com/developmentseed/node-sqlite3.git
  git commit -m "Travis build ${TRAVIS_BUILD_NUMBER} pushed to ${TRAVIS_BRANCH} [ci skip]"
  git push -fq origin ${TRAVIS_BRANCH} > /dev/null
  echo "Finished posting binaries\n"
fi