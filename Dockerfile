FROM microsoft/dotnet:1.1-sdk-msbuild

# We we build the app in /source
RUN mkdir /source
WORKDIR /source

# Install Paket manager
RUN mkdir .paket
COPY .paket/paket.bootstrapper.exe .paket/paket.targets /source/.paket/
#RUN dotnet .paket/paket.bootstrapper.exe

# Install packages
COPY paket.dependencies paket.lock /source/
#RUN dotnet run .paket/paket.exe install

# Copy over everything else
COPY . /source/

#WORKDIR /dotnetapp
#ENTRYPOINT ["/bin/bash"]
