# Tableside: API

The repository for Tableside's API.

Uses Apache APISIX for an API Gateway. APISIX is configured to run in [Standalone mode](https://apisix.apache.org/docs/apisix/deployment-modes/#standalone).
Microservice requests are proxied via the gateway.

## Local Setup (Using Latest Images)

Before following these instructions, ensure the [Tableside IAM](https://github.com/Table-Side/IAM) service is running locally.

1. Clone this repo
2. Ensure [Docker](https://docs.docker.com/get-docker/) is installed on your machine
3. Generate a [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens). Note that it must be the **classic** token.
4. Create a docker configuration file at `.docker/config.json` with the following format:
```json
{
  "auths": {
    "ghcr.io": {
      "auth": "<YOUR-USERNAME>:<YOUR-GITHUB-PERSONAL-ACCESS-TOKEN>"
    }
  }
}
```
5. Create a `.env` file based on the `sample.env` file available.
6. Run `docker compose -f docker-compose up -d` to start the API service.
7. Ensure all services start correctly.
8. Send all requests via the APISIX gateway at `localhost:9080`.

## Local Setup (Using Repositories)

Recommended if any changes are being made to the microservice repos.

1. Clone this repo
2. Clone all microservice repos
3. Ensure [Docker](https://docs.docker.com/get-docker/) is installed on your machine
4. Update the build context for each service to point to the correct location.
5. Create a `.env` file based on the `sample.env` file available.
6. Run `docker compose -f docker-compose.local.yml up -d` to start the API service.
7. Ensure all services start correctly.
8. Send all requests via the APISIX gateway at `localhost:9080`.
