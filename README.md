# libpng-binary

Building libpng for other apps to statically link to.

# Setup

 - edit TARGET in .travis.yml
 - enable repo at your travis profile: https://travis-ci.org/profile
 - encrypt keys: travis encrypt AWS_S3_KEY=${AWS_S3_KEY} --add && travis encrypt AWS_S3_SECRET=${AWS_S3_SECRET} --add