# =====================================
# BUILD STAGE
# =====================================

FROM mcr.microsoft.com/dotnet/sdk:8.0-bookworm-slim AS build

WORKDIR /src

# =====================================
# COPY CSPROJ
# =====================================

COPY src/Employeeprofileapp/*.csproj ./Employeeprofileapp/

# =====================================
# RESTORE PACKAGES
# =====================================

RUN dotnet restore ./Employeeprofileapp/EmployeeProfileApp.csproj

# =====================================
# COPY SOURCE
# =====================================

COPY src/Employeeprofileapp/. ./Employeeprofileapp/

WORKDIR /src/Employeeprofileapp

# =====================================
# PUBLISH APPLICATION
# =====================================

RUN dotnet publish EmployeeProfileApp.csproj \
    -c Release \
    -o /app/publish \
    /p:UseAppHost=false

# =====================================
# RUNTIME STAGE
# =====================================

FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim

WORKDIR /app

# =====================================
# INSTALL ICU LIBRARIES
# Required for globalization support
# =====================================

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libicu-dev && \
    rm -rf /var/lib/apt/lists/*

# =====================================
# CREATE NON-ROOT USER
# =====================================

RUN groupadd --gid 10001 appgroup && \
    useradd --uid 10001 --gid appgroup --create-home appuser

# =====================================
# CONTAINER ENVIRONMENT
# =====================================

ENV ASPNETCORE_URLS=http://+:8080

ENV DOTNET_RUNNING_IN_CONTAINER=true

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

ENV DOTNET_EnableDiagnostics=0

# =====================================
# COPY PUBLISHED OUTPUT
# =====================================

COPY --from=build /app/publish .

# =====================================
# SET FILE OWNERSHIP
# =====================================

RUN chown -R appuser:appgroup /app

# =====================================
# USE NON-ROOT USER
# =====================================

USER appuser

# =====================================
# EXPOSE APPLICATION PORT
# =====================================

EXPOSE 8080

# =====================================
# APPLICATION ENTRYPOINT
# =====================================

ENTRYPOINT ["dotnet", "EmployeeProfileApp.dll"]