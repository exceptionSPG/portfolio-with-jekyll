FROM ruby:2.7 as builder

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

WORKDIR /usr/src/app

COPY . .
#COPY Gemfile just-the-docs.gemspec ./
RUN gem install bundler && bundle install

RUN bundle exec jekyll build

FROM nginx:alpine
COPY --from=builder /usr/src/app/_site /usr/share/nginx/html
EXPOSE 80
