defmodule Backend.Repo.Migrations.CreateTagsTable do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
    end
    # здесь не указываем поля для связи, связи будут храниться в отдельной таблице
  end
end
