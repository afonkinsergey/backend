defmodule Backend.User.Tag do
  use Ecto.Schema

  schema "tags" do
    field :name, :string

    many_to_many :posts, Backend.User.Post, join_through: "posts_tags"
    # говорим соединяться через таблицу posts_tags
  end
end
