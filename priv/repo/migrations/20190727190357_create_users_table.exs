defmodule Backend.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  # эта функция как обёртка над функциями up и down
  # def change do

  # end

  #  когда происходит миграция выполняется up функция
  def up do
    create table(:users) do # создаём таблицу
      add :name, :string # какие будут поля
      add :email, :string
      add :password, :string
      add :age, :integer
    end
  end

  #  когда откатывается миграция выполняется down функция
  def down do
    drop table(:users) # функция противоположная up, то есть удаляем таблицу
  end

end
