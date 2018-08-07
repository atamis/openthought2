json.extract! thought, :id, :body, :created_at, :updated_at

json.tags thought.tag_list

json.url thought_url(thought, format: :json)
