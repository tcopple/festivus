class Event < ActiveRecord::Base
  attr_accessible :description, :title, :when, :where
end
