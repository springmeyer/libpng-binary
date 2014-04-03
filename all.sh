remote=origin ;
for BRANCH in `
    git branch -r | grep $remote | grep -v master | grep -v HEAD | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'
`; do
    echo $BRANCH ;
    git checkout $BRANCH ;
    source ./build.sh ;
    $BRANCH ;
done ;
git checkout $TRAVIS_BRANCH