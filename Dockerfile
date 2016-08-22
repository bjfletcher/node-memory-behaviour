FROM node:latest
COPY index.js .

CMD node \
	--max_semi_space_size=$NODE_MAX_SEMI_SPACE_SIZE \
	--max_old_space_size=$NODE_MAX_OLD_SPACE_SIZE \
	--max_executable_size=$NODE_MAX_EXECUTABLE_SIZE \
	index.js
