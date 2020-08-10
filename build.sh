#!/usr/bin/env bash
APP_HOME=$(cd $(dirname $0); pwd)
TARGET_DIR="$APP_HOME/target"
VERSION="1.0.0"
TARGET_APP_HOME="$TARGET_DIR/flask-with-runtime-$VERSION"

#TARGET_SCRIPTS
echo "Working directory is: $APP_HOME"
echo "Checkiing python version ..."
python_version=$(python -V 2>&1)
if [[ -z "$python_version" ]];then
    echo "No Python!"
    exit 1
else :
    echo $python_version
fi
if [ -d "$TARGET_DIR" ];then
  rm -rf $TARGET_DIR
fi
mkdir -p "$TARGET_APP_HOME"

cp -r $APP_HOME/application $TARGET_APP_HOME
echo "Compiling ..."
python -m compileall  $TARGET_APP_HOME/application
find $TARGET_APP_HOME/application -name '*.py' -type f -print -exec rm {} \;
find $TARGET_APP_HOME/application -name '__pycache__' -exec rm -rf {} \;

echo "Copy runtime resources to target."
cp -r $APP_HOME/resources/* $TARGET_APP_HOME/
echo "Packaging ..."
COPYFILE_DISABLE=1 tar -zcf  $TARGET_APP_HOME.tar.gz -C $TARGET_DIR flask-with-runtime-$VERSION
rm -rf $TARGET_DIR/flask-with-runtime-$VERSION
