JAVAC ?= javac
JAR ?= jar

ForkJoin.jar: ForkJoin.class
	@echo "Main-Class: ForkJoin" > MANIFEST
	$(JAR) cfm ForkJoin.jar MANIFEST ForkJoin.class
	@rm MANIFEST

ForkJoin.class: ForkJoin.java
	$(JAVAC) $<

run: ForkJoin.jar 
	../../run_javatrace.sh ForkJoin

runshow: ForkJoin.jar
	../../run_javatrace.sh -show ForkJoin

runjar: 
	../../run_javatrace.sh -jar ForkJoin.jar Main

runjarshow:
	../../run_javatrace.sh -jar ForkJoin.jar -show ForkJoin

show:
	../../show_trace.sh -conf ForkJoin.pcf -row ForkJoin.row ForkJoin.prv

clean:
	rm -fr *.csv *.class set-0 TRACE.* *.pcf *.row *.prv extraej.*
