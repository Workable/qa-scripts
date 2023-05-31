function download_ios_app(){
 STAGING=$1
 export AWS_PROFILE=workable-hr
 aws s3 cp s3://workable-dev-jenkins/uploads/mobileNativeBuilds/iOS/$2/$1/workable.app.zip ~/Downloads/
 rm -rf /Users/manoskousteris/Downloads/workable-$1.app
 yes |unzip -d /Users/manoskousteris/Downloads/workable-$1.app /Users/manoskousteris/Downloads/workable.app
 rm -rf /Users/manoskousteris/Downloads/workable.app.zip
}

# staging, branch parameters
function download_android_app(){
 STAGING=$1
 export AWS_PROFILE=workable-hr
 aws s3 cp s3://workable-dev-jenkins/uploads/mobileNativeBuilds/Android/$2/app-$1.apk ~/Downloads/
}

function build_ios_app(){
 mode='Stg10'
 if [ $1 = 'stg3' ]
 then
   mode='QADebug'
 fi
 workable_ios
 xcodebuild -workspace workable.xcworkspace -scheme Production SYMROOT=$PWD/build -configuration $mode clean build -sdk "iphonesimulator" -destination 'platform=iOS Simulator,name=iPhone 12,OS=14.4'
 cp -r build/$mode-iphonesimulator/workable.app ~/Downloads/workable-$1.app
}
