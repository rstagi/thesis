JAR=jar
JAVAC=javac

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
	../../run_javatrace.sh PiExample

runjar: PiExample.jar 
	./run_javatrace.sh -jar PiExample.jar

runshow: PiExample.jar
	../../run_javatrace.sh -show PiExample

runjarshow: PiExample.jar
	./run_javatrace.sh -show -jar PiExample.jar

show:
	../../show_trace.sh -conf PiExample.pcf -row PiExample.row PiExample.prv

clean:
	rm -fr *.csv *.class set-0 TRACE.* *.jar *.pcf *.row *.prv extraej.*
