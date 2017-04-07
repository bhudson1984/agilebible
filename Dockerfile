FROM elixir:1.4.2

# Set environment variables
ENV MIX_ENV prod
ENV PORT 4000

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Change current working directory
WORKDIR /usr/src/app

# Copy mix files
ADD mix.* ./

# Install and compile project's dependencies
RUN mix do deps.get, deps.compile

# Copy whole app source
COPY . /usr/src/app

# Compile elixir app
RUN mix compile

EXPOSE 4000

CMD MIX_ENV=prod mix phoenix.server
