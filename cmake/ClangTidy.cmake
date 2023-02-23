function(AddClangTidy target directory)
	find_program(CLANG-TIDY_PATH clang-tidy)
	if (NOT CLANG-TIDY_PATH)
		message(STATUS "Clang-tidy is not found")
		return()
	endif()
	set(EXPRESSION cpp hpp)
	list(TRANSFORM EXPRESSION PREPEND "${directory}/*.")
	file(GLOB_RECURSE SOURCE_FILES FOLLOW_SYMLINKS
		LIST_DIRECTORIES false ${EXPRESSION}
	)
	add_custom_command(TARGET ${target} PRE_BUILD COMMAND
		${CLANG-TIDY_PATH} ${SOURCE_FILES}
	)
endfunction()
