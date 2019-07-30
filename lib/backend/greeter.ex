defmodule Backend.Greeter do
  @moduledoc """
  The Greeter module introduced here
  """
  @greeting Application.fetch_env!(:backend, :greeting)
  # макрос который вызывается из use в таске
  defmacro __using__(_) do
    quote do
      def good_wish, do: "Have a nice day!"
    end
  end

  # ниже пример создания макроса, который делает кокотинацию не через <>, а через + (плюс)
  defmacro concat({:+, _, [lhs, rhs]}) do
    quote do
      "#{unquote(lhs)} #{unquote(rhs)}"
    end
  end

  # попробуем пользовательский ограничитель, Guard
  # для функции нужна проверка что даём чётное число
  # is_integer это проверка на то что пришло целочисленное число
  # rem это проверка остатка от деления
  defguard is_even(value) when is_integer(value) and rem(value, 2) == 0

  def incr_even_number(v) when is_even(v) do # функции передаём чётное число и делаем его нечётным
    v + 1
  end

  # можно обратиться только к функции iex -S mix Backend.Greeter.greeting("joe")
  def greeting(name \\ "user") do # через \\ указывается аргумент по умолчанию
    @greeting <> ", #{sanitize_name(name)}!"
    # greeting = Application.fetch_env!(:backend, :greeting)
    # "#{greeting}, #{name}!"
  end

  # функция приветствия для множества людей
  def greeting_many(names) do
    names
    |> sanitize_names()
    |> Enum.map(&greeting/1) # передаём map`у захваченую функцию
    |> Enum.join(" ") # объединение в одну строку и разделение значений пробелом
  end

  defp sanitize_name(name) do # mix greeting joe
    name
    |> String.trim()
    |> String.capitalize()
  end

  # убирает всё что не является строкой, проверить в iex -S mix
  # Backend.Greeter.sanitize_names(["alexey", nil, "students", 12, "nikolay"])
  defp sanitize_names(names) do
    names
    |> Enum.reduce([], fn
        name, acc when is_bitstring(name) -> [name | acc]
        # конструкция [name | acc] это добавление переменной name в список нулевым элементом
        _, acc                            -> acc
      end)
    |> Enum.reverse() # имена добавляются в перёд списка, для возврата правильного
    # порядка нужно список развернуть в обратную сторону
  end

end
