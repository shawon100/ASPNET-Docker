FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build
WORKDIR /source

COPY *.sln .
COPY aspnetapp/*.csproj ./aspnetapp/
RUN dotnet restore

COPY aspnetapp/. ./aspnetapp/
WORKDIR /source/aspnetapp

RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS final
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MVC_Core_HelloWorld.dll"]
