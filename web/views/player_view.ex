defmodule KickerWeb.PlayerView do
  use KickerWeb.Web, :view

  def name(player) do
    case player.nick do
      nil -> "#{player.forename} #{player.surname}"
      nick -> raw "#{player.forename} <span class='nick'>#{nick}</span> #{player.surname}"
    end
  end
end
