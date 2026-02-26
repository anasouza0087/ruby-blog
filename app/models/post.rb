class Post < ApplicationRecord
    validates :title, presence: true
    validates :text, presence: true
    validates :user, presence: true
    validates :theme, presence: true
end
