# Use an official Ruby runtime as a parent image
FROM docker.io/library/ruby:3.4.1

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies required for your app (e.g., build tools for gems like pg, etc.)
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy Gemfile and Gemfile.lock, then install dependencies
COPY Gemfile ./
# Remove Gemfile.lock to make sure it's re-downloaded and install dependencies
RUN rm -f Gemfile.lock && bundle lock --add-platform ruby && bundle install --redownload

# Copy the rest of the application files into the container
COPY . .

# Set the environment variable RACK_ENV to production
ENV RACK_ENV=production

# init react app
RUN rubee react prepare

# Initialize the database
RUN rubee db init
RUN rubee db run:all

# Expose the port the app will run on
EXPOSE 8080

# Run the app (ensure this command correctly starts your app)
CMD rubee start:8080
