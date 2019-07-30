defmodule Backend.Jotteruser do
  use Ecto.Schema
  require Ecto.Query # позовём эту штуку чтобы можно было выполнять её макросы
  alias Ecto.Changeset

  schema "jotterusers" do
    field :login, :string
    field :password, :string
    field :email, :string
    field :name, :string
    field :surname, :string
    field :age, :integer
    field :sex, :string
    field :city, :string
  end

  # ниже специальная функция, которая делает проверку перед тем как передать запись в бд
  def changeset(jotteruser, params \\ %{}) do
    jotteruser
    |> Changeset.cast(params, [
      :login,
      :password,
      :email,
      :name,
      :surname,
      :age,
      :sex,
      :city
      ])

    # определяем обязательное заполнение полей
    |> Changeset.validate_required([:login, :password, :email, :name, :surname])

    # проверяем на минимальную длину логина 3 символа
    |> Changeset.validate_length(:login, min: 3)

    # проверяем валидность имейла
    |> Changeset.validate_format(:email, ~r/@/)

    # проверка на валидные символы логина из тз: 0-9, a-z, A-Z
    # наверное это как-то можно объеденить с валидацией емайла
    |> Changeset.validate_format(:login, ~r/^[A-Za-z0-9]/)

    # нужна проверка на уникальность логина
    |> Changeset.unique_constraint(:login)
  end

  def get_first_record do
    Backend.Repo.one(Ecto.Query.from u in __MODULE__, order_by: [asc: u.id], limit: 1)
  end

  # для последней записи, как обычно записывается (не развёрнуто)
  def get_last_record do
    __MODULE__ # зовём модуль
    |> Ecto.Query.last() # последняя запись
    |> Backend.Repo.one() # обращение к репе
  end
end
