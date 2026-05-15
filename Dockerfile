# =====================================
# BUILD STAGE
# =====================================

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

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

FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

# =====================================
# CONTAINER ENVIRONMENT
# =====================================

ENV ASPNETCORE_URLS=http://+:8080

ENV DOTNET_RUNNING_IN_CONTAINER=true

# =====================================
# COPY PUBLISHED OUTPUT
# =====================================

COPY --from=build /app/publish .

# =====================================
# EXPOSE APPLICATION PORT
# =====================================

EXPOSE 8080

# =====================================
# APPLICATION ENTRYPOINT
# =====================================

ENTRYPOINT ["dotnet", "EmployeeProfileApp.dll"]