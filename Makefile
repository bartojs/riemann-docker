run:
	docker run --rm -it -p 5555:5555 -p 5555:5555/udp -p 5556:5556 -p 8000:80 bartojs/riemann:0.2.6
	#docker run --rm -it -P bartojs/riemann:0.2.6
build:
	docker build -t bartojs/riemann:0.2.6 .
