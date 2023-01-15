FROM ruby:3.1.3

WORKDIR /myapp
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .

EXPOSE 5000

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "5000"]
