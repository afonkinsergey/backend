defmodule Backend.Repo.Migrations.CreateJotteruserTable do
  use Ecto.Migration

  #  когда происходит миграция выполняется up функция
  def up do
    create table(:jotterusers) do # создаём таблицу
      add :login, :string # какие будут поля
      add :password, :string
      add :email, :string
      add :name, :string
      add :surname, :string
      add :age, :integer
      add :sex, :string
      add :city, :string
    end
    # проверка уникальности логина
    create unique_index(:jotterusers, [:login])
  end


  #  когда откатывается миграция выполняется down функция
  def down do
    drop table(:jotterusers) # функция противоположная up, то есть удаляем таблицу
  end

end
