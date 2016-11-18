FROM registry.access.redhat.com/rhel7.2

ENV JAVA_HOME /usr

COPY logstash-output-syslog-3.0.1.gem /tmp
COPY logstash.repo /etc/yum.repos.d
RUN yum -y install java logstash && \
        /usr/share/logstash/bin/logstash-plugin install /tmp/logstash-output-syslog-3.0.1.gem && \
        mkdir /opt/logstash && \
        mkdir /opt/logstash/log && \
        mkdir /opt/logstash/data && \
        mkdir /opt/logstash/conf.d

# logstash conf file
COPY logstash.conf /opt/logstash/conf.d/

# logstash settings file
COPY logstash.yml /opt/logstash/

# For LogStash API
EXPOSE 9600

# may not be needed
RUN chmod -R a+rwx /opt/logstash 


#Start Logstash 
CMD ["/usr/share/logstash/bin/logstash", "--path.settings=/opt/logstash/"]



