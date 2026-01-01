#!/bin/bash

set -e

# Get the current branch
BRANCH=${GITHUB_REF##*/}

# Get the version from pubspec.yaml
VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //')
# remove the build number
VERSION=$(echo $VERSION | sed 's/+.*//')

# Get the build number from pubspec.yaml
BUILD_NUMBER=$(grep 'version:' pubspec.yaml | sed 's/.*+//')

# if no build number, set it to 1
if [ -z "$BUILD_NUMBER" ]; then
  BUILD_NUMBER=1
fi

# Increment the version based on the branch
if [ "$BRANCH" == "main" ]; then
  # Increment the patch version by 2
  VERSION=$(echo $VERSION | awk -F. -v OFS=. '{$3+=2;print}')
  # Reset build number to 1
  BUILD_NUMBER=1
elif [ "$BRANCH" == "development" ]; then
    # increment the build number
    BUILD_NUMBER=$((BUILD_NUMBER + 1))
fi

# Create the new version string
NEW_VERSION="$VERSION+$BUILD_NUMBER"

# Update the version in pubspec.yaml
sed -i "s/version: .*/version: $NEW_VERSION/" pubspec.yaml

# Output the new version
echo "NEW_VERSION=$NEW_VERSION" >> $GITHUB_ENV
