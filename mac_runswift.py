# this script is only used when building with pyinstaller.
# pyinstaller is not currently used because it strips unused packages.
from nionui_app.nionswift import main
app = main.main({}, {"pyqt": None})
app.run()
