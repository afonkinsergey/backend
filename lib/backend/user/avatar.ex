defmodule Backend.User.Avatar do
  use Ecto.Schema

  schema "avatars" do
    field :nick_name, :string
    field :image_url, :string

    belongs_to :user, Backend.User
  end
end
