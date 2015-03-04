all: build

.PHONY: build

build:
	docker build -t sipwitch:1.9.6 .

run:
	docker run -d --name sip -p 5060:5060 -p 5060:5060/udp -p 60001:60001/udp sipwitch:1.9.6
	# Add -d to detach
