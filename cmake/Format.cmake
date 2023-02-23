function(Format target directory)
	find_program(CLANG-FORMAT_PATH clang-format)
	if (NOT CLANG-FORMAT_PATH)
		message(STATUS "Clang-format is not found")
		return()
	endif()
	set(EXPRESSION cpp hpp)
	list(TRANSFORM EXPRESSION PREPEND "${directory}/*.")
	file(GLOB_RECURSE SOURCE_FILES FOLLOW_SYMLINKS
		LIST_DIRECTORIES false ${EXPRESSION}
	)
	add_custom_command(TARGET ${target} PRE_BUILD COMMAND
		${CLANG-FORMAT_PATH} -i --style=file ${SOURCE_FILES}
	)
endfunction()
