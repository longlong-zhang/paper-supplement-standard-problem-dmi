#!/bin/bash

docker:
	docker build -t stdprob -f ./Dockerfile .
	docker run -ti -d --name stdprob stdprob

travis:
	# Mount (-v volume) the current directory in /home/data in the container
	docker run -v `pwd`:/home/data stdprob bash -c "cd data && make test-ipynb"

test-ipynb:
	cd notebooks && py.test --nbval --sanitize-with sanitize_nbval.cfg \
		1d_problem.ipynb 2d_problem.ipynb 3d_problem_cylinder.ipynb

.PHONY: docker