BINARY=$(node -e "console.log(process.platform +'-'+process.arch+'-v8-'+(/[0-9]+\.[0-9]+/.exec(process
.versions.v8)[0]))")
BINARY_FILE="./bin/${BINARY}/node_sqlite3.node"
if [ -f ${BINARY_FILE} ]; then
    rm "Removing: ${BINARY_FILE}"
else
    echo "Not found: ${BINARY_FILE}"
fi
