FROM elixir:1.4.2  

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash && apt-get install -y nodejs

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

COPY package.json ./
RUN npm install

# Copy whole app source
COPY . /usr/src/app

RUN ./node_modules/brunch/bin/brunch b -p && mix phoenix.digest

# Compile elixir app
RUN mix compile

EXPOSE 4000

CMD MIX_ENV=prod mix phoenix.server
