class Relationship < ApplicationRecord

	# relationships.followingをできるようにする
	belongs_to :following, class_name: "User"
 	validates :following_id, presence: true
 	# user.followingsをできるようにする
 	belongs_to :follower, class_name: "User"
    validates :follower_id, presence: true

end
