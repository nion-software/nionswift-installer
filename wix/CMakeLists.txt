cmake_minimum_required(VERSION 3.18)

project(NionSwiftInstaller LANGUAGES NONE)

set(VERSION_OVERALL "0" CACHE INTERNAL "")
set(VERSION_MAJOR "0" CACHE INTERNAL "")
set(VERSION_MINOR "0" CACHE INTERNAL "")
set(VERSION_PATCH "0" CACHE INTERNAL "")

set(VERSION_IDENTIFIER "${VERSION_MAJOR}_${VERSION_MINOR}")

set(CPACK_PACKAGE_NAME "Nion Swift ${CPACK_PACKAGE_VERSION}")
set(CPACK_PACKAGE_VENDOR "Nion Company")
set(CPACK_PACKAGE_VERSION_MAJOR "${VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${VERSION_PATCH}")
set(CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}")
set(CPACK_PACKAGE_DESCRIPTION "Nion Swift scientific image processing")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Nion Swift is scientific image processing software.")
set(CPACK_PACKAGE_FILE_NAME "NionSwift-${CPACK_PACKAGE_VERSION}")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "Nion Swift ${VERSION_OVERALL}")
set(CPACK_PACKAGE_ICON "${CMAKE_CURRENT_LIST_DIR}/../nionswift-tool/launcher/Graphics/WinIcon.ico")
set(CPACK_RESOURCE_FILE_LICENSE "LICENSE.txt")
set(CPACK_GENERATOR "WIX")
set(CPACK_PACKAGE_EXECUTABLES "Nion_Swift_${VERSION_IDENTIFIER}" "Nion Swift ${VERSION_OVERALL}")
set(CPACK_INSTALLED_DIRECTORIES "${CMAKE_CURRENT_LIST_DIR}/../dist/Nion_Swift_${VERSION_IDENTIFIER};.")

set(CPACK_WIX_SIZEOF_VOID_P "8")
set(CPACK_WIX_PRODUCT_ICON "${CMAKE_CURRENT_LIST_DIR}/../nionswift-tool/launcher/Graphics/WinIcon.ico")
set(CPACK_WIX_UPGRADE_GUID "BFDA08FE-8C0D-455F-90FE-4D19E9D4495F")

include(CPack)
