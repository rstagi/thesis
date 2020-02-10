# Using an existing docker image as a base
FROM opensuse/leap

# Download and install a dependency
RUN zypper install -y git
#RUN zypper install -y java
RUN zypper install -y java-1_8_0-openjdk java-1_8_0-openjdk-devel
RUN zypper install -y papi

COPY . .

RUN cd extrae && ./configure && make && make install
