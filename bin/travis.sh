if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo -e "rebuilding binaries for node v${TRAVIS_NODE_VERSION}\n"
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"
  git clone --quiet --branch=${TRAVIS_BRANCH} https://${GH_TOKEN}@github.com/developmentseed/node-sqlite3.git node-sqlite3-bin > /dev/null
  cd node-sqlite3-bin
  BINARY=$(node -e "console.log(process.platform +'-'+process.arch+'-v8-'+(/[0-9]+\.[0-9]+/.exec(process
.versions.v8)[0]))")
  mkdir -p ./bin/${BINARY}/
  NFROM="${TRAVIS_BUILD_DIR}/bin/${BINARY}/node_sqlite3.node"
  NTO="./bin/${BINARY}/node_sqlite3.node"
  if [ -f  "${NFROM}" ]; then
     echo -e "Copying ${NFROM} to ${NTO}"
     cp "${NFROM}" "${NTO}"
  else
     echo -e "Not found to copy: ${NFROM}"
  fi
  echo -e "Adding to git: ${NTO}"
  git add "${NTO}"
  git commit "${NTO}" -m "Travis build ${TRAVIS_BUILD_NUMBER}: update ${BINARY} binary in ${TRAVIS_BRANCH} [ci skip]"
  git push -fq origin ${TRAVIS_BRANCH} > /dev/null
  echo -e "Finished posting binaries\n"
fi