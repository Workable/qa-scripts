# Jfrog credentials used for downloading dependencies of test projects
source ~/.scripts/credentials.sh
# Bundler configuration for Workable project
export BUNDLE_TIMEOUT=60
export BUNDLE_RETRY=5
# If set, do not automatically update before running some commands e.g. brew install, brew upgrade and brew tap.
export HOMEBREW_NO_AUTO_UPDATE=1
# Set path of Java Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home
# Set path of Android Home needed for Mobile
export ANDROID_HOME=~/Library/Android/sdk
export PATH="$ANDROID_HOME/platform-tools:$PATH"