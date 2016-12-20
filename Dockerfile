FROM microsoft/dotnet:1.1-sdk-msbuild

# Install a newer dotnet CLI with F# support
RUN curl https://dotnetcli.blob.core.windows.net/dotnet/Sdk/rel-1.0.0/dotnet-dev-debian-x64.latest.tar.gz --output dotnet-dev-debian-x64.latest.tar.gz \
    && mkdir -p /opt/dotnet \
    && tar xzf dotnet-dev-debian-x64.latest.tar.gz -C /opt/dotnet

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

# Build the dotnet version
# NOTE: building the project with dotnet currently fails:
# RUN cd dotnetversion && /opt/dotnet/dotnet restore && /opt/dotnet/dotnet build /verbosity:detailed

#WORKDIR /dotnetapp
#ENTRYPOINT ["/bin/bash"]
