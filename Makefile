build:
	docker build -t node-memory-behaviour .
run:
	@echo THE FOLLOWING TESTS SHOULD NOT CRASH

	time docker run --interactive \
		--memory=64m \
		--memory-swap=64m \
		--env NODE_MAX_SEMI_SPACE_SIZE=1 \
		--env NODE_MAX_OLD_SPACE_SIZE=64 \
		--env NODE_MAX_EXECUTABLE_SIZE=64 \
		--env TEST_ITERATIONS=1024 \
		node-memory-behaviour

	time docker run --interactive \
		--memory=64m \
		--memory-swap=64m \
		--env NODE_MAX_SEMI_SPACE_SIZE=2 \
		--env NODE_MAX_OLD_SPACE_SIZE=32 \
		--env NODE_MAX_EXECUTABLE_SIZE=64 \
		--env TEST_ITERATIONS=1024 \
		node-memory-behaviour

	time docker run --interactive \
		--memory=64m \
		--memory-swap=64m \
		--env NODE_MAX_SEMI_SPACE_SIZE=2 \
		--env NODE_MAX_OLD_SPACE_SIZE=32 \
		--env NODE_MAX_EXECUTABLE_SIZE=24 \
		--env TEST_ITERATIONS=1024 \
		node-memory-behaviour

	@echo THE FOLLOWING TESTS SHOULD CRASH

	time docker run --interactive \
		--memory=48m \
		--memory-swap=48m \
		--env NODE_MAX_SEMI_SPACE_SIZE=1 \
		--env NODE_MAX_OLD_SPACE_SIZE=64 \
		--env NODE_MAX_EXECUTABLE_SIZE=64 \
		--env TEST_ITERATIONS=1024 \
		node-memory-behaviour; true

	time docker run --interactive \
		--memory=48m \
		--memory-swap=48m \
		--env NODE_MAX_SEMI_SPACE_SIZE=2 \
		--env NODE_MAX_OLD_SPACE_SIZE=64 \
		--env NODE_MAX_EXECUTABLE_SIZE=64 \
		--env TEST_ITERATIONS=1024 \
		node-memory-behaviour; true
