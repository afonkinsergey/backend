defmodule Backend.User do
  use Ecto.Schema
  require Ecto.Query # позовём эту штуку чтобы можно было выполнять её макросы
  alias Ecto.Changeset

  schema "users" do
    field :email, :string # поля из таблицы базы данных
    field :name, :string
    field :password, :string
    field :age, :integer

    has_one :avatar, Backend.User.Avatar # как бы ссылка к .Avatar где у нас есть belongs_to
    has_many :posts, Backend.User.Post # эта штука как и has_one ничего в бд не добавляет,
    # а делает доступными все записи
    # из таблицы Post которые ассоциированы с этим пользователем
  end

  # ниже специальная функция, которая делает проверку перед тем как передать запись в бд
  def changeset(user, params \\ %{}) do
    user # берём схему user
    # функция cast говорит какие параметры разрешены для передачи изменений, все другие будут игнорироваться, skip-нутся
    |> Changeset.cast(params, [:email, :name, :password, :age])
    |> Changeset.validate_required([:name, :password]) # определяет обязательное заполнение полей
    |> Changeset.validate_length(:name, min: 3) # проверяем на минимальную длину имени 3 символа
  end

  def get_first_record do
    Backend.Repo.one(Ecto.Query.from u in __MODULE__, order_by: [asc: u.id], limit: 1) # вохвращает только одну выборку
  # __MODULE__ равносильно Backend.User, эликсир сам подставляет имя, это удобно если переименовили модуль
  # и его не нужно искать и переименовывать во всём листинге
  end

  # для последней записи, как обычно записывается (не развёрнуто)
  def get_last_record do
    __MODULE__ # зовём модуль
    |> Ecto.Query.last() # последняя запись
    |> Backend.Repo.one() # обращение к репе
  end
end
