FROM public.ecr.aws/amazonlinux/amazonlinux:2

# Install dependencies and clean up
RUN yum install -y openssl11 zip && \
    yum clean all && \
    mkdir -p /tmp/layer/bin /tmp/layer/lib

# Set working directory
WORKDIR /tmp/layer

# Copy necessary files
RUN cp /bin/openssl11 bin/openssl && \
    cp /usr/lib64/libbz2.so.1 lib && \
    cp /usr/lib64/libssl.so.1.1 lib && \
    cp /usr/lib64/libcrypto.so.1.1 lib

RUN zip -r layer.zip ./*
RUN rm -rf lib bin