json.extract! @restaurant, :id, :name, :address
json.owner @restaurant.user.email
json.comments @restaurant.comments do |comment|
  json.extract! comment, :content
  json.user comment.user.email
end

