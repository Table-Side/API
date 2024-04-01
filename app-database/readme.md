# Tableside: API Database Backend

The custom postgres `Docker` image that sets up the API's database.

## Setup

1. Add your `.env` file:
```env
# -- Root DB -- #
POSTGRES_USER="root"
POSTGRES_PASSWORD="r00t"

# -- Frontdoor DB -- #
POSTGRES_FRONTDOOR_USER="frontdoor"
POSTGRES_FRONTDOOR_PASSWORD="fr0ntd00r"
POSTGRES_FRONTDOOR_DB="tableside_frontdoor"

# -- Kitchen DB -- #
POSTGRES_KITCHEN_USER="kitchen"
POSTGRES_KITCHEN_PASSWORD="kitch3n"
POSTGRES_KITCHEN_DB="tableside_kitchen"

# -- Order DB -- #
POSTGRES_ORDER_USER="order"
POSTGRES_ORDER_PASSWORD="0rd3r"
POSTGRES_ORDER_DB="tableside_order"

# -- Restaurant DB -- #
POSTGRES_RESTAURANT_USER="restaurant"
POSTGRES_RESTAURANT_PASSWORD="r35taurant"
POSTGRES_RESTAURANT_DB="tableside_restaurant"
```
2. Build the image: `docker build . -t tableside/database:latest`
3. Source your `.env` vars: `source .env`
4. Run the container and mount the `.env` file:
- _(Interactively)_: `docker run -e POSTGRES_USER="$POSTGRES_ROOT_USER" -e POSTGRES_PASSWORD="$POSTGRES_ROOT_PASSWORD" -v ./.env:/database/.env -it tableside/database:latest`
- _(Non-Interactively)_: `docker run -e POSTGRES_USER="$POSTGRES_ROOT_USER" -e POSTGRES_PASSWORD="$POSTGRES_ROOT_PASSWORD" -v ./.env:/database/.env tableside/database:latest`
