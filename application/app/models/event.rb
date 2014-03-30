class Event < ActiveRecord::Base
  attr_accessible :description, :title, :when, :where

  belongs_to :user
end
