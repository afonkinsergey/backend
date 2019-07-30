defmodule Backend.Repo.Migrations.CreatePostsTagsTable do
  use Ecto.Migration

  def change do
    create table(:posts_tags) do
      add :tag_id, references(:tags)
      add :post_id, references(:posts)
    end

    # так к у поста тэги уникальные:
    # функция будет проверять уникальность по тэгам
    create unique_index(:posts_tags, [:tag_id, :post_id])
  end
end
