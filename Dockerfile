FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build
WORKDIR /source

COPY *.sln .
COPY MVC_Core_HelloWorld/*.csproj ./MVC_Core_HelloWorld/
RUN dotnet restore

COPY MVC_Core_HelloWorld/. ./MVC_Core_HelloWorld/
WORKDIR /source/MVC_Core_HelloWorld

RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS final
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MVC_Core_HelloWorld.dll"]
