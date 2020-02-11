include Makefile.inc

PiExample.jar: PiSerial.class PiThread.class PiThreaded.class PiExample.class
	@echo "Main-Class: PiExample" > MANIFEST
	$(JAR) cfm PiExample.jar MANIFEST PiExample.class PiSerial.class PiThread.class PiThreaded.class
	@rm MANIFEST

PiExample.class: PiExample.java
	$(JAVAC) $<

PiSerial.class: PiSerial.java
	$(JAVAC) $<

PiThread.class: PiThread.java
	$(JAVAC) $<

PiThreaded.class: PiThreaded.java
	$(JAVAC) $<

run: PiExample.jar
	./run_javatrace.sh PiExample

runjar: PiExample.jar
	./run_javatrace.sh -jar PiExample.jar
clean:
	rm -fr *class *jar set-0 TRACE.* *pcf *row *prv extraej.*
