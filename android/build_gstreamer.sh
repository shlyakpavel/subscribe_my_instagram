
source ~/.androidenv  # Definition of environment variables related to Android development (SDK, NDK)

echo "----"

echo $@

echo "----"

ndk-build $@

echo "----"
