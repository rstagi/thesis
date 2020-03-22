JAVAC=/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/javac
JAR=/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/jar

InterThreadComm.jar: InterThreadComm.class
	@echo "Main-Class: InterThreadComm" > MANIFEST
	$(JAR) cfm InterThreadComm.jar MANIFEST InterThreadComm*.class
	@rm MANIFEST

InterThreadComm.class: InterThreadComm.java
	$(JAVAC) $<

run: InterThreadComm.jar 
	../../run_javatrace.sh InterThreadComm

runjar: InterThreadComm.jar 
	../../run_javatrace.sh -jar InterThreadComm.jar InterThreadComm

runshow: InterThreadComm.jar
	../../run_javatrace.sh -show InterThreadComm

runjarshow: InterThreadComm.jar
	../../run_javatrace.sh -show -jar InterThreadComm.jar InterThreadComm

show:
	../../show_trace.sh -conf InterThreadComm.pcf -row InterThreadComm.row InterThreadComm.prv

clean:
	rm -fr *.csv *.class set-0 TRACE.* *.jar *.pcf *.row *.prv extraej.*
