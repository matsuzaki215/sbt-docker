.PHONY: bash
bash:
	docker run -v src:/root/work/src --rm -it sbt /bin/bash

