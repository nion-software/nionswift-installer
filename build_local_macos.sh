#/bin/zsh

#$env /usr/bin/arch -x86_64 /bin/zsh

#git clone https://github.com/nion-software/nionswift-installer.git --single-branch installer-test-delete-me
cp -R nionswift-installer installer-test-delete-me

cd installer-test-delete-me
conda deactivate
python3.11 -m venv venv/installer
source venv/installer/bin/activate
python --version
python -m pip install --upgrade pip
git clone https://github.com/nion-software/nionswift-tool.git --branch 0.4.20 --single-branch
pip install aqtinstall
mkdir Qt
python -m aqt install-qt --outputdir Qt mac desktop 6.5.3 clang_64
export Qt6=`pwd`/Qt/6.5.3/macos
export Qt6_DIR="$Qt6/lib/cmake/Qt6"
export CMAKE_PREFIX_PATH="$Qt6"
pip install numpy
git clone https://github.com/nion-software/nionui-tool.git
pushd nionui-tool/launcher
PYTHON=`python -c "import sys; print(sys.executable, end='')"`
$PYTHON --version
cmake CMakeLists.txt -DPython3_EXECUTABLE="$PYTHON"
cmake --build . --config Release
popd
curl -O https://www.python.org/ftp/python/3.11.5/python-3.11.5-macos11.pkg
mkdir python-3.11.5-macos11
xar -xf python-3.11.5-macos11.pkg -C python-3.11.5-macos11
rm -rf Python.framework; mkdir Python.framework
tar -zxf python-3.11.5-macos11/Python_Framework.pkg/Payload -C Python.framework
python mac_fix_framework.py Python.framework/
python3.11 -m venv python-nionswift
source python-nionswift/bin/activate
python -m pip install nionswift nionswift-tool nionswift-eels-analysis nionswift-usim
deactivate
rm -rf dist; mkdir -p dist/
cp -R "nionui-tool/launcher/build/Nion UI Launcher.app" "dist/Nion Swift 16.app"
mv "dist/Nion Swift 16.app/Contents/MacOS/Nion UI Launcher" "dist/Nion Swift 16.app/Contents/MacOS/Nion Swift"
cp "python-nionswift/bin/Nion Swift.app/Contents/Info.plist" "dist/Nion Swift 16.app/Contents/Info.plist"
ditto "dist/Nion Swift 16.app/Contents/MacOS/Nion Swift" --arch x86_64 "dist/Nion Swift 16.app/Contents/MacOS/Nion Swift x64"
mv "dist/Nion Swift 16.app/Contents/MacOS/Nion Swift x64" "dist/Nion Swift 16.app/Contents/MacOS/Nion Swift"
mv Python.framework "dist/Nion Swift 16.app/Contents/Frameworks"
cp -R python-nionswift/lib/python3.11/site-packages/* "dist/Nion Swift 16.app/Contents/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages"
cp mac_toolconfig.toml "dist/Nion Swift 16.app/Contents/Resources/toolconfig.toml"
cp "nionswift-tool/launcher/Graphics/MacIcon.icns" "dist/Nion Swift 16.app/Contents/Resources/"
cp "nionswift-tool/launcher/Artwork/splash_600x400.png" "dist/Nion Swift 16.app/Contents/Resources/splash.png"
