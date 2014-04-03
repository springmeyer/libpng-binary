git checkout master ;
remote=origin ;
for TRAVIS_BRANCH in `
    git branch -r | grep $remote | grep -v master | grep -v HEAD | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'
`; do
    echo $TRAVIS_BRANCH ;
    git checkout $TRAVIS_BRANCH ;
    source ./build.sh ;
    $TRAVIS_BRANCH ;
done ;
git checkout master