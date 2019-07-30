defmodule Mix.Tasks.Greeting do
  use Mix.Task
  use Backend.Greeter
  # require Backend.Greeter # вызываем макросы
  # import Backend.Greeter # то можем использовать concat() и greeting()
  # без указания пути Greeter.
  import Backend.Greeter, only: [concat: 1] # импортируем только нужное, 1 это арность функции

  alias Backend.Greeter #, as: Gtrt
  alias Mix.Shell.IO

  def run(args) do
    greeting = args # здесь используем обращение через макрос
      |> List.first()
      |> (&(&1 || "user")).()
      |> Greeter.greeting()
    greeting + good_wish() # здесь используем use
    # greeting + "Have a nice day!"
    |> concat() # здесь вызываем макрос, без начала в виде Greeter. так как у нас импорт только для макроса
    |> IO.info()

    # name = args # обращение через элиас
    #   |> List.first()
    #   |> (&(&1 || "user")).()
    #   # |> Gtrt.greeting()
    #   |> Greeter.greeting()
    #   |> IO.info()

    # :backend # обращение без элиаса
    # |> Application.fetch_env!(:greeting)
    # |> (&("#{&1}, #{name}!")).()
    # |> Mix.Shell.IO.info()
  end

end
