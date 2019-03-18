# storm-cellar

Ansible should have setup most of what's needed. To test:

```
make storm_local
```

should run the aio exclamation topology from the storm-starter jar. Adjust paths as needed.

```
make set-hostname
```

will update the hostname so storm can find nimbus

```
make run-storm-critters

make kill-storm-critters
```
runs/kills zookeeper, nimbus, ui, and logviewer (not in enclave)

```
make storm_supervisor
``` 

runs the supervisor in an enclave

To submit a job to supervisor run 

```
3_storm_dist/apache-storm-2.0.1-SNAPSHOT/bin/storm jar 3_storm_dist/storm-starter-2.0.1-SNAPSHOT.jar org.apache.storm.starter.ExclamationTopology prod
```

Finding multiple storm.yaml if thats in your $CWD so move around to avoid it

