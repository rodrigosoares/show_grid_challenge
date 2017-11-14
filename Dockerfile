FROM ruby:2.4.2

RUN mkdir /show_grid
WORKDIR /show_grid

ADD Gemfile /show_grid/Gemfile
ADD Gemfile.lock /show_grid/Gemfile.lock

RUN bundle install --quiet

ADD . /show_grid

CMD ["./show_grid.rb"]
