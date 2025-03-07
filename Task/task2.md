
image redis:4-alpine

Container exposes port 6379

1 replica

Assign the label “app: redis” to the Pods

Create a service that exposes port 6379 as a ClusterIP

The service's selector points to “app: redis”

The service's name should be “redis”

Verify by exec into the redis pod and execute: