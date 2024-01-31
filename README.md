# NAME

Fractal networks interview

## AUTHOR

Ahmad Abbati Bako

## DESCRIPTION

Django and Docker Evaluation

## DEPLOYMENT

1. **Docker Containerization**

   Run the following command to deploy the project using Docker:

   ```bash
   docker-compose -f docker-compose.yml up -d --build

2. **Database Migration**

   Run the following commands to create and run migration on the database:

   ```bash
   docker-compose exec web python manage.py makemigrations
   
   docker-compose exec web python manage.py migrate

3. **Testing**

   Run the following command to run tests:

   ```bash
   docker-compose exec web python manage.py test

## ENVIRONMENT VARIABLES

- .env file for Django environment variables
- .env.db file for postgres environment variables

## DATABASE

The project uses Postgres database with PostGIS extension enabled for geospatial data support.

## PROGRAMMING LANGUAGE
Python (Django framework)

## SYSTEM DEPENDENCIES
Docker