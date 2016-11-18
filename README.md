# docker-logstash

build docker image

	# docker build -t logstash .

	# docker tag 2bd52e98a4c2 wohshon/logstash:v1

	# docker login 

	# docker push wohshon/logstash

deploying on ocp 

	# oc new-app wohshon/logstash:v1 -e SYSLOG_FACILITY=local0 -e SYSLOG_HOST=192.168.223.130 -e SYSLOG_PORT=514 -e SYSLOG_SEVERITY=info

	# oc volume dc/logstash --add --name=dockerlog --type=hostPath --mount-path=/var/log --path=/var/log
	# oc volume dc/logstash --add --name=varlibdockercontainers --type=hostPath --mount-path=/var/lib/docker/containers --path=/var/lib/docker/containers

make sure the volume mounts and the priviledged security context is in the dc, e.g. :

	 ports:
        - containerPort: 9600
          protocol: TCP
        resources: {}
        securityContext:
          privileged: true
        terminationMessagePath: /dev/termination-log
        volumeMounts:
        - mountPath: /var/log
          name: dockerlog
        - mountPath: /var/lib/docker/containers
          name: varlibdockercontainers
