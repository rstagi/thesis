jars:
	mkdir -p jars
	mvn package
	cp -f target/sparktestmvn-1.0-SNAPSHOT.jar jars/spark.jar
	cp -f target/lib/* jars/

run: jars
	../../run_javatrace.sh -r -cp ./jars com.journaldev.sparkdemo.WordCounter

runshow: jars
	../../run_javatrace.sh -r -cp ./jars -show com.journaldev.sparkdemo.WordCounter

show:
	../../show_trace.sh -conf spark.pcf -row spark.row spark.prv

clean:
	rm -rf *.csv *.class set-0 TRACE.* *.pcf *.row *.prv extraej.* CountData target jars
