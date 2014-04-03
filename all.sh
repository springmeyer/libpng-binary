remote=origin ;
for BRANCH in `
    git branch -r | grep $remote | grep -v master | grep -v HEAD | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'
`; do
    if [[ $BRANCH != "osx" ]] && [[ $BRANCH != "master" ]]; then
        echo $BRANCH ;
        git checkout $BRANCH ;
        source ./build.sh ;
        build $BRANCH ;
    fi
done ;
git checkout $TRAVIS_BRANCH