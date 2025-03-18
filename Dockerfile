# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 80


# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["srs/Ifolor.ProducerService.Web/Ifolor.ProducerService.Web.csproj", "srs/Ifolor.ProducerService.Web/"]
COPY ["srs/Ifolor.ProducerService.Application/Ifolor.ProducerService.Application.csproj", "srs/Ifolor.ProducerService.Application/"]
COPY ["srs/Ifolor.ProducerService.Infrastructure/Ifolor.ProducerService.Infrastructure.csproj", "srs/Ifolor.ProducerService.Infrastructure/"]
COPY ["srs/Ifolor.ProducerService.Core/Ifolor.ProducerService.Core.csproj", "srs/Ifolor.ProducerService.Core/"]
RUN dotnet restore "./srs/Ifolor.ProducerService.Web/Ifolor.ProducerService.Web.csproj"
COPY . .
WORKDIR "/src/srs/Ifolor.ProducerService.Web"
RUN dotnet build "./Ifolor.ProducerService.Web.csproj" -c $BUILD_CONFIGURATION -o /app/build

# This stage is used to publish the service project to be copied to the final stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./Ifolor.ProducerService.Web.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Ifolor.ProducerService.Web.dll"]