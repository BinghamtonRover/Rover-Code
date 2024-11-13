#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "sick_scan_xd::sick_scan_xd_shared_lib" for configuration "Release"
set_property(TARGET sick_scan_xd::sick_scan_xd_shared_lib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(sick_scan_xd::sick_scan_xd_shared_lib PROPERTIES
  IMPORTED_IMPLIB_RELEASE "${_IMPORT_PREFIX}/lib/sick_scan_xd_shared_lib.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/sick_scan_xd_shared_lib.dll"
  )

list(APPEND _cmake_import_check_targets sick_scan_xd::sick_scan_xd_shared_lib )
list(APPEND _cmake_import_check_files_for_sick_scan_xd::sick_scan_xd_shared_lib "${_IMPORT_PREFIX}/lib/sick_scan_xd_shared_lib.lib" "${_IMPORT_PREFIX}/bin/sick_scan_xd_shared_lib.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
