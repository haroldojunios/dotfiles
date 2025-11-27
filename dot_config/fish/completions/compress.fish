# Complete compress command
complete -c compress -f

# Complete folders (paths that exist - both files and directories)
complete -c compress -a '(__fish_complete_path)'

# Boolean flags
complete -c compress -s g -l get-quality -d "Get quality information" -f
complete -c compress -s p -l pdfs -d "Process PDF files" -f
complete -c compress -s i -l images -d "Process image files" -f
complete -c compress -s v -l videos -d "Process video files" -f
complete -c compress -s a -l audios -d "Process audio files" -f
complete -c compress -s r -l recursive -d "Process recursively" -f
complete -c compress -l video-animation -d "Process video as animations" -f
complete -c compress -s s -l summary -d "Show summary" -f

# Options with arguments
complete -c compress -l image-quality -d "Image quality (0.0-1.0 float)" -x
complete -c compress -l video-quality -d "Video quality (0-70)" -x
complete -c compress -l video-preset -d "Video preset (0-10)" -x

# Help
complete -c compress -l help -d "Show help message" -f
